package extension.tasks;

import extension.Player;
import extension.cons.StepCons;

/**
 * ������һλ��ҳ�Ϊ�ڶ�λ���Ժ����������
 */
public class Task4 extends TaskBase{

	@Override
	public Boolean check() {
//		if(bf.deadman!=null && bf.nowPlayer==owner){
		if(bf.nowGetCardPlayer!=null && bf.nowGetCardPlayer.getIsDead() && !owner.getIsDead()){
			if(bf.nowGetCards.get(0).getOwner()==owner){
				int c=0;
				for(Player p:bf.roleSeq){
					if(p.getIsDead())c++;
				}
				return c>=2;
			}
		}
		return super.check();
	}

}
