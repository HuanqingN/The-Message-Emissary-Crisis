package extension.skills;
import extension.cons.StepCons;
import extension.vo.SkillVO;
/**
 *清除异端：当一位玩家杀死一位性别与之不同的另一位玩家时，你与凶手各抽两张牌
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
