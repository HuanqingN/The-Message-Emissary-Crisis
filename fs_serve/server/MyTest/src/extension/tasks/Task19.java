package extension.tasks;
/**
 *�����ڻغ�,һ��������һ��ʤ��
 */
public class Task19 extends TaskBase{
	@Override
	public Boolean check() {
		if(bf.victoryMan!=null){
			if(bf.nowPlayer==owner){
				return true;
			}
		}
	return super.check();
    }
}
