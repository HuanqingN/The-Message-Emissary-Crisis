package extension.skills;
import extension.vo.SkillVO;
/**
 *联协（华生的）
 */
public class Skill131 extends Skill {

	@Override
	public Boolean check() {
		
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		playAni(false);
	}
	
}
