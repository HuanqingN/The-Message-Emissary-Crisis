package extension;

import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.data.User;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.nio.channels.SocketChannel;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;

import extension.data.Globle;
import extension.tables.UserTable;
import extension.util.StringUtil;

public class WUser{
	private User user;
	public int position=0;//位置
	public Boolean isReady=false;
	public int isOwner=-1;
	public HashMap<String,Object> datahash=null;
	public boolean isbattle;
	private int id;
	private int ante; //钱
	private int exp;
	
	public int lastWin; //最后胜利数
	public int streak;   //连胜次数
	public int duleCount;//总局数
	public int deathCount;//死亡数
	public int killCount;//杀人数
	public String[] winCount=new String[3];//胜利数
	public String[] useRole;  //使用角色
	public String favor;  //喜欢玩家
	public String hate;  //讨厌玩家
	public String bag;  //背包
	private int bid; //战斗桌台ID
	public WUser(User u,HashMap<String,Object> data){		
		if(u!=null && data!=null){
			this.user=u;
			datahash=data;
			id=Integer.parseInt(data.get("id").toString());
			if(datahash!=null){
				if(datahash.get("bid")!=null){
					this.bid=Integer.valueOf(datahash.get("bid").toString());
				}else{
					this.bid=0;
				}
				lastWin=Integer.parseInt(data.get("lastWin").toString());
				streak=Integer.parseInt(data.get("streak").toString());
				duleCount=Integer.parseInt(data.get("duleCount").toString());
				deathCount=Integer.parseInt(data.get("deathCount").toString());
				setAnte(Integer.parseInt(data.get("coin").toString()));
				setExp(Integer.parseInt(data.get("exp").toString()));
				killCount=Integer.parseInt(data.get("killCount").toString());
				if(data.get("winCount").equals("null")){
					winCount="0,0,0".split(",");
				}else{
					winCount=data.get("winCount").toString().split(",");
				}
				if(data.get("useRole").equals("null")){
					int len=100;
					useRole=new String[len];
					for (int i = 0; i < len; i++) {
						useRole[i]="0";
					}
				}else{
					useRole=data.get("useRole").toString().split(",");
					int len=100;
					if(useRole.length<len){
						String[] temp=new String[len];
						System.arraycopy(useRole, 0, temp, 0, useRole.length);
						for(int i=useRole.length;i<len;i++){
							temp[i]="0";
						}
						useRole=temp;
					}
				}
				if(data.get("favor")!=null && !data.get("favor").equals("null")){
					favor=data.get("favor").toString();
				}
				if(data.get("hate")!=null && !data.get("hate").equals("null")){
					hate=data.get("hate").toString();
				}
				if(data.get("bag")!=null && !data.get("bag").equals("null")){
					bag=data.get("bag").toString();
				}
			}
		}
	}
	public static int[] levelTable=null;
	public int getLevel(){
		if(levelTable==null){
			levelTable=new int[101];
			for (int i = 1; i <= 100; i++) {
				if(i<=20)
					levelTable[i]=(int) (2.5*Math.pow(i,2)-2.5*i);
				else
					levelTable[i]=(int) Math.floor( Math.pow(2.5*Math.pow(i,2)-2.5*i,1.05)-Math.pow(i,2));
			}
		}
		for (int i = 1; i <= 100; i++) {
			if(exp<levelTable[i])return (i-1);
		}
		return 100;
	}
	public int getRate(){
		float wincount=0;
		for(String s:winCount){
			wincount+=Integer.parseInt(s);
		}
		return (int)((wincount/duleCount)*100);
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
		if(sc!=null){
			sc.clear();
			sc.add(user.getChannel());
		}
	}
	public int getUserId() {
		return user.getUserId();
	}
	public String getName() {
		return user.getName();
	}
	private LinkedList<SocketChannel> sc=null;
	public LinkedList<SocketChannel> getChannel() {
		if(sc==null){
			sc=new LinkedList<SocketChannel>();
			sc.add(user.getChannel());
		}
		return sc;
	}
	
	public void setResponse(ActionscriptObject resp){
		resp.put("name",getNickName());
//		resp.putNumber("id", getUserId());
		resp.putNumber("id", getId());
		resp.putBool("isReady", isReady);
		resp.putNumber("isOwner", isOwner);
	}

	public String getNickName() {
		return datahash.get("nick").toString();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getAnte() {
		return ante;
	}

	public void setAnte(int ante) {
		this.ante = ante;
	}
	
	public int getExp(){
		return exp;
	}
	
	public void setExp(int exp){
		this.exp = exp;
	}
	public int getBid() {
		return bid;
	}
	public void setBid(int bid) {
		this.bid=bid;
		datahash.put("bid", bid);
	}
	
}
