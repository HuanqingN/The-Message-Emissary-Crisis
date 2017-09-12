package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *偷梁换柱 情报传递时,选择一位玩家的一张情报替换传递中的情报
 */
public class Skill103 extends Skill {

	@Override
	public Boolean check() {
//		if(bf.subStep>0 || !getOwner().getIsOpen() || getOwner().getIsDead())return false;
//		if(getOwner().skillhash.get(this.id).launchCount<1 && bf.nowStep == StepCons.InfoSend && noSkill() && (hashInfoByOther() || getOwner().infocards.size()>0)){
//			return true;
//		}
		return false;
	}

	@Override
	public void reset(){
		
	}
	
	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
		bf.sResult.dispose();
		bf.waitfor(13000);
		userSelected(bf.sResult);
	}
	
	private void userSelected(SelectVO svo){
		if(svo.card==0){
			return;
		}else{
			ArrayList<Card> temp=new ArrayList<Card>();
			Card scar=getOwner().removeCardFromInfo(svo.card,false);
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
			resp.putNumber("type",10);
			resp.put("card",arr);
			resp.putBool("goOn", true);
			bf.SendToALL(resp);
			
			bf.waitfor(2000);
			scar.setOwner(bf.sendingcard.getOwner());
			scar.orgSend=scar.getSend();
			scar.setSend(bf.sendingcard.getSend());
			bf.sendingcard.setOwner(null);
			bf.sendCardToGraveyard(bf.sendingcard);
			bf.sendingcard=scar;
			bf.sendingcard.shared=true;
		}
	}
	
}
