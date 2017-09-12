package extension.tasks;

import extension.cards.Card;
import extension.cons.StepCons;

/**
 *��������ʱ��չʾ������ƣ����������Ż����ϵĺ�ɫ����
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
