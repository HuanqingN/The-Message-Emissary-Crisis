package extension.serv;

import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.data.Room;
import it.gotoandplay.smartfoxserver.data.User;
import it.gotoandplay.smartfoxserver.data.UserVariable;
import it.gotoandplay.smartfoxserver.data.Zone;
import it.gotoandplay.smartfoxserver.db.DataRow;
import it.gotoandplay.smartfoxserver.db.DbManager;
import it.gotoandplay.smartfoxserver.exceptions.ExtensionHelperException;
import it.gotoandplay.smartfoxserver.exceptions.JoinRoomException;
import it.gotoandplay.smartfoxserver.extensions.AbstractExtension;
import it.gotoandplay.smartfoxserver.extensions.ExtensionHelper;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.awt.geom.Arc2D;
import java.nio.channels.SocketChannel;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.Timer;
import java.util.TimerTask;

import extension.Player;
import extension.SortById;
import extension.Test.DataBaseType;
import extension.UserRoom;
import extension.WUser;
import extension.cons.Err;
import extension.cons.SystemInfoType;
import extension.controller.RoomController;
import extension.controller.RoomController.RoomCtrl;
import extension.data.DPropChild;
import extension.data.Globle;
import extension.manage.BattleCtrl;
import extension.tables.UserTable;
import extension.util.ObjUtil;
import extension.util.StringUtil;
import extension.vo.ReflectVO;

public class ServRoom extends ServBase{
	@Override
	public void setExt(AbstractExtension ext) {
		super.setExt(ext);
		controller=new RoomController(getExt());
	}
	private RoomController controller=null;
	public ServRoom(){
		setAutoSaveData();
	}
	public void BuyProp(ActionscriptObject ao,User u){
		int uid=u.getVariable("id").getIntValue();
		WUser wu=users.get(uid);
		int num=(int)(ao.getNumber("num"));
		int pid=(int)(ao.getNumber("pid"));
		DPropChild dpc=Globle.getPropdata().getHash().get(pid);
		if(dpc==null){
			controller.send(RoomCtrl.ErrorInfo,Err.PropNotExist,u);
			return;
		}
		int sum=dpc.getCv()*num;
		if(wu.getAnte()<sum){
			controller.send(RoomCtrl.ErrorInfo,Err.NotEnoughGold,u);
		}else{
			String bag=wu.datahash.get("bag")==null?"":wu.datahash.get("bag").toString();
			String result = null;
			Boolean isEnd=false;
			Pattern pattern = Pattern.compile(pid+"_.*,");
			Matcher matcher = pattern.matcher(bag);
			if(matcher.find()){
				result=matcher.group(0);
			}else{
				pattern=Pattern.compile(pid+"_.*");
				matcher=pattern.matcher(bag);
				if(matcher.find()){
					isEnd=true;
					result=matcher.group(0);
				}
			}
			int count=0;
			if(result!=null){
				result=result.substring(result.indexOf("_")+1,result.length()-(isEnd?0:1));
				count=(Integer.valueOf(result)+num);
				String nstr=matcher.replaceAll(pid+"_"+count+(isEnd?"":","));
				wu.datahash.put("bag", nstr);
			}else{
				bag+=(bag.equals("")?"":",")+(pid+"_"+num);
				count=num;
				wu.datahash.put("bag", bag);
			}
			SmartFoxServer.log.info("now bag: "+wu.datahash.get("bag"));
			wu.setAnte(wu.getAnte()-sum);
			ActionscriptObject resp=new ActionscriptObject();
			resp.putNumber("pid",pid);
			resp.putNumber("num",count);
			controller.send(RoomCtrl.OnBagUpdata,resp , u);
			ActionscriptObject resp1=new ActionscriptObject();
			resp1.putNumber("num",wu.getAnte());
			controller.send(RoomCtrl.OnMoneyUpdata,resp1 , u);
		}
	}

