package extension;

import java.nio.channels.SocketChannel;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import it.gotoandplay.smartfoxserver.data.User;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import javax.xml.bind.JAXBContext;

import extension.tables.UserTable;
public class UserRoom {
	private String rname;
	private int maxUser;
	private HashMap<Integer,WUser> userlist = new HashMap<Integer,WUser>();
	private WUser owner;
	public int[] seat={-1,-1,-1,-1,-1,-1,-1,-1};
	public int[] ban={0,0,0,0,0,0,0,0};
	private Boolean isBattle=false;
	private int id;
	private int ante=100;//赌金
	private LinkedList<SocketChannel> allchannel=new LinkedList<SocketChannel>();
	public int level=1;//等级限制
	public int rate=1;//胜率限制
	public String password="";//密码
	public boolean canSameIP=true;//true 不允许 false 允许    是否允许同IP进入
	public void dispose(){
		userlist.clear();allchannel.clear();
		allchannel=null;userlist=null;seat=null;ban=null;owner=null;
	}
	public Collection<WUser> getUserlist() {
		return userlist.values();
	}
	public void setUserlist(HashMap<Integer,WUser> userlist) {
		this.userlist = userlist;
	}
	public HashMap<Integer,WUser> getUserHash(){
		return userlist;
	}
	public WUser getOwner() {
		return owner;
	}
	public void setOwner(WUser owner) {
		this.owner = owner;
	}
	public String getRname() {
		return rname;
	}
	/**房间名**/
	public void setRname(String rname) {
		this.rname = rname;
	}
	public int getMaxUser() {
		return getBanLen();
//		return maxUser;
	}
	public void setMaxUser(int maxUser) {
		this.maxUser = maxUser;
	}
	
	public void addUser(WUser user){
		userlist.put(user.getId(), user);
		allchannel.add(user.getUser().getChannel());
	}
	
	public void removeUser(int uid){
		WUser user=userlist.remove(uid);
		allchannel.remove(user.getUser().getChannel());
	}
	public int getBanLen(){
		int count=0;
		for(int i:ban){
			if(i==0)count++;
		}
		return count;
	}
	public void setResponse(ActionscriptObject response) {
		response.put("rname", getRname());
		response.putNumber("maxuser", getMaxUser());
		response.putNumber("id", getId());
		response.putNumber("ownerid",owner.getId());
		response.put("ownername",owner.datahash.get("nick").toString());
		response.putNumber("min",userlist.size());
		response.putNumber("max",getMaxUser());
		response.putBool("isBattle",getIsBattle());
		
		ActionscriptObject ulist=new ActionscriptObject();
		int index=0;
		Collection<WUser> temp=userlist.values();
		for(WUser u:temp){
			ActionscriptObject item=new ActionscriptObject();
			u.setResponse(item);
			ulist.put(index++,item);
		}
		response.put("ulist", ulist);
	}
	
	public void setRoomInfoResponse(ActionscriptObject response) {  //只设置房间基础信息  大厅数据
		response.put("rname", getRname()+"的房间");
		response.putNumber("rid", getId());
		response.put("status",getIsBattle()?"战斗中":"准备中");
		response.put("rcount",userlist.size()+"/"+getMaxUser());
		response.put("limit",getAnte()+"/1/"+rate+"%");
		response.put("isLock",!password.equals(""));
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Boolean getIsBattle() {
		return isBattle;
	}
	public void setIsBattle(Boolean isBattle) {
		this.isBattle = isBattle;
	}
	public LinkedList<SocketChannel> getAllChannel() {
//		LinkedList<SocketChannel> temp=new LinkedList<SocketChannel>();
//		for(WUser u:getUserlist()){
//			temp.add(u.getUser().getChannel());
//		}
		return allchannel;
	}
	
	public WUser getUserById(int param){
		for(WUser u:getUserlist()){
			if(u.getId()==param){
				return u;
			}
		}
		return null;
	}
	
	public Boolean isAllReady(){
		Boolean b=true;
		for(WUser u:getUserlist()){
			if(b){
				b=u.isReady;
			}else{
				break;
			}
		}
		return b;
	}
	public int getAnte() {
		return ante;
	}
	public void setAnte(int ante) {
		this.ante = ante;
	}
	public boolean containsIP(String ipAddress) {
			Iterator iter = userlist.entrySet().iterator();
			while (iter.hasNext()) {
				Map.Entry entry = (Map.Entry) iter.next();
				Integer key = (Integer)entry.getKey();
				WUser val = (WUser) entry.getValue();
				if(val.getUser().getIpAddress().equals(ipAddress))return true;
			}
		return false;
	}
}
