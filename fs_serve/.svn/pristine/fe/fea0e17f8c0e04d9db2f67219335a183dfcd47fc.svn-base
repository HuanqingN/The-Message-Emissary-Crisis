package extension.tasks;

import extension.cards.Card;
import extension.cons.StepCons;

/**
 *当你死亡时，展示你的手牌，其中有三张或以上的红色卡牌
 */
public class Task16 extends TaskBase{
	@Override
	public Boolean check() {
		if(owner.getIsDead() && owner.handcards.size()>=3){
			int a=0;
			for(Card c:owner.handcards){
				if(c.getColor()==2 || c.getColor()==4)a++;
			}
			return a>=3;
		}
		return false;
	}
}
