package extension.tasks;

import extension.cards.Card;

/**
 *�����뼯����ʶ��
 */
public class Task3 extends TaskBase{

	@Override
	public Boolean check() {
		if(owner.handcards.size()>=4){
			int b=0;
			for(Card c:owner.handcards){
				if(c.getId()==4)b++;
			}
			return (b>=4);
		}
		return super.check();
	}

}
