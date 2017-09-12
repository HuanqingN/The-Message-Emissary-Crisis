package extension.tasks;

import extension.cards.Card;

/**
 *手牌齐集五张锁定
 */
public class Task34 extends TaskBase{

	@Override
	public Boolean check() {
		if(owner.handcards.size()>=5){
			int b=0;
			for(Card c:owner.handcards){
				if(c.getId()==1)b++;
			}
			return (b>=5);
		}
		return super.check();
	}

}
