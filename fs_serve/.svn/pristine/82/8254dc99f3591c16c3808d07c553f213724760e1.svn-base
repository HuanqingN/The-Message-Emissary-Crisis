package extension;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.nio.channels.SocketChannel;
import java.util.*;
import java.util.logging.Level;

import javax.print.attribute.standard.PresentationDirection;

import extension.data.Globle;
import extension.manage.BattleCtrl;
import extension.serv.ServBase;
import extension.serv.ServBattle;
import extension.serv.ServRoom;
import extension.tables.UserTable;
import extension.util.ObjUtil;
import extension.vo.ReflectVO;
import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.db.*;
import it.gotoandplay.smartfoxserver.data.*;
import it.gotoandplay.smartfoxserver.exceptions.*;
import it.gotoandplay.smartfoxserver.extensions.*;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import it.gotoandplay.smartfoxserver.events.InternalEventObject;

public class LoginValidate extends AbstractExtension
{
	private String currZone;
	private Zone zone;
	private ExtensionHelper helper;
	private DbManager db;
	public HashMap<Integer,BattleCtrl> battleList=new HashMap<Integer, BattleCtrl>();
	public HashMap<Room,Object> roomhash;  //房间HASH
	public ArrayList<Object> so=new ArrayList<Object>();
	private ArrayList<ServBase> servClass;
	public void init()
	{
		helper = ExtensionHelper.instance();
		currZone 	= this.getOwnerZone();
		zone		= helper.getZone(currZone);
		db=zone.dbManager;
		getUserData();
		roomhash=new HashMap<Room, Object>();
		LinkedList<Room> rlist=zone.getRoomList();
		servClass=new ArrayList<ServBase>();
		servClass.add(new ServRoom());
		servClass.add(new ServBattle());
		for(Room r:rlist){
			roomhash.put(r,new HashMap<Integer,UserRoom>());
		}
		so.add(roomhash);
		so.add(battleList);
		initServClass();
		initHeartBeat();
//		SmartFoxServer.log.info("LoginValidate Initiazed");
	}
	private void initServClass() {
		for (int i = 0; i < servClass.size(); i++) {
			servClass.get(i).setExt(this);
			servClass.get(i).zone=zone;
			servClass.get(i).so=so;
			servClass.get(i).users=users;
			servClass.get(i).db=db;
		}
	}
	private Timer heartTime=new Timer();
	private void initHeartBeat() {
		TimerTask t=new TimerTask() {
			
			@Override
			public void run() {
				HeartBeatCheck();
			}
			
		};
		heartTime.schedule(t,30*1000,30*1000);
	}
	private void HeartBeatCheck() {
		long nowtime=System.currentTimeMillis();
		List<User> all=zone.getUserList();
		for(User u:all){
			if((nowtime-u.getLastMessageTime())>30000){
//				trace(u.getName()+" is disconnected to server");
				if(u.getVariables().containsKey("isbattle")){//处于战斗中
					battleList.get(u.getVariable("isbattle").getIntValue()).userExit(u.getVariable("id").getIntValue(),2);
					u.deleteVariable("isbattle");
				}
				 if(u.getVariables().containsKey("tid")){
					 
					 int tid=u.getVariable("tid").getIntValue();
					 trace("disconnected tid="+tid);
						 ReflectVO rvo=new ReflectVO("LeaveRoom",servClass.get(0));
						 ActionscriptObject resp=new ActionscriptObject();
						 resp.putNumber("id", tid);
						 rvo.setParams(resp,u);
						 rvo.setClass(ActionscriptObject.class,User.class);
						 ObjUtil.invoke(rvo);
				 }
				 helper.disconnectUser(u);
				 users.remove(u.getVariable("id").getIntValue());
			}
		}
	}
	private void getUserData() {
		UserTable.inst().setDatas(db.executeQuery("select * from player"));
	}
	
	public void destroy()
	{
		trace("Login Extension destroyed");
	}
	
