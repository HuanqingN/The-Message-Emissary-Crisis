package extension.tasks;

import extension.cards.Card;
import extension.cons.StepCons;

/**
 *亲手让另外一位获得三张或以上红蓝情报的玩家死亡
 */
public class Task15 extends TaskBase{
	@Override
	public Boolean check() {
//		if(bf.deadman!=null){
//		if(bf.willDead==bf.nowGetCardPlayer){
		if(bf.nowGetCardPlayer!=null && bf.nowGetCardPlayer.getIsDead() && !owner.getIsDead()){
			if(bf.nowGetCards.get(0).getOwner()==owner){
				int d=0;
				for(Card c:bf.nowGetCards){
					if(c.getColor()==4 || c.getColor()==5){
						d++;
					}
				}
				if((bf.nowGetCardPlayer.blueCards.size()+ bf.nowGetCardPlayer.redCards.size()- d)>=3)
				return true;
			}
		}
		return super.check();
	}
}
