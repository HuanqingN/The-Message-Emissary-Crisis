package extension.tasks;
/**
 *������Ż����ϵĺ����鱨
 */
public class Task17 extends TaskBase{
	@Override
	public Boolean check() {
		if(!owner.getIsDead()){
			return (owner.redCards.size()+owner.blueCards.size())>=5;
		}
		return false;
	}
}
