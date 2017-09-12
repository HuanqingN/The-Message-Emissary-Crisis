package extension.skills;
import extension.cons.StepCons;
import extension.vo.SkillVO;
/**
 *筹备圣战：当你的回合结束时，你抽一张牌
 */
public class Skill148 extends Skill {
	public Skill148(){
		auto=true;
	}

	@Override
	public Boolean check() {
		return ( bf.nowStep==StepCons.StepEnd && getOwner().skillhash.get(this.id).launchCount<1 && bf.nowPlayer==getOwner() );
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
		bf.waitfor(1500);
		bf.drawCard(getOwner(), bf.getCardFromCardPack(1), 1, null);
		bf.waitfor(1500);
	}
	
}
