package extension.skills;
import extension.vo.SkillVO;
/**
 *联协（福尔摩斯的）
 */
public class Skill133 extends Skill {

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
