package extension.skills;

import extension.cons.StepCons;
import extension.vo.SkillVO;
import extension.vo.TargetVO;

/**诱螳捕蝉**/
public class Skill10 extends Skill {

	@Override
	public Boolean check() {
//		if(getOwner().skillhash.get(this.id).launchCount<1 && !getOwner().getIsDead() && getOwner().getIsOpen() && bf.nowPlayer.getUid()!=getOwner().getUid() && noInforeceive() && noSkill()){
//			if(bf.subStep>0)return bf.subStep==StepCons.CardLaunch;
//			return true;
//		}
		return (bf.nowPlayer!=getOwner() && getOwner().getIsOpen()  && getOwner().skillhash.get(this.id).launchCount<1 && blueSkillCheck());
//		return false;
	}
	
	@Override
	public void reset() {
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
		bf.waitfor(3000);
		bf.roleMap.get(tvo.target).setIsLock(true);
		for(Object t:bf.usedCardStack){
			if(t instanceof TargetVO){
				if(((TargetVO)t).sid>0) continue;
				if(((TargetVO)t).cid==9 &&((TargetVO)t).sponsor==tvo.target) ((TargetVO)t).disabled=true; //使堆叠中该技能的目标玩家使用的转移无效
			}
		}
	}
}
