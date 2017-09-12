package extension.skills;
import extension.Player;
import extension.cons.StepCons;
import extension.vo.SkillVO;
import extension.vo.TargetVO;
/**
 *激素：指定一位其他玩家，本回合内每当其使用一张功能牌时，其抽一张牌（上限五张）
 */
public class Skill144 extends Skill {

	@Override
	public Boolean check() {
		if(!getOwner().skillhash.get(id).auto)
			return(getExclusiveSkill().launchCount<1 && getOwner().getIsOpen() && noInforeceive() && bf.skillstep==0);
		else
			return (launchTarget!=null && !launchTarget.getIsDead() && bf.subStep==StepCons.CardSettlementEnd && bf.nowSettlement instanceof TargetVO && ((TargetVO)bf.nowSettlement).sponsor==launchTarget.getUid());
	}

	@Override
	public void reset() {
		getExclusiveSkill().auto=false;
		getExclusiveSkill().launchTarget=null;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getExclusiveSkill().launchCount++;
		if(!getExclusiveSkill().auto){
			playAni(false);
			bf.waitfor(3000);
			getExclusiveSkill().auto=true;
			getExclusiveSkill().color=1;
			bf.usedCardStack.removeLast();
			getExclusiveSkill().launchTarget=bf.roleMap.get(tvo.target);
		}else{
			if(getExclusiveSkill().launched<5){
				Player target=getExclusiveSkill().launchTarget;
				bf.drawCard(target, bf.getCardFromCardPack(1), 1, null);
				getExclusiveSkill().launched++;
				bf.waitfor(1000);
			}else{
				getOwner().skillhash.get(id).auto=false;
				getExclusiveSkill().launchTarget=null;
			}
		}
	}
	
}
