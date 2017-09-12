package extension.skills;

import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.actions.CardAction2;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;
import extension.vo.TargetVO;


/**
 *Éù¶«»÷Î÷
 */
public class Skill27 extends Skill {
	public CardAction2 c2=null;
	@Override
	public Boolean check() {
		if(bf.nowStep==StepCons.InfoSend && getOwner().getIsOpen()==true && noSkill()){
			for(Player p:bf.roleSeq){
				if(p!=getOwner() && p!=bf.nowPlayer && !p.getIsLock() && !p.isCapture && !p.getIsDead() && !p.isLost && !p.isTransfer){
					return true;
				}
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().setIsOpen(false);
		playAni(false);
	}
	@Override
	public void excute() {
		if(bf.roleMap.get(getTvo().target).isCapture){
			return;
		}
		if(c2==null){
			c2=new CardAction2();
			c2.setOwner(getOwner());
		}
		TargetVO t=new TargetVO();
		t.useBySkill=true;
		t.target=getTvo().target;
		t.cid=2;
		c2.play(t);
	}

}
