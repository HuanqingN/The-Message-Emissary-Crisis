package extension.skills;

import it.gotoandplay.smartfoxserver.SmartFoxServer;
import extension.vo.SkillVO;

/**ÑÚ»¤**/

public class Skill17 extends Skill {
	public Skill17(){
		auto=true;
	}
	@Override
	public Boolean check() {
		if(getOwner().getIsOpen()==true && bf.nowGetCardPlayer!=null && bf.nowGetCardPlayer==getOwner()){
			return true;
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
