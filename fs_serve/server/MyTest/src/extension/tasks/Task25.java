package extension.tasks;
/**
 *������Ż����ϵĺ��鱨���������Ż����ϵ����鱨
 */
public class Task25 extends TaskBase{
	@Override
	public Boolean check() {
		if(!owner.getIsDead()){
			return (owner.blueCards.size()>=4 || owner.redCards.size()>=4);
		}
		return super.check();
	}
}
