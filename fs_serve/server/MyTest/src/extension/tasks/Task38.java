package extension.tasks;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;

/**
 * һλ�������������鱨����ʱ�����鱨��Ϊȫ������֮һ
 */
public class Task38 extends TaskBase{

	@Override
	public Boolean check() {
//		if(bf.deadman!=null){
			if(!owner.getIsDead() && bf.nowGetCardPlayer!=null && bf.nowGetCards.size()>0 && bf.nowGetCards.get(0).getOwner()==owner && bf.nowGetCardPlayer.getIsDead() && bf.thirdStep!=StepCons.AfterDeadTaskCheck){
				for(Player p:bf.roleSeq){
					if(p.infocards.size()>bf.nowGetCardPlayer.infocards.size())return false;
				}
				return true;
			}
//		}
		return super.check();
	}

}
