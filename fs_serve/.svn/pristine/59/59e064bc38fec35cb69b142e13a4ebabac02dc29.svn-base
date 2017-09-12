package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cons.StepCons;
import extension.vo.SkillVO;
/**
 *迷雾重重：情报传递阶段，令任意位玩家进入调离状态。
 */
public class Skill147 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && bf.nowStep==StepCons.InfoSend && noSkill())return true;
		return false;
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
		if(tvo.targets!=null){
			for(Integer i:tvo.targets){
				bf.roleMap.get(i).isSkip=true;
			}
		}
		
	}
	
}
