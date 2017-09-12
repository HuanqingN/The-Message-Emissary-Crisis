package extension.tasks;

import extension.cards.Card;
import extension.cons.StepCons;

/**
 *当你死亡时，展示你的手牌，其中有三张或以上的蓝色卡牌
 */
public class Task21 extends TaskBase{
	@Override
	public Boolean check() {
		if(owner.getIsDead() && owner.handcards.size()>=3 ){
			int a=0;
			for(Card c:owner.handcards){
				if(c.getColor()==1 || c.getColor()==5)a++;
			}
			return a>=3;
		}
		return false;
	}
}
