package extension.skills;
import extension.vo.SkillVO;
/**
 *高举火把：当一位玩家烧毁性别与之相同的另一位玩家的情报时，你与该玩家各抽一张牌
 */
public class Skill150 extends Skill {

	@Override
	public Boolean check() {
		
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
	}
	
}
