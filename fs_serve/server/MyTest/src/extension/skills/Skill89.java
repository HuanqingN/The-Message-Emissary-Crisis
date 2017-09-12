package extension.skills;
import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *ÓÄÁéÏ®»÷
 */
public class Skill89 extends Skill {

	@Override
	public Boolean check() {
		if(!getOwner().getIsOpen() && !getOwner().getIsDead() && bf.nowStep==StepCons.InfoSend){
			return true;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().setIsOpen(true);
		tvo.target=bf.sendTarget.getUid();
		playAni(true);
		bf.waitfor(1500);
		bf.roleMap.get(tvo.target).setIsLock(true);
	}

	@Override
	public void excute() {
		if(getOwner().getIsDead()){
			return;
		}else{
			if(hasCardColor(6, getOwner())){
				ActionscriptObject resp=new ActionscriptObject();
				ActionscriptObject obj=new ActionscriptObject();
				getTvo().dur=10000;
				getTvo().setResponse(obj);
				resp.put("tvo",obj);
				resp.putNumber("h",2);
				resp.putNumber("f",25);
				resp.putBool("goOn", true);
				resp.putNumber("oid",bf.operId);
				bf.SendToALL(resp);
				
				bf.sResult.dispose();
				bf.waitfor(10*1000);
				userSelected(bf.sResult);
			}
		}
	}
	private void userSelected(SelectVO svo) {
		if(svo.type==0 || svo.cards==null){
			return;
		}else{
			ArrayList<Card> temp=new ArrayList<Card>();
			Card scar=getOwner().removeCardFromHand(svo.cards.get(0),false);
			temp.add(bf.sendingcard);
			temp.add(scar);
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject obj=new ActionscriptObject();
			ActionscriptObject arr=new ActionscriptObject();
			bf.setCardsResp(arr,temp);
			getTvo().dur=10000;
			getTvo().card=svo.cards.get(0);
			getTvo().setResponse(obj);
			resp.put("tvo",obj);
			resp.putNumber("h",2);
			resp.putNumber("f",25);
			resp.put("card",arr);
			resp.putBool("goOn", true);
			bf.SendToALL(resp);
			
			bf.waitfor(2000);
			if(bf.sendingcard.security)scar.security=true;
			if(bf.sendingcard.heishui)scar.heishui=true;
			scar.shared=true;
			bf.sendCardToGraveyard(bf.sendingcard);
			bf.sendingcard=scar;
		}
	}
}
