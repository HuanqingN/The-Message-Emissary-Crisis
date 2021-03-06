package extension.tasks;

import extension.cards.Card;

/**
 *手牌集齐七张黑情报
 */
public class Task31 extends TaskBase{
	@Override
	public Boolean check() {
		if(!owner.getIsDead() && owner.handcards.size()>=7){
			int count=0;
			for(Card c:owner.handcards){
				if(c.getColor()>2)count++;
			}
			return count>=7;
		}
		return super.check();
	}
}
