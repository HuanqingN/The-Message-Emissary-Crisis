package extension.skills;
import extension.Player;
import extension.vo.SkillVO;
/**
 *楚毒备至 刷新已经中毒玩家的毒效持续时间
 */
public class Skill137 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && bf.thirdStep==0 && noInforeceive()){
			for(Player p:bf.roleSeq){
				if(!p.getIsDead() && !p.isLost && p.isPoison>0){
					return true;
				}
			}
		}
		return false;
	}

	@Override
	public void reset() {
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		playAni(false);
		getOwner().skillhash.get(this.id).launchCount++;
		bf.waitfor(3000);
		for(Player p:bf.roleSeq){
			if(!p.getIsDead() && !p.isLost && p.isPoison>0){
				p.isPoison+=4;
				bf.setPoison(p.getUid(),p.isPoison);
			}
		}
	}
	
}
