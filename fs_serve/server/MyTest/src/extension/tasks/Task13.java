package extension.tasks;

import extension.Player;
import extension.cons.StepCons;

/**
 *���һ����������Ǳ�������˫��������һ��ȫ��
 */
public class Task13 extends TaskBase{
	@Override
	public Boolean check() {
		if(owner.getIsDead()){
			int b=0;
			for(Player p:bf.roleSeq){
				if(p.getIsDead()){
					b++;
				}
			}
			return b==1;
		}
		
		if(bf.thirdStep==StepCons.AfterDeadTaskCheck || bf.thirdStep==StepCons.Victory){
			int a=0;
			int b=0;
			for(Player p:bf.roleSeq){
				if(!p.getIsDead() && p.getIndentity()==0)a++;
				if(!p.getIsDead() && p.getIndentity()==1)b++;
			}
		return (a==0 || b==0);
		}
		return false;
	}
}