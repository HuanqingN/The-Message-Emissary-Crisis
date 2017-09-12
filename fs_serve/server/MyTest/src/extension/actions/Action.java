package extension.actions;

import extension.Player;
import extension.cons.StepCons;
import extension.manage.BattleCtrl;
import extension.vo.TargetVO;

public class Action {
	private Player owner;
	private TargetVO tvo;
	public BattleCtrl bf;
	public Player getOwner() {
		return owner;
	}
	public void dispose(){
		tvo=null;
		owner=null;
		bf=null;
	}
	public void setOwner(Player owner) {
		this.owner = owner;
		if(owner!=null)bf=owner.getBf();
	}
	
	public boolean isAnswer() {
		if(bf.subStep>0){
			return bf.subStep==StepCons.CardLaunch;
		}
		return true;
	}
	
	public boolean noAnswer(){
		return bf.subStep==0;
	}
	public boolean self() {
		return owner.getUid() == bf.nowPlayer.getUid();
	}
	public Boolean check() {
		return null;
	}

	public void play(TargetVO tvo) {
		this.setTvo(tvo);
	}

	public TargetVO getTvo() {
		return tvo;
	}

	public void setTvo(TargetVO tvo) {
		this.tvo = tvo;
	}
}
