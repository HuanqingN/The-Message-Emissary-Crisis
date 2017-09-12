package extension.tasks;

import extension.cards.Card;
import extension.cons.StepCons;
/**
 *获得三张或以上的蓝情报或者三张或以上的红情报，且你面前的情报缺少某种颜色
 */
public class Task28 extends TaskBase{
	@Override
	public Boolean check() {
		if(!owner.getIsDead() && (owner.blueCards.size()>=3 || owner.redCards.size()>=3)){
			 if(owner.blueCards.size()==0 || owner.redCards.size()==0 || owner.blackCards.size()==0){
				 return true;
			 }
		}
		return super.check();
	}
}
