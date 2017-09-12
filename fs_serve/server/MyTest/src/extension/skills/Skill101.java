package extension.skills;
import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *移花接木 情报传递时，翻开此角色牌，然后选择一张手牌替换传递的情报
 */
public class Skill101 extends Skill {

	@Override
	public Boolean check() {
		if(bf.subStep>0 || getOwner().getIsOpen() || getOwner().getIsDead())return false;
		if(bf.nowStep == StepCons.InfoSend && noSkill()){
			return getOwner().handcards.size()>0;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().setIsOpen(true);
		playAni(true);
		bf.waitfor(1500);

		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		getTvo().dur=10000;
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		resp.putBool("goOn", true);
		bf.SendToALL(resp);
		
		bf.sResult.dispose();
		bf.waitfor(10000);
		userSelected(bf.sResult);
	}

	private void userSelected(SelectVO svo) {
		if(svo.card==0){
		}else{
			ArrayList<Card> temp=new ArrayList<Card>();
			Card scar=getOwner().removeCardFromHand(svo.card,false);
			temp.add(bf.sendingcard);
			temp.add(scar);
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject obj=new ActionscriptObject();
			ActionscriptObject arr=new ActionscriptObject();
			bf.setCardsResp(arr,temp);
			getTvo().dur=10000;
			getTvo().card=svo.card;
			getTvo().setResponse(obj);
			resp.put("tvo",obj);
			resp.putNumber("h",2);
			resp.putNumber("f",25);
			resp.put("card",arr);
			resp.putBool("goOn", true);
			bf.SendToALL(resp);
			
			bf.waitfor(2000);
			scar.setOwner(bf.sendingcard.getOwner());
			scar.orgSend=scar.getSend();
			scar.setSend(bf.sendingcard.getSend());
			scar.shared=true;
			if(bf.sendingcard.security)scar.security=true;
			if(bf.sendingcard.heishui)scar.heishui=true;
			bf.sendingcard.setOwner(null);
			bf.sendCardToGraveyard(bf.sendingcard);
			bf.sendingcard=scar;
			bf.sendingcard.shared=true;
		}
	}
	
	
}
