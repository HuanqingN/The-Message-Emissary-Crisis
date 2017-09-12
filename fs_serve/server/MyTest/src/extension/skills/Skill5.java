package extension.skills;

import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *ÀŸ“Î
 */
public class Skill5 extends Skill {

	@Override
	public Boolean check() {
		if(bf.nowStep==StepCons.InfoSend && getOwner().getIsOpen()==false && noSkill()){
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
		if(getOwner().getIsDead()){
			return;
		}
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		getTvo().dur=5000;
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		ActionscriptObject c=new ActionscriptObject();
		bf.sendingcard.setResponse(c);
		resp.put("sendcard",c);
		resp.putBool("goOn", true);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		resp.putNumber("rid", getOwner().getRoleId());
		bf.SendToALL(resp);
		
		bf.sResult.dispose();
		bf.waitfor(5000);
		userSelected(bf.sResult);
	}
	public void userSelected(SelectVO svo){
		ArrayList<Card> temp=new ArrayList<Card>();
		temp.add(bf.getCardFromCardPack());
		bf.drawCard(getOwner(), temp, 1,null);
		bf.waitfor(1500);
	}
	
}
