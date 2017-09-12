package extension.tasks;

import extension.Player;
import extension.manage.BattleCtrl;

public class TaskBase {
	public BattleCtrl bf;
	public Player owner;
	public void setOwner(Player p){
		owner=p;
		bf=owner.getBf();
	}
	public Boolean check(){
		return false;
	}
}
