package extension.skills;

import extension.vo.SkillVO;

/**¼±ÖÐÉúÖÇ**/
public class Skill40 extends Skill {

	@Override
	public Boolean check() {
//		if(getOwner().skillhash.get(this.id).launchCount<1 && selfturn() && noInforeceive()){
//			if(getOwner().blackCards.size()>0 || getOwner().redCards.size()>0 || getOwner().blueCards.size()>0)return true;
//		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
	}
	
}
