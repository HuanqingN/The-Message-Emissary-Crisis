package extension.skills;
import extension.cons.StepCons;
import extension.vo.SkillVO;
/**
 *ÀÍ‘¬¡Ù∫€
 */
public class Skill93 extends Skill {
	public Skill93(){
		auto=true;
	}
	@Override
	public Boolean check() {
		if(getOwner().getIsDead())return false;
		if(getOwner().getIsOpen() && bf.deadman!=null && bf.thirdStep==StepCons.AfterDead) return true;
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		tvo.sponsor=getOwner().getUid();
		getOwner().setIsOpen(false);
		playAni(false);
		bf.waitfor(2000);
	}
	
}
