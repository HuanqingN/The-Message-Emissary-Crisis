package extension.tasks;

import extension.cards.Card;

/**
 * ������ǰû�к��鱨��ǰ����  ������ɱ��һλ�������
 */
public class Task36 extends TaskBase{

	@Override
	public Boolean check() {
		if(bf.nowGetCardPlayer!=null && bf.nowGetCardPlayer.getIsDead() && bf.nowGetCards.size()>0 && bf.nowGetCards.get(0).getOwner()==owner){
			if(owner.blackCards.size()==0){
				return true;
			}
		}
		return super.check();
	}

}