	public void CheckInBattle(ActionscriptObject ao,User u){
		//		SmartFoxServer.log.info("user id = "+u.getVariable("id").getIntValue());
		int uid=u.getVariable("id").getIntValue();
//		HashMap<Integer,BattleCtrl> blist=getBlist();
//		Iterator<Entry<Integer, BattleCtrl>> iter=blist.entrySet().iterator();
		SmartFoxServer.log.info(getBlist().size()+"场战斗");
		Boolean inBattle=users.get(uid).getBid()>0;
		if(inBattle){
			ActionscriptObject resp=new ActionscriptObject();
			resp.putNumber("h",3);
			resp.putNumber("f",10);
			resp.putNumber("type",SystemInfoType.StillInBattle);
			LinkedList<SocketChannel> rec=new LinkedList<SocketChannel>();
			rec.add(u.getChannel());
			getExt().sendResponse(resp, -1, u,rec);
		}
//		while (iter.hasNext()) {
//			Map.Entry<Integer,BattleCtrl> entry = iter.next();
//			Integer key=entry.getKey();
//			BattleCtrl bc=entry.getValue();
//			if(bc.roleMap.containsKey(uid)){
//				//				SmartFoxServer.log.info("contains this user");
//				ActionscriptObject resp=new ActionscriptObject();
//				resp.putNumber("h",3);
//				resp.putNumber("f",10);
//				resp.putNumber("type",SystemInfoType.StillInBattle);
//				LinkedList<SocketChannel> rec=new LinkedList<SocketChannel>();
//				rec.add(u.getChannel());
//				getExt().sendResponse(resp, -1, u,rec);
//				break;
//			}
//		}
		//		SmartFoxServer.log.info("not contains this user");
	}
	private void setAutoSaveData() {
		Timer timer=new Timer();
		Date date=new Date();
		Calendar cal=Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.DATE, 1);
		cal.set(Calendar.HOUR, 5);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		date=cal.getTime();
		//		SmartFoxServer.log.info("现在的时间是"+date);
		timer.schedule(new TimerTask() {
			@Override
			public void run() {
				//				SmartFoxServer.log.info("我要开始存档啰~");
				SaveAllDatas(null,null);
			}
		}, date);
	}
	public void HeartBeat(ActionscriptObject ao,User u){
	}

	public void SystemInfo(ActionscriptObject ao,User u){
		String msg=ao.getString("msg").toString();
		ActionscriptObject resp=new ActionscriptObject();
		resp.put("msg",msg);
		resp.putNumber("h",3);
		resp.putNumber("f",10);
		resp.putNumber("type",SystemInfoType.ShowMSG);
		getExt().sendResponse(resp, -1, u,zone.getChannelList());
	}
	
	public void ChangeFavor(ActionscriptObject ao,User u){
		int state=(int)(ao.getNumber("state"));
		int self=(int)(ao.getNumber("self"));
		int target=(int)(ao.getNumber("target"));
		WUser wu=users.get(self);
		ActionscriptObject resp=new ActionscriptObject();
		resp.putNumber("h",3);
		resp.putNumber("f",12);
		resp.putNumber("target",target);
		if(state==0){
			if(wu.favor!=null && wu.favor.indexOf(target+",")>=0)wu.favor=wu.favor.replaceFirst(target+",","");
			else if(wu.hate!=null &&wu.hate.indexOf(target+",")>=0)wu.hate=wu.hate.replaceFirst(target+",","");
			if(wu.favor==null || wu.favor.equals(""))wu.favor=null;
			if(wu.hate==null || wu.hate.equals(""))wu.hate=null;
			wu.datahash.put("favor", wu.favor);
			wu.datahash.put("hate", wu.hate);
			resp.putNumber("type",0);
		}else if(state==1){
			if(wu.hate!=null && wu.hate.indexOf(target+",")>=0){
				wu.hate=wu.hate.replaceFirst(target+",","");
				wu.datahash.put("hate", wu.hate);
			}
			if(wu.favor==null)wu.favor="";
			wu.favor+=(target+",");
			wu.datahash.put("favor", wu.favor);
			resp.putNumber("type",1);
		}else if(state==2){
			if(wu.favor!=null && wu.favor.indexOf(target+",")>=0){
				wu.favor=wu.favor.replaceFirst(target+",","");
				wu.datahash.put("favor", wu.favor);
			}
			if(wu.hate==null)wu.hate="";
			wu.hate+=(target+",");
			wu.datahash.put("hate", wu.hate);
			resp.putNumber("type",2);
		}
		LinkedList<SocketChannel> rec=new LinkedList<SocketChannel>();
		rec.add(u.getChannel());
		getExt().sendResponse(resp, -1, u,rec);
	}
	public void SaveAllDatas(ActionscriptObject ao,User u){ 
		HashMap<String, HashMap<String, Object>> map =UserTable.inst().datahash;
		Iterator iter = map.entrySet().iterator();
		while (iter.hasNext()) {
			Map.Entry entry = (Map.Entry) iter.next();
			String key = entry.getKey().toString();
			HashMap<String,Object> val = (HashMap<String,Object>) entry.getValue();
			String sql="UPDATE player SET exp="+val.get("exp")+
					",coin="+val.get("coin")+
					",winCount='"+val.get("winCount")+
					"',duleCount="+val.get("duleCount")+
					",lastWin="+val.get("lastWin")+
					",streak="+val.get("streak")+
					",deathCount="+val.get("deathCount")+
					",killCount="+val.get("killCount")+
					",useRole='"+val.get("useRole")+"'"+
					(val.get("favor")==null?"":",favor='"+val.get("favor")+"'") +
					(val.get("hate")==null?"":",hate='"+val.get("hate")+"'") +
					" WHERE ( name='"+key+"')";
			db.executeCommand(sql);
		}
		SmartFoxServer.log.info("All data is saved .......入库完毕");
	}
	public void GetRoleInfo(ActionscriptObject ao,User u){
		int uid=(int)(ao.getNumber("uid"));
		WUser wu=users.get(uid);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr1=new ActionscriptObject();
		ActionscriptObject arr2=new ActionscriptObject();
		resp.putNumber("streak", wu.streak);
		resp.putNumber("deathCount", wu.deathCount);
		resp.putNumber("duleCount", wu.duleCount);
		resp.putNumber("killCount", wu.killCount);
		resp.putNumber("coin", wu.getAnte());
		resp.putNumber("exp", wu.getExp());
		resp.put("name",wu.getNickName());
		int index=0;
		for(String s:wu.winCount){
			arr1.put(index++,s);
		}
		resp.put("winCount",arr1);
		index=0;
		for(String s:wu.useRole){
			arr2.put(index++,s);
		}
		resp.put("useRole",arr2);
		resp.putNumber("h",3);
		resp.putNumber("f",9);
		LinkedList<SocketChannel> rec=new LinkedList<SocketChannel>();
		rec.add(u.getChannel());
		getExt().sendResponse(resp, -1, u,rec);
	}

	public HashMap<Integer, UserRoom> getUroom(User u){
		Room r = zone.getRoom(u.getRoom());
		if(r!=null)return (HashMap<Integer, UserRoom>)getRoomhash().get(r);
		return null;
	}
	public long lastRankTime=0;
	public ArrayList<DataRow> rankData=new ArrayList<DataRow>();
	public ActionscriptObject rankresp=null;
	public void CheckRank(ActionscriptObject ao,User u){    //获得排行
		//		SELECT * from player ORDER BY exp desc LIMIT 10
		long newRankTime=System.currentTimeMillis();
		if(lastRankTime==0 || (newRankTime-lastRankTime)>=3600000){
			rankData.clear();
			lastRankTime=newRankTime;
			String sql="SELECT * from player ORDER BY coin desc LIMIT 10";
			rankData=db.executeQuery(sql);
			if(rankData.size()>0){
				rankresp=new ActionscriptObject();
				int index=0;
				ActionscriptObject arr=new ActionscriptObject();
				for(DataRow dr:rankData){
					ActionscriptObject obj=new ActionscriptObject();
					obj.putNumber("coin",Integer.parseInt(dr.getItem("coin")));
					obj.put("nick",dr.getItem("nick"));
					obj.putNumber("rank",index+1);
					arr.put(index,obj);
					index++;
				}
				rankresp.put("ranks",arr);
				rankresp.putNumber("h",3);
				rankresp.putNumber("f",8);
			}
		}

		if(rankData.size()>0){
			LinkedList<SocketChannel> rec=new LinkedList<SocketChannel>();
			rec.add(u.getChannel());
			getExt().sendResponse(rankresp, -1, u,rec);
		}
	}
	public void GetTableList(ActionscriptObject ao,User u){    //获得房间列表
		HashMap<Integer, UserRoom> ur = getUroom(u);
		if(ur.size()>0){
			ActionscriptObject response = new ActionscriptObject();
			ActionscriptObject arr= new ActionscriptObject();
			Collection<UserRoom> rooms=ur.values();
			int index=0;
			for(UserRoom rm:rooms){
				ActionscriptObject obj= new ActionscriptObject();
				rm.setRoomInfoResponse(obj);
				arr.put(index, obj);
				index++;
			}
			response.put("rlist", arr);
			response.putNumber("h",3);
			response.putNumber("f",6);
			LinkedList<SocketChannel> rec=new LinkedList<SocketChannel>();
			rec.add(u.getChannel());
			getExt().sendResponse(response, -1, u,rec);
		}
	}
	public void CreateRoom(ActionscriptObject ao,User u) throws ExtensionHelperException, JoinRoomException{
		if(u.getVariables().containsKey("tid"))return;
		int maxu =(int)ao.getNumber("maxU");
		int ante =(int)ao.getNumber("ante");
		int level =(int)ao.getNumber("level");
		int rate =(int)ao.getNumber("rate");
		String password=ao.getString("pass");
		boolean sameip=ao.getBool("sameip");
		//		if(!sameip)ante=0;
		Room r = zone.getRoom(u.getRoom());   //获得room
		HashMap<Integer, UserRoom> ur = getUroom(u);
		if(checkExistInRoomList(ur,u))return;
		ActionscriptObject response = new ActionscriptObject();
		if(ur.size()<r.getMaxUsers()){
			UserRoom uroom=new UserRoom();
			WUser wuser=users.get(u.getVariable("id").getIntValue());
			uroom.setId(getRoomIdByIndex(r.getId()));
			uroom.setRname(wuser.getNickName());
			uroom.setMaxUser(maxu);
			uroom.level=level;
			uroom.rate=rate;
			uroom.password=password;
			uroom.canSameIP=sameip;
			uroom.setAnte(ante);
			u.setVariable("tid", String.valueOf(uroom.getId()), UserVariable.TYPE_NUMBER);//桌台ID
			u.setVariable("rid", String.valueOf(r.getId()),UserVariable.TYPE_NUMBER);     //房间ID
			wuser.position=0;
			uroom.seat[wuser.position]=wuser.getId();
			wuser.isReady=true;
			wuser.isOwner=wuser.getId();
			uroom.addUser(wuser);
			uroom.setOwner(wuser);			
			ur.put(uroom.getId(), uroom);			
			uroom.setRoomInfoResponse(response);
			response.putNumber("h",3);
			response.putNumber("f", 1);
			response.putNumber("type",1);//1加2减3更新
			getExt().sendResponse(response, -1, u,r.getChannellList());
			//发给创建房间的人

			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject arr=new ActionscriptObject();
			ActionscriptObject obj=new ActionscriptObject();
			wuser.setResponse(obj);
			arr.put(0,obj);
			resp.putNumber("h",3);
			resp.putNumber("f",0);
			resp.putNumber("uid",uroom.getOwner().getId());
			resp.putNumber("type",1);
			resp.putNumber("ante",uroom.getAnte());
			resp.putNumber("tid",uroom.getId());
			resp.put("roles",arr);
			getExt().sendResponse(resp, -1, u, wuser.getChannel());
			//			ext.trace("Create room : now rooms count : "+ur.size());
		}else{

		}
	}

	private boolean checkExistInRoomList(HashMap<Integer, UserRoom> ur,User u) {
		if(ur.size()==0)return false;
		Collection<UserRoom> temp=ur.values();
		for(UserRoom urm:temp){
			if(urm.getUserHash().containsKey(u.getVariable("id").getIntValue()))return true;
		}
		return false;
	}
	public void LeaveRoom(ActionscriptObject ao,User user){  //离开房间
		//		SmartFoxServer.log.info("LeaveRoom LeaveRoom");
		int tid=(int)ao.getNumber("id");
		int uid=(int)ao.getNumber("uid");
		boolean iskick=ao.getBool("iskick");

		User u=uid==0?user:users.get(uid).getUser();
		if(!u.getVariables().containsKey("rid"))return;
		int rid=u.getVariable("rid").getIntValue();
		Room r = zone.getRoom(rid);   //获得room
		HashMap<Integer, UserRoom> ur=(HashMap<Integer, UserRoom>)getRoomhash().get(r);

		UserRoom uroom = ur.get(tid);
		if(uroom==null)return;
		WUser newowner=null;
		WUser nowuser=null;
		Boolean allleave=false;
		nowuser =uroom.getUserHash().get(u.getVariable("id").getIntValue());
		int seat=-1;
		if(nowuser!=null){
			seat=clearPositionInRoom(nowuser.getId(),uroom);
			uroom.removeUser(nowuser.getId());
			if(uroom.getUserHash().size()<1){
				allleave=true;
				ur.remove(tid).dispose();
			}else if(nowuser.isOwner>-1){
				newowner=setNewOwner(uroom);
			}
			nowuser.isOwner=-1;
			nowuser.isReady=false;
		}
		//		SmartFoxServer.log.info("!!!!!!!!!!!!!!!!!! delete tid ing.....");
		u.deleteVariable("tid");
		u.deleteVariable("rid");
		//		SmartFoxServer.log.info(u+" deleted and tid is ::: "+u.getVariables().containsKey("tid"));
		if(nowuser!=null){
			ActionscriptObject resp=new ActionscriptObject();
			resp.putNumber("h",3);
			resp.putNumber("f", 1);
			if(allleave){
				resp.putNumber("type", 2);
				resp.putNumber("rid", tid);
			}else{
				resp.putNumber("type", 3);
				resp.putNumber("rid",tid);
				resp.put("rcount", uroom.getUserHash().size()+"/"+uroom.getMaxUser());
			}
			getExt().sendResponse(resp,-1,null,r.getChannellList());  //给所有人

			resp=new ActionscriptObject();
			resp.putNumber("h",3);
			resp.putNumber("f",0);
			resp.putBool("iskick",iskick);
			resp.putNumber("type",2);
			resp.putNumber("uid",nowuser.getId());
			resp.putNumber("seat",seat);
			if(allleave)
				getExt().sendResponse(resp,-1,null,nowuser.getChannel()); //给房间的人用户离开
			else{
				getExt().sendResponse(resp,-1,null,nowuser.getChannel()); //给房间的人用户离开
				getExt().sendResponse(resp,-1,null,uroom.getAllChannel()); //给房间的人用户离开
			}

			if(newowner!=null){
				resp=new ActionscriptObject();
				resp.putNumber("h",3);
				resp.putNumber("f",0);
				resp.putNumber("type",3);
				resp.putNumber("seat",newowner.position);
				ActionscriptObject obj=new ActionscriptObject();
				newowner.setResponse(obj);
				resp.put("datas", obj);
				getExt().sendResponse(resp,-1,null,uroom.getAllChannel());//给房间的人更新新桌主
			}
		}
	}
	private WUser setNewOwner(UserRoom ur) { //设置新的桌主
		for(WUser u:ur.getUserlist()){
			u.isOwner=u.getId();
			ur.setOwner(u);
			u.isReady=true;
			return u;
		}
		return null;
	}
	private Boolean existInRoom(UserRoom ur,User u){
		return ur.getUserHash().containsKey(u.getVariable("id").getIntValue());
	}
	public void JoinRoom(ActionscriptObject ao,User u){
		int tid=(int)ao.getNumber("id");
		String pass=ao.getString("pass");
		Room r = zone.getRoom(u.getRoom());   //获得room
		HashMap<Integer, UserRoom> ur = (HashMap<Integer, UserRoom>)getRoomhash().get(r);
		UserRoom uroom = ur.get(tid);
		if(uroom!=null){
			if(existInRoom(uroom,u))return;   //如果已经在房间返回
			if(uroom.getUserHash().size() >= uroom.getMaxUser())return;  //如果房间满了返回
			if(uroom.getIsBattle())return;    //如果在战斗中返回 
			WUser wuser=users.get(u.getVariable("id").getIntValue());
			int err=canJoinThisRoom(uroom,wuser,pass);
			if(err>0){
				ActionscriptObject response = new ActionscriptObject();
				response.putNumber("h",3);
				response.putNumber("f",11);
				response.putNumber("type",err);
				getExt().sendResponse(response, -1,null,wuser.getChannel());
				return;
			}
			wuser.position=getPositionInRoom(uroom);
			uroom.seat[wuser.position]=wuser.getId();
			uroom.addUser(wuser);
			u.setVariable("tid", String.valueOf(tid), "int");
			u.setVariable("rid", String.valueOf(r.getId()), "int");
			//self
			ActionscriptObject response = new ActionscriptObject();
			ActionscriptObject arr = new ActionscriptObject();
			response.putNumber("h",3);
			response.putNumber("f",0);
			response.putNumber("type",1);
			response.putNumber("uid",uroom.getOwner().getId());
			response.putNumber("tid",tid);
			for(WUser wus:uroom.getUserlist()){
				ActionscriptObject obj = new ActionscriptObject();
				wus.setResponse(obj);
				//				obj.putNumber("isban",uroom.ban[wuser.position]);
				arr.put(wus.position,obj);
			}
			response.put("bans",StringUtil.join(uroom.ban, ','));
			response.put("roles",arr);
			getExt().sendResponse(response, -1,null,wuser.getChannel());//发给自己同房

			response=new ActionscriptObject();  
			response.putNumber("h",3);
			response.putNumber("f",0);
			response.putNumber("type",1);
			response.putNumber("uid",uroom.getOwner().getId());
			response.putNumber("tid",tid);
			arr=new ActionscriptObject();
			ActionscriptObject obj = new ActionscriptObject();
			wuser.setResponse(obj);
			arr.put(wuser.position,obj);
			response.put("roles",arr);
			for(WUser wu:uroom.getUserlist()){
				if(wu.getId()!=wuser.getId()){
					getExt().sendResponse(response, -1,null,wu.getChannel());//发给同房我的
				}
			}
			//other
			response=new ActionscriptObject();
			response.putNumber("h",3);
			response.putNumber("f",1);
			response.putNumber("type",3);
			response.putNumber("rid",tid);
			response.put("rcount", uroom.getUserHash().size()+"/"+uroom.getMaxUser());
			getExt().sendResponse(response,-1,null,r.getChannellList());//发给所有人人数变

			//			ext.trace("Join room : now rooms count : "+ur.size());
		}
	}
	private int canJoinThisRoom(UserRoom uroom, WUser wuser,String pass) {
		if(!pass.equals(uroom.password))return 1;
		if(wuser.getRate()<uroom.rate)return 2;
		if(wuser.getAnte()<uroom.getAnte())return 3;
		if(wuser.getLevel()*100<uroom.getAnte())return 5;
		if(uroom.canSameIP && uroom.containsIP(wuser.getUser().getIpAddress()))return 4;
		return 0;
	}
	@SuppressWarnings("unchecked")
	public void QuickJoin(ActionscriptObject ao,User u){    //准备
		if(u.getVariables().containsKey("tid"))return;
		Room r = zone.getRoom(u.getRoom());   //获得room
		HashMap<Integer, UserRoom> ur = (HashMap<Integer, UserRoom>)getRoomhash().get(r);
		Collection<UserRoom> rooms=ur.values();
		if(ur.size()>0){
			UserRoom temp=getRightRoom(rooms,u);
			if(temp!=null){
				ActionscriptObject obj=new ActionscriptObject();
				obj.putNumber("id",temp.getId());
				JoinRoom(obj,u);
				return;
			}
		}
		ActionscriptObject obj=new ActionscriptObject();
		obj.putNumber("maxU",8);
		try {
			CreateRoom(obj,u);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	private SortById sbi=new SortById();
	private UserRoom getRightRoom(Collection<UserRoom> ur,User u){
		WUser user=users.get(u.getVariable("id").getIntValue());
		ArrayList<UserRoom> temp=new ArrayList<UserRoom>();
		for(UserRoom r:ur){
			temp.add(r);
		}
		Collections.sort(temp,sbi);
		for(UserRoom r:temp){
			if(r.getIsBattle() || r.getMaxUser()==r.getUserHash().size() || canJoinThisRoom(r,user,"")>0){
				continue;
			}else{
				return r;
			}
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	public void ChangeBan(ActionscriptObject ao,User u){    //准备
		int jid=(int)ao.getNumber("id");
		int index=(int)ao.getNumber("index");
		int ban=(int)ao.getNumber("ban");
		Room r = zone.getRoom(u.getRoom());   //获得room
		HashMap<Integer, UserRoom> ur = (HashMap<Integer, UserRoom>)getRoomhash().get(r);
		UserRoom uroom = ur.get(jid);
		if(uroom==null)return;

		uroom.ban[index]=ban;
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		resp.putNumber("h",3);
		resp.putNumber("f",4);
		for (int i = 0; i < uroom.ban.length; i++) {
			arr.putNumber(i,uroom.ban[i]);
		}
		resp.put("ban",arr);
		getExt().sendResponse(resp, -1, null, uroom.getAllChannel());

		resp=new ActionscriptObject();
		resp.putNumber("h",3);
		resp.putNumber("f", 1);
		resp.putNumber("rid", jid);
		resp.putNumber("type",3);//1加2减3更新
		resp.put("rcount", uroom.getUserHash().size()+"/"+uroom.getMaxUser());
		getExt().sendResponse(resp, -1, u,r.getChannellList());

		checkAllReady(uroom);
	}
	@SuppressWarnings("unchecked")
	public void DoReady(ActionscriptObject ao,User u){    //准备
		int jid=(int)ao.getNumber("id");
		Room r = zone.getRoom(u.getRoom());   //获得room
		HashMap<Integer, UserRoom> ur = (HashMap<Integer, UserRoom>)getRoomhash().get(r);
		UserRoom uroom = ur.get(jid);
		if(uroom==null)return;
		WUser nowUser=uroom.getUserById(u.getVariable("id").getIntValue());
		if(nowUser!=null){
			nowUser.isReady=!nowUser.isReady;
			ActionscriptObject response=new ActionscriptObject();
			response.putNumber("h",3);
			response.putNumber("f",0);
			response.putNumber("type",3);
			response.putNumber("seat",nowUser.position);
			ActionscriptObject obj=new ActionscriptObject();
			obj.putBool("isReady",nowUser.isReady);
			response.put("datas", obj);
			getExt().sendResponse(response, -1, u,uroom.getAllChannel());
		}

		checkAllReady(uroom);
	}

	private void checkAllReady(UserRoom uroom){
		Boolean allready=(uroom.getMaxUser()==uroom.getUserlist().size());
		if(allready)allready=uroom.isAllReady();
		WUser owner=uroom.getOwner();
		ActionscriptObject response1=new ActionscriptObject();
		response1.putNumber("h",3);
		response1.putNumber("f",0);
		response1.putNumber("type",3);
		response1.putNumber("seat",uroom.getOwner().position);
		ActionscriptObject obj=new ActionscriptObject();
		obj.putBool("begin",allready);
		response1.put("datas", obj);
		getExt().sendResponse(response1, -1, null,owner.getChannel());
	}
	public void GetBattleDatas(ActionscriptObject ao,User u){
		int uid=u.getVariable("id").getIntValue();
		int type=(int)ao.getNumber("type");
		if(type==0){  //0 重连
			BattleCtrl bc=getBlist().get(users.get(uid).getBid());
			if(bc!=null){
				SmartFoxServer.log.info("added to wait data list user id is "+uid);
				bc.roleMap.get(uid).getUser().setUser(u);
				bc.uRoom.getAllChannel().add(u.getChannel());
				bc.waitDataUsers.add(uid);
			}
		}else{
			users.get(uid).setBid(0);
		}
	}
	@SuppressWarnings("unchecked")
	public void StartBattle(ActionscriptObject ao,User u) throws Exception{   //开始战斗
		int tid=(int)ao.getNumber("id");
		if(getBlist().containsKey(tid))return;
		Room r = zone.getRoom(u.getRoom());   //获得room
		HashMap<Integer, UserRoom> ur = (HashMap<Integer, UserRoom>)getRoomhash().get(r);
		UserRoom uroom = ur.get(tid);
		BattleCtrl bf=new BattleCtrl();
		getBlist().put(tid,bf);
		uroom.setIsBattle(true);
		//		SmartFoxServer.log.info("----------------------------------------");
		//		SmartFoxServer.log.info("before battle user size= " +uroom.getUserHash().size());
		//		int maxAnte=0;
		for(WUser wu:uroom.getUserlist()){   //把该间的用户战斗状态设置为当前的桌台ID
			wu.getUser().setVariable("isbattle", String.valueOf(tid), "int");
			wu.setBid(tid);
			wu.isReady=false;
			//			wu.setAnte(wu.getAnte()-uroom.getAnte());
			//			maxAnte+=uroom.getAnte();
			wu.isbattle=true;
		}
		bf.initData(this.zone,zone.getExtension("login"),uroom,uroom.getUserHash().size());
		ActionscriptObject response=new ActionscriptObject();
		response.putNumber("h",3);
		response.putNumber("f",1);
		response.putNumber("rid",tid);
		response.putNumber("type", 3);
		response.put("status","战斗中");
		getExt().sendResponse(response, -1, u,r.getChannellList());

		ReflectVO rvo=new ReflectVO("EndBattle",this);
		rvo.setParams(bf,tid);
		rvo.setClass(BattleCtrl.class,int.class);
		bf.endCall=rvo;
		//		bf.initRoleInfo();
		bf.start();
	}
	public void EndBattle(BattleCtrl bf,int tid){

		UserRoom uroom = bf.uRoom;
		for(Player p:bf.roleSeq){
			p.getUser().getUser().deleteVariable("isbattle");
			if(p.getUser().getBid()==tid)
				p.getUser().setBid(0);
		}
		//		for(WUser u:uroom.getUserlist()){
		//			u.getUser().deleteVariable("isbattle");
		//		}
		if(uroom.getUserHash()!=null && uroom.getUserHash().size()>0){
			ActionscriptObject resp=new ActionscriptObject();
			resp.putNumber("h",3);
			resp.putNumber("f",1);
			resp.putNumber("rid",uroom.getId());
			resp.putNumber("type", 3);
			resp.put("status","准备中");
			getExt().sendResponse(resp, -1, null,zone.getRoom(uroom.getOwner().getUser().getRoom()).getChannellList());
		}
		bf.dipose();
		bf=null;
		getBlist().remove(tid);
		System.gc();
	}
	private HashMap<Integer,ArrayList<Integer>> roomIndex;
	private int getRoomIdByIndex(int index){
		if(roomIndex == null){
			roomIndex = new HashMap<Integer, ArrayList<Integer>>();
		}
		if(roomIndex.containsKey(index)){

		}else{
			roomIndex.put(index,new ArrayList<Integer>());
		}
		ArrayList<Integer> al = roomIndex.get(index);
		if(al.size()==0){
			al.add(1);
			return 1;
		}else{
			int s=al.size();
			int i;
			for(i=1;i<=s;i++){
				if(al.contains(i)==false){
					al.add(i);
					return i;
				}
			}
			al.add(i);
			return i;			
		}
	}
	private int getPositionInRoom(UserRoom uroom) {
		int len=uroom.seat.length;
		for (int j = 0; j < len; j++) {
			if(uroom.seat[j]<0 && uroom.ban[j]==0)return j;
		}
		return -1;
	}

	private int clearPositionInRoom(int uid,UserRoom uroom){
		int len=uroom.seat.length;
		for (int i = 0; i < len; i++) {
			if(uroom.seat[i]==uid){
				uroom.seat[i]=-1;
				return i;
			}
		}
		return -1;
	}
}
