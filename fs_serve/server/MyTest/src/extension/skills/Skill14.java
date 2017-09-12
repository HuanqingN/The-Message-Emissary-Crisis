package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cons.StepCons;
import extension.vo.SkillVO;

/**³Ç¸®**/
public class Skill14 extends Skill {

	@Override
	public Boolean check() {
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		if(getOwner().getIsOpen()==false)return;
		super.play(tvo);
		tvo=new SkillVO();
		tvo.sponsor=getOwner().getUid();
		tvo.sid=id;
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		bf.SendToALL(resp);
	}
	
}
