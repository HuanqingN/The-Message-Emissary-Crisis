package extension.tasks;

import extension.cards.Card;
import extension.cons.StepCons;

/**
 * ��������һλû�л�ô���ʹ����鱨���������
 */
public class Task1 extends TaskBase{
	@Override
	public Boolean check() {
//		if(bf.deadman!=null){
		if(bf.nowGetCardPlayer!=null && bf.nowGetCardPlayer.getIsDead()){
			if(bf.nowGetCards.get(0).getOwner()==owner){
				int pbr=0;
//				for(Card c:bf.deadman.infocards){
				for(Card c:bf.nowGetCardPlayer.infocards){
					if(c.getColor()==1 || c.getColor()==2)pbr++;
				}
				return pbr==0;
			}
		}
		return false;
	}
	
}
