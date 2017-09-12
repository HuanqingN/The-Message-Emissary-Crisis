package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;
import extension.vo.TargetVO;


/**
 * ¾¯¾õ
 */
public class Skill16 extends Skill {

	@Override
	public Boolean check() {
		if(!getOwner().getIsOpen() && bf.subStep==StepCons.CardLaunch && noSkill()){
			for(Object t:bf.usedCardStack){
				if(t instanceof TargetVO)return true;
//				if(t.sid==0)return true;
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().setIsOpen(true);
		bf.trigger.trace("play isOpen = "+getOwner().getIsOpen());
		playAni(true);
	}
	@Override
	public void excute() {
		if(getOwner().getIsDead()){
			return;
		}
		for(Object t:bf.usedCardStack){
			if(t instanceof TargetVO){
				if(((TargetVO)t).cvid == getTvo().card){
					((TargetVO)t).disabled=true;
					break;
				}
			}
		}
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		getTvo().dur=2000;
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putBool("goOn", true);
		resp.putNumber("rid", getOwner().getRoleId());
		bf.SendToALL(resp);
		
		bf.waitfor(2000);
	}
	
}
