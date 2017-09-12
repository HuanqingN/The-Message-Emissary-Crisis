package extension.skills;
import extension.cons.StepCons;
import extension.vo.SkillVO;
/**
 *霸权：你的回合结束时,再次进入你的回合
 */
public class Skill128 extends Skill {

	@Override
	public Boolean check() {
		return ( bf.nowStep==StepCons.StepEnd && getOwner().skillhash.get(this.id).launchCount<1 && bf.nowPlayer==getOwner() );
	}
	
	@Override
	public void reset() {
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
		bf.nextPlayer=getOwner();
		bf.waitfor(3000);
	}
	
}
