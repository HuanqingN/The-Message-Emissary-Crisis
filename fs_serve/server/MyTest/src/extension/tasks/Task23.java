package extension.tasks;

import extension.cons.StepCons;

/**
 *亲手让一位没有手牌的玩家死亡
 */
public class Task23 extends TaskBase{
	@Override
	public Boolean check() {
		if(bf.nowGetCardPlayer!=null && bf.nowGetCardPlayer.getIsDead() && bf.nowGetCards.size()>0 && bf.nowGetCards.get(0).getOwner()==owner && !owner.getIsDead() && bf.thirdStep!=StepCons.AfterDeadTaskCheck){
			if(bf.nowGetCardPlayer.handcards.size()==0){
				return true;
			}
		}
		return false;
	}
}
