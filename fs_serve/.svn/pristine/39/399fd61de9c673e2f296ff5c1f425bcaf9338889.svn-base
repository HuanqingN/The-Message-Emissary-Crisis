package extension.tasks;

import extension.Player;
import extension.cons.StepCons;

/**
 *亲手杀死一位中毒的玩家
 */
public class Task33 extends TaskBase{
	@Override
	public Boolean check() {
		if(bf.deadman!=null){
			if(owner.getIsDead()==false && bf.nowGetCardPlayer!=null && bf.nowGetCards.size()>0 && bf.nowGetCards.get(0).getOwner()==owner && !owner.getIsDead()){
				return (bf.nowGetCardPlayer.isPoison>0);
			}
		}
		return super.check();
	}
}
