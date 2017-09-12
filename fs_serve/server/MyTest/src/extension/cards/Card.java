package extension.cards;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.actions.Action;
import extension.data.Globle;
import extension.vo.TargetVO;

public class Card {
	private int id;
	private int vid;//虚ID，为卡组所有牌的临时ID
	private Player owner=null;//所属玩家
	public Action actions=null;
	private int color;//颜色 1红 2蓝 3黑 4蓝黑 5红黑
	private int send;//传递方式   0密电1直达2文本
	private Boolean canUse=false;
	public int orgSend=-1; //原来的传递方式
	public int orgId=0; //原来的id
	public int orgColor=0; //原来的颜色
	public Boolean shared=false;//是否被公开
	public Boolean security=false;//是否被加密
	public Boolean heishui=false;//是否受黑水技能保护
	public int getTurn=0; //获得此情报的回合
	public Boolean byMiju=false;
	public Boolean byXundao=false;
	public int getColor() {
		return color;
	}
	public void setColor(int color) {
		this.color = color;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
		initAction();
	}
	public Player getOwner() {
		return owner;
	}
	public void setOwner(Player owner) {
		this.owner = owner;
		if(actions!=null){
			actions.setOwner(owner);
		}
	}
	public int getVid() {
		return vid;
	}
	public void setVid(int vid) {
		this.vid = vid;
	}
	public Action getActions() {
		return actions;
	}
	public void setActions(Action actions) {
		this.actions = actions;
		if(owner!=null)actions.setOwner(owner);
	}
	public void initAction(){
	}
	public void play(TargetVO tvo) {  //卡牌生效进行处理
		actions.play(tvo);
	}
	public void setResponse(ActionscriptObject resp) {
		resp.putNumber("color", color);
		resp.putNumber("vid", vid);
		resp.putNumber("id", id);
		resp.putNumber("send", send);
	}
	public int getSend() {
		return send;
	}
	public void setSend(int send) {
		this.send = send;
	}
	public Boolean getCanUse() {
		return canUse;
	}
	public void setCanUse(Boolean canUse) {
		this.canUse = canUse;
	}
}
