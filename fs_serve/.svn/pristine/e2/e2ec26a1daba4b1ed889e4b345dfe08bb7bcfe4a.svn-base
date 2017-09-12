package extension.tasks;

import java.util.ArrayList;
import java.util.Arrays;

import extension.cards.Card;

/**
 *手里集齐九张手牌，其中包括红色和蓝色卡牌各至少三张
 */
public class Task42 extends TaskBase{
	@Override
	public Boolean check() {
		if(owner.handcards.size()>=9){
			int b=0;
			int r=0;
			for(Card c:owner.handcards){
				if(c.getColor()==1 || c.getColor()==5)b++;
				else if(c.getColor()==2 || c.getColor()==4)r++;
			}
			return (b>=3 && r>=3);
		}
		return false;
	}
}
