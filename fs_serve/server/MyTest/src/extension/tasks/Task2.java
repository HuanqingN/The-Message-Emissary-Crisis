package extension.tasks;

import extension.cards.Card;

/**
 * �����뼯���ź�ɫ���ƺ�������ɫ����
 */
public class Task2 extends TaskBase{

	@Override
	public Boolean check() {
		if(owner.handcards.size()>=6){
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
