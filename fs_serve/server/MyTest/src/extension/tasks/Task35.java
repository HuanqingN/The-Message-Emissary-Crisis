package extension.tasks;

import extension.cards.Card;

/**
 *һλ���������鱨����ʤ��ʱ������ǰ�ĺ��鱨�����ڶ���
 */
public class Task35 extends TaskBase{

	@Override
	public Boolean check() {
		if(bf.victoryMan!=null && bf.nowGetCards.size()>0 && bf.nowGetCards.get(0).getOwner()==owner){		
			return bf.victoryMan.blackCards.size()>=2;
		}
		return super.check();
	}

}
