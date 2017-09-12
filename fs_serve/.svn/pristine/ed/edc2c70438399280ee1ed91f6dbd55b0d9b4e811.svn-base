package extension.tasks;

import extension.cards.Card;

/**
 *ÊÖÅÆÊÕÆëÎåÕÅ´¿ºì¿¨ÅÆ»òÎåÕÅ´¿À¶¿¨ÅÆ
 */
public class Task26 extends TaskBase{
	@Override
	public Boolean check() {
		if(!owner.getIsDead()){
			int r=0;
			int b=0;
			if(owner.handcards.size()>=5){
				for(Card c:owner.handcards){
					if(c.getColor()==1)b++;
					if(c.getColor()==2)r++;
				}
			}
			return (r>=5 || b>=5);
		}
		return super.check();
	}
}
