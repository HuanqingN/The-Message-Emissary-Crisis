package extension.skills;
import extension.cons.StepCons;
import extension.vo.SkillVO;
import extension.vo.TargetVO;
/**
 *金蝉脱壳 当玩家使用截获或者调包时，盖伏此角色
 */
public class Skill102 extends Skill {
	public Skill102(){
		auto=true;
	}

	@Override
	public Boolean check() {
		if(getOwner().getIsOpen()==true && bf.subStep==StepCons.CardSettlement && bf.nowSettlement instanceof TargetVO && ((TargetVO)bf.nowSettlement).sid==0 && ((TargetVO)bf.nowSettlement).disabled==false){
			int cindex=((TargetVO)bf.nowSettlement).cid;
			if(cindex==6 || cindex==10)return true;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().setIsOpen(false);
		playAni(false);
		bf.waitfor(1500);
	}
	
}
