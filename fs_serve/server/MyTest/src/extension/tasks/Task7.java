package extension.tasks;

/**
 *������Ż����ϵĺ��鱨
 */
public class Task7 extends TaskBase{

	@Override
	public Boolean check() {
		if(!owner.getIsDead()){
			return owner.redCards.size()>=3;
		}
		return false;
	}

}
