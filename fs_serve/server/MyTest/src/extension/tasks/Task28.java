package extension.tasks;

import extension.cards.Card;
import extension.cons.StepCons;
/**
 *������Ż����ϵ����鱨�������Ż����ϵĺ��鱨��������ǰ���鱨ȱ��ĳ����ɫ
 */
public class Task28 extends TaskBase{
	@Override
	public Boolean check() {
		if(!owner.getIsDead() && (owner.blueCards.size()>=3 || owner.redCards.size()>=3)){
			 if(owner.blueCards.size()==0 || owner.redCards.size()==0 || owner.blackCards.size()==0){
				 return true;
			 }
		}
		return super.check();
	}
}
