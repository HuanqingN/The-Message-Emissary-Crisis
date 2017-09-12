package extension.skills;
import extension.cons.StepCons;
import extension.vo.SkillVO;
/**
 *«πœ¬¡Ù«È
 */
public class Skill123 extends Skill {
	public Skill123(){
		auto=true;
	}
	@Override
	public Boolean check() {
		return(!getOwner().getIsDead() && bf.thirdStep==StepCons.BeforeBurn);
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		playAni(false);
		bf.burnTo=getOwner().getUid();
		bf.waitfor(1000);
	}
	
}
