package extension.skills;
import extension.cons.StepCons;
import extension.vo.SkillVO;
/**
 *�����ˣ���һλ���ɱ��һλ�Ա���֮��ͬ����һλ���ʱ���������ָ���������
 */
public class Skill149 extends Skill {

	@Override
	public Boolean check() {
		if(bf.thirdStep==StepCons.Victory)return false;
		if(!getOwner().getIsDead() && bf.deadman!=null && bf.thirdStep==StepCons.AfterDead && bf.nowGetCardPlayer!=null && bf.nowGetCards.size()>0){
			if(bf.nowGetCardPlayer.sex!=bf.nowGetCards.get(0).getOwner().sex)
			return true;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
	}
	
}
