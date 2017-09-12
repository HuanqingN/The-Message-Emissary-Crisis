package extension.skills;
import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cards.Card;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *光影浮华
 */
public class Skill92 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().getIsOpen())return false;
		if(blueSkillCheck()){
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
		Player target=bf.roleMap.get(getTvo().target);
		if(getOwner().getIsDead() || target.getIsDead() || target.handcards.size()==0){
//			bf.CardSettlementAnswer();
			return;
		}else{
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject obj=new ActionscriptObject();
			getTvo().dur=10000;
			getTvo().setResponse(obj);
			resp.put("tvo",obj);
			resp.putNumber("h",2);
			resp.putNumber("f",25);
			resp.putNumber("num",target.handcards.size());
			resp.putNumber("oid",bf.operId);
			resp.putBool("goOn", true);
			bf.SendToALL(resp);

			bf.sResult.dispose();
			bf.waitfor(10000);
			useSelected(bf.sResult);
		}
	}

	private void useSelected(SelectVO svo) {
		Player target=bf.roleMap.get(getTvo().target);
		if(svo.cards==null){
			svo.cards=new ArrayList<Integer>();
			svo.cards.add((int)(Math.random()*target.handcards.size()));
		}
		ArrayList<Card> temp=new ArrayList<Card>();
		Card c=target.handcards.get(svo.cards.get(0));
		target.removeCardFromHand(c, false);
		c.setOwner(getOwner());
		temp.add(c);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		ActionscriptObject ca=new ActionscriptObject();
		c.setResponse(ca);
		getTvo().dur=10000;
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.put("checkcard",ca);
		resp.putNumber("oid",bf.operId);
		resp.putBool("goOn", true);
		bf.SendToALL(resp);

		bf.sResult.dispose();
		bf.waitfor(10000);
		useSelected1(bf.sResult,temp);
	}
	private void useSelected1(SelectVO svo,ArrayList<Card> temp) {
		Player target=bf.roleMap.get(getTvo().target);
		if(svo.target==0){
			svo.target=bf.getNextPlayer(getOwner()).getUid();
		}
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",target.getUid());
		resp.putNumber("to",svo.target);
		resp.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.waitfor(2000);

//		bf.getCard(bf.roleMap.get(svo.target), temp, new ReflectVO("CardSettlementAnswer", bf), 1000);
		bf.getCard(bf.roleMap.get(svo.target), temp, 1);
	}
}
