package extension.skills;
import extension.Player;
import extension.cons.StepCons;
import extension.vo.SkillVO;
import extension.vo.TargetVO;
/**
 *倍受宠爱 本回合所有调虎离山结算后,其发动者抽一张牌
 */
public class Skill106 extends Skill {

	@Override
	public Boolean check() {
		if(!getOwner().skillhash.get(id).auto)
			return(getExclusiveSkill().launchCount<1 && noInforeceive() && bf.nowStep==StepCons.InfoSend);
		else
			return (bf.subStep==StepCons.CardSettlementEnd && bf.nowSettlement instanceof TargetVO && ((TargetVO)bf.nowSettlement).cid==2);
	}

	@Override
	public void reset() {
		if(getExclusiveSkill().auto){
			getExclusiveSkill().launchCount++;
			getExclusiveSkill().color=0;
			getExclusiveSkill().auto=false;
		}
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
		}else{
			Player target=bf.roleMap.get(((TargetVO)bf.nowSettlement).sponsor);
			bf.drawCard(target, bf.getCardFromCardPack(1), 1, null);
		}
	}

}
