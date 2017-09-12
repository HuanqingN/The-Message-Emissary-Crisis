package extension.tasks;

import java.util.ArrayList;

import extension.cards.Card;

/**
 *手牌收齐六张不同功能的卡牌
 */
public class Task27 extends TaskBase{
	@Override
	public Boolean check() {
		if(!owner.getIsDead()){
			ArrayList<Integer> temp=new ArrayList<Integer>();
			if(owner.handcards.size()>=6){
				for(Card c:owner.handcards){
					if(c.getId()>12)continue;
					if(temp.indexOf(c.getId())<0){
						temp.add(c.getId());
					}
				}
				return temp.size()>=6;
			}
		}
		return super.check();
	}
}