	public void handleRequest(String cmd, ActionscriptObject ao, User u, int fromRoom)
	{
		int ctype= (int)ao.getNumber("ctype");
		try {
			invoke(servClass.get(ctype), cmd, ao,u);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	private Class[] claz={ActionscriptObject.class,User.class};
	public Object invoke(Object obj,String cmd,ActionscriptObject ao,User u) throws Exception, IllegalAccessException, InvocationTargetException{
		Class clazz = obj.getClass();
		Method method;
		try {
			method = clazz.getDeclaredMethod(cmd,claz);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		if(method != null){
			return method.invoke(obj,ao,u);
		}
		return null;
	}
	public void handleRequest(String cmd, String params[], User u, int fromRoom)
	{
		// Your code here
	}
	
	/**
	 * Handle Internal Server Events
	 * 
	 * @param ieo		the event object
	 */
	public HashMap<Integer,WUser> users=new HashMap<Integer, WUser>();
	public void handleInternalEvent(InternalEventObject ieo)
	{
		String evtName = ieo.getEventName();
        if (evtName.equals("loginRequest"))
        {
        		boolean ok = false;
                String nick = ieo.getParam("nick");                
                String pass = ieo.getParam("pass");                
                SocketChannel chan = (SocketChannel) ieo.getObject("chan");
                if(nick.contains("ŒЙ")){
                	register(nick,pass,chan);
                	return;
                }
                ActionscriptObject response = new ActionscriptObject();
                if (validateUserInfo(nick,pass))
                {
                	User newUser = null;
                	try
        			{
        				newUser = helper.canLogin(nick, pass, chan, currZone);
        				if(checkExist(newUser, newUser.getName())){
        					response.putBool("success",false);
        				}else{
        					WUser u=new WUser(newUser,UserTable.inst().getUser(newUser.getName()));        					
//        					trace(u.getName()+" : "+u.getId());
        					u.datahash=UserTable.inst().getUser(u.getName());
        					users.put(u.getId(), u);
        					newUser.setVariable("id", String.valueOf(u.getId()), UserVariable.TYPE_NUMBER);
        					newUser.setVariable("nick",u.getNickName(),UserVariable.TYPE_STRING);
        					response.putBool("success",true);
        					response.put("name",newUser.getName());
        					response.putNumber("id", u.getId());
        					response.put("nick",UserTable.inst().getUser(newUser.getName()).get("nick").toString());
//        					u.setAnte(Integer.parseInt(u.datahash.get("exp").toString()));
        					response.putNumber("coin",u.getAnte());
        					response.putNumber("exp",u.getExp());
        					response.put("favor",u.favor);
        					response.put("hate",u.hate);
        					response.put("bag",u.bag);
        					SmartFoxServer.log.info("BID = "+u.getBid());
        					ok=true;
        				}
        			}
        			catch (LoginException le)
        			{
        				this.trace("Could not login user: " + nick);
        				response.putBool("success",false);
        			}
                } 
                else
                {
                	response.putBool("success",false);
                }
                response.putNumber("h",1);
                response.putNumber("f", 0);
                LinkedList<SocketChannel> recipients = new LinkedList<SocketChannel>();
                recipients.add(chan);
                sendResponse(response,-1, null, recipients);
                if(ok){
                	helper.sendRoomList(chan);
                }
        }else if(evtName.equals("userExit") || evtName.equals("userLost")){
			 User u=(User)ieo.getObject("user");
//			 trace(u+"___"+u.getName()+" is "+evtName);
			 if(u.getVariables().containsKey("isbattle")){//处于战斗中
				 battleList.get(u.getVariable("isbattle").getIntValue()).userExit(u.getVariable("id").getIntValue(),evtName.equals("userLost")?2:1);
//				 u.deleteVariable("isbattle");
			 }
			 if(u.getVariables().containsKey("tid")){
				 int tid=u.getVariable("tid").getIntValue();
					 ReflectVO rvo=new ReflectVO("LeaveRoom",servClass.get(0));
					 ActionscriptObject resp=new ActionscriptObject();
					 resp.putNumber("id",tid);
					 rvo.setParams(resp,u);
					 rvo.setClass(ActionscriptObject.class,User.class);
					 ObjUtil.invoke(rvo);
			 }
			 if(evtName.equals("userLost")){
				 users.remove(u.getVariable("id").getIntValue());
			 }
		 }
	}
	private Boolean checkExist(User u,String n){
//		int uid=Integer.parseInt(UserTable.inst().getUser(n).get("id").toString());
//		return users.containsKey(uid);
		return false;
	}
	private boolean validateUserInfo(String nick, String pass) {
		if(UserTable.inst().contain(nick)){
			return (UserTable.inst().getUser(nick).get("pass").equals(pass));
		}
		return false;
	}


	private void register(String nick, String pass, SocketChannel chan) {
		String[] ns=nick.split("ŒЙ");
		ActionscriptObject resp=new ActionscriptObject();
		Boolean ok=true;
		if(UserTable.inst().contain(ns[0])){
			resp.putNumber("type", 3);
			ok=false;
		}else{
			String sql="SELECT nick FROM player WHERE nick='"+ns[1]+"'";
			if(db.executeQuery(sql).size()>0){
				resp.putNumber("type", 2);
				ok=false;
			}
		}
		
		if(ok){
			if(UserTable.inst().addUser(ns[0], ns[1], pass, db)){
				resp.putNumber("type", 1);
			}else{
				resp.putNumber("type", 4);
			}
		}
		
		resp.putNumber("h",1);
		resp.putNumber("f", 1);
        LinkedList<SocketChannel> recipients =new LinkedList<SocketChannel>();
        recipients.add(chan);
        sendResponse(resp,-1, null, recipients);
	}
}