package extension.tasks;

import extension.Player;

/**
 * ��һλ�������ʤ��ʱ��û��������������ʤ���ᵼ����������ʧ��
 */
public class Task5 extends TaskBase{

	@Override
	public Boolean check() {
		if(bf.victoryMan!=null){
			int b=0;
			for(Player p:bf.roleSeq){
				if(p.getIsDead()){
					b++;
					break;
				}
			}
			if(b==0){
				bf.winners.clear();
				bf.victoryMan=owner;
			}
			return b==0;
		}
		return super.check();
	}

}
