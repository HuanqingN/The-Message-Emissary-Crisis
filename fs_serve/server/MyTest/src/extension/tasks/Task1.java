package extension.tasks;

import extension.cards.Card;
import extension.cons.StepCons;

/**
 * 亲手让另一位没有获得纯红和纯蓝情报的玩家死亡
 */
public class Task1 extends TaskBase{
	@Override
	public Boolean check() {
//		if(bf.deadman!=null){
		if(bf.nowGetCardPlayer!=null && bf.nowGetCardPlayer.getIsDead()){
			if(bf.nowGetCards.get(0).getOwner()==owner){
				int pbr=0;
//				for(Card c:bf.deadman.infocards){
				for(Card c:bf.nowGetCardPlayer.infocards){
					if(c.getColor()==1 || c.getColor()==2)pbr++;
				}
				return pbr==0;
			}
		}
		return false;
	}
	
}
