package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cons.StepCons;
import extension.vo.SkillVO;

/**Ì¯ÅÆ**/
public class Skill62 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().idenShow || !getOwner().getIsOpen() || launchCount>=1)return false;
		if(blueSkillCheck()){
			return true;
		}
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
		getOwner().idenShow=true;
		bf.waitfor(3000);
		ActionscriptObject resp=new ActionscriptObject();
		resp.putNumber("from",-1);
		resp.putNumber("target",getOwner().getUid());
		resp.putNumber("iden",getOwner().getIndentity());
		resp.putNumber("h",2);
		resp.putNumber("f",30);
		bf.SendToALL(resp);
		
		bf.waitfor(3000);
		Player target=bf.roleMap.get(tvo.target);
		target.idenShow=true;
		resp=new ActionscriptObject();
		resp.putNumber("from",-1);
		resp.putNumber("target",tvo.target);
		resp.putNumber("iden",target.getIndentity());
		resp.putNumber("h",2);
		resp.putNumber("f",30);
		bf.SendToALL(resp);
		
		bf.waitfor(3000);
	}
	
}
