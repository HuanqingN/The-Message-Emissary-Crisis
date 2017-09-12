package extension.skills;

import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import extension.Player;
import extension.actions.CardAction6;
import extension.cons.StepCons;
import extension.vo.SkillVO;
import extension.vo.TargetVO;

/**
 *Ωÿ…œΩÿ
 */
public class Skill7 extends Skill {
	public CardAction6 c6=null;
	@Override
	public Boolean check() {
		if(bf.nowStep==StepCons.InfoSend && getOwner().getIsOpen()==false && noSkill() && !selfturn()){
					return true;
				}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().setIsOpen(true);
		playAni(true);
	}
	
	@Override
	public void excute() {
		if(c6==null){
			c6=new CardAction6();
			c6.setOwner(getOwner());
		}
		TargetVO t=new TargetVO();
		t.useBySkill=true;
		t.target=getTvo().target;
		t.sponsor=getOwner().getUid();
		t.cid=6;
		c6.play(t);
	}
	
}
