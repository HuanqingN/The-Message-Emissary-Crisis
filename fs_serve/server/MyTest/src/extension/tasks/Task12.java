package extension.tasks;

import extension.cons.StepCons;

/**
 *���ʮ�Ż����ϵ�����
 */
public class Task12 extends TaskBase{
	@Override
	public Boolean check() {
		return owner.handcards.size()>=10;
	}
}
