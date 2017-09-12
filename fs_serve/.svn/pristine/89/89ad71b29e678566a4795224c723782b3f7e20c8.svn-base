package extension.skills;
import java.util.ArrayList;
import java.util.LinkedList;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;
/**
 *æ»√¿
 */
public class Skill30 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().idenShow || getOwner().getIsDead())return false;
		if(bf.willDead!=null && bf.willDead.getIsOpen() && bf.willDead.sex!=1 && bf.thirdStep==StepCons.BeforeDead)return true;
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().idenShow=true;
		tvo.target=bf.willDead.getUid();
		playAni(false);
		bf.waitfor(1000);
		ActionscriptObject resp=new ActionscriptObject();
		resp.putNumber("from",-1);
		resp.putNumber("target",getOwner().getUid());
		resp.putNumber("iden",getOwner().getIndentity());
		resp.putNumber("h",2);
		resp.putNumber("f",30);
		bf.SendToALL(resp);
		
		bf.waitfor(3000);
		
		bf.willDead.setIsDead(false);
//		bf.willDead=null;
		ArrayList<Card> temp=new ArrayList<Card>();
		temp.addAll(bf.willDead.blackCards);
		bf.Burn(bf.willDead.getUid(), temp);
	}
	
}
