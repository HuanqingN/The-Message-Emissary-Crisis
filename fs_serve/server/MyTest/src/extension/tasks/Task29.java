package extension.tasks;

/**
 *ͨ���Ծ�ʹһλ��һ��ʤ��
 */
public class Task29 extends TaskBase{
	@Override
	public Boolean check() {
		if(bf.victoryMan!=null && bf.nowGetCards.size()>0 && bf.nowGetCards.get(0).byMiju==true){		
			return true;
		}
		return super.check();
	}
}
