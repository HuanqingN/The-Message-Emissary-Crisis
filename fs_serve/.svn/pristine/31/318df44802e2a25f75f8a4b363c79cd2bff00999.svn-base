package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.vo.ReflectVO;
import extension.vo.SkillVO;

/**¾«Ã÷**/
public class Skill56 extends Skill {

	@Override
	public Boolean check() {
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().getCards.add(bf.getCardFromCardPack());
		
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		SkillVO svo=new SkillVO();
		svo.sponsor=getOwner().getUid();
		svo.sid=id;
		svo.setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		bf.SendToALL(resp);
		getOwner().skillhash.get(this.id).launchCount++;
		bf.waitfor(1000);
	}
	
}
