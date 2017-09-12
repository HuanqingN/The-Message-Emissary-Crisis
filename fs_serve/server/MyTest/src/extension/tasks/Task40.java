package extension.tasks;

import java.util.ArrayList;
import java.util.Arrays;

import extension.cards.Card;

/**
 *手里集齐三张或以上的纳税牌
 */
public class Task40 extends TaskBase{
	@Override
	public Boolean check() {
		if(owner.handcards.size()>=3){
			int count=0;
			for(Card c:owner.handcards){
				if(c.getId()==22)count++;
			}
			return (count>=3);
		}
		return super.check();
	}
}
