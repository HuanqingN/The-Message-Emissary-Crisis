package extension.tasks;

import extension.cards.Card;
import extension.cons.StepCons;

/**
 *获得六张或以上的任意情报
 */
public class Task10 extends TaskBase{
	@Override
	public Boolean check() {
		if(!owner.getIsDead()){
			int d=0;
			for(Card c:owner.infocards){
				if(c.getColor()==4 || c.getColor()==5){
					d++;
				}
			}
			return (owner.blackCards.size()+owner.redCards.size()+owner.blueCards.size()-d)>=6;
		}
		return false;
	}
}