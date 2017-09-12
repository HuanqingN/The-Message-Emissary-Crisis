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
 *后著
 */
public class Skill50 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && getOwner().getIsOpen()==true && getOwner().getIsDead()==true && bf.thirdStep==StepCons.AfterDead)return true;
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
		bf.waitfor(2000);
		SkillVO ski=new SkillVO();
		ski.sponsor=getOwner().getUid();
		ski.sid=51;
		ski.color=1;
		getOwner().skillhash.get(51).play(ski);
		
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		tvo.dur=10000;
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		resp.putBool("goOn",true);
		bf.SendToALL(resp);
		bf.sResult.dispose();
		bf.waitfor(10*1000);
		userSelected1(bf.sResult);
	}

	private void userSelected1(SelectVO svo) {
		if(svo.target==0)return;
		Player p=bf.roleMap.get(svo.target);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		bf.setCardsResp(arr, p.handcards);
		getTvo().dur=10000;
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		resp.putBool("goOn",true);
		resp.put("cards",arr);
//		resp.putNumber("num",p.handcards.size());
		bf.SendToALL(resp);
		
		bf.sResult.dispose();
		bf.waitfor(10*1000);
		userSelected(bf.sResult,p);
	}
	private void userSelected(SelectVO svo,Player p) {
		if(svo.card==0|| svo.target==0){
		}else{
			ArrayList<Card> temp=new ArrayList<Card>();
			Player target=bf.roleMap.get(svo.target);
			temp.add(p.removeCardFromHand(svo.card, false));
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject ca=new ActionscriptObject();
			ActionscriptObject arr=new ActionscriptObject();
			bf.setCardsResp(arr, temp);
			resp.putNumber("from",p.getUid());
			resp.putNumber("to",svo.target);
			resp.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
			resp.put("cards",arr);
			resp.putNumber("h",2);
			resp.putNumber("f",27);
			bf.SendToALL(resp);
			
			bf.waitfor(2000);
			bf.getCard(target, temp, 1);
		}
	}
	
}
