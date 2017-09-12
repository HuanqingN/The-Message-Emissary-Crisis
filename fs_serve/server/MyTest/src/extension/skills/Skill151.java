package extension.skills;
import extension.vo.SkillVO;
/**
 *剧毒攻心 进入中毒状态的玩家不能使用技能
 */
public class Skill151 extends Skill {

	@Override
	public Boolean check() {
		
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
	}
	
}
