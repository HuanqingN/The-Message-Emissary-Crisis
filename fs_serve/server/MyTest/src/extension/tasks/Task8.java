package extension.tasks;

/**
 *��һλ��������ʤ��ʱ�����õĺ��鱨���ڵ���һ��
 */
public class Task8 extends TaskBase{

	@Override
	public Boolean check() {
		if(bf.victoryMan!=null && bf.victoryMan.sex>=1){
			return owner.blackCards.size()==0;
		}
		return super.check();
	}

}
