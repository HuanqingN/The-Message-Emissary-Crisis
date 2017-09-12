package extension.skills;
import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *挑拨 翻开此角色牌，然后指定一位其他玩家在另一位玩家面前放置一张黑情报，若其不如此做，你可以抽取这两位玩家的各一张手牌
 */
public class Skill95 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().getIsOpen() || getOwner().getIsDead())return false;
//		if(answer() || noInforeceive()){
//			if(selfturn()){
//				return true;
//			}else{
//				return bf.nowStep != StepCons.CardUse1;
//			}
//		}
		if(blueSkillCheck())return true;
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		playAni(true);
		getOwner().setIsOpen(true);
		bf.sResult.dispose();
		bf.waitfor(11000);
		userSelected(bf.sResult);
	}

	@Override
	public void excute() {
		if(firstSelect==null || firstSelect.targets==null || firstSelect.targets.size()<2)return;
		Player to=bf.roleMap.get(firstSelect.targets.get(1));
		Player from=bf.roleMap.get(firstSelect.targets.get(0));
		if(from.getIsDead() || from.handcards.size()==0 || to.getIsDead())return;
		boolean hasblack=hasCardColor(6, from);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		getTvo().target=from.getUid();
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("to",to.getUid());
		resp.putBool("goOn",true);
		resp.putNumber("oid",bf.operId);
		resp.putBool("hasblack",hasblack);
		bf.SendToALL(resp);
		if(hasblack){
			bf.sResult.dispose();
			bf.waitfor(10000);
			userSelected1(bf.sResult,from,to);
		}else{
			if(from.handcards.size()>0){
				ArrayList<Card> temp=new ArrayList<Card>();
				temp.add(from.removeCardFromHand(from.handcards.get(0).getVid(),false));
				ActionscriptObject resp1=new ActionscriptObject();
				ActionscriptObject arr=new ActionscriptObject();
				bf.setCardsResp(arr, temp);
				resp1.putNumber("from",from.getUid());
				resp1.putNumber("to",getOwner().getUid());
				resp1.putNumber("type",1);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
				resp1.put("cards",arr);
				resp1.putNumber("h",2);
				resp1.putNumber("f",27);
				bf.SendToALL(resp1);
				getOwner().addToHand(temp);
			}
			if(to.handcards.size()>0){
				ArrayList<Card> temp=new ArrayList<Card>();
				temp.add(to.removeCardFromHand(to.handcards.get(0).getVid(),false));
				ActionscriptObject resp1=new ActionscriptObject();
				ActionscriptObject arr=new ActionscriptObject();
				bf.setCardsResp(arr, temp);
				resp1.putNumber("from",to.getUid());
				resp1.putNumber("to",getOwner().getUid());
				resp1.putNumber("type",1);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
				resp1.put("cards",arr);
				resp1.putNumber("h",2);
				resp1.putNumber("f",27);
				bf.SendToALL(resp1);
				getOwner().addToHand(temp);
			}
			bf.waitfor(1500);
		}
	}
	private SelectVO firstSelect;
	private void userSelected(SelectVO svo) {
		if(svo.targets==null)return;
		firstSelect=svo;
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		getTvo().target=svo.targets.get(0);
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
//		resp.putNumber("oid",bf.operId);
		resp.putNumber("to",svo.targets.get(1));
		resp.putBool("goOn",true);
		resp.putBool("arrow",true);
		bf.SendToALL(resp);
		bf.waitfor(1000);
	}
	private void userSelected1(SelectVO svo,Player from,Player to) {
		if(svo.card==0){
			for(Card c:from.handcards){
				if(c.getColor()>2){
					svo.card=c.getVid();
					break;
				}
			}
		}
		ArrayList<Card> temp=new ArrayList<Card>();
		Card c=bf.cardsMap.get(svo.card);
		from.removeCardFromHand(c,false);
		temp.add(c);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",from.getUid());
		resp.putNumber("to",to.getUid());
		resp.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.waitfor(1500);
		bf.getCard(to, temp, 1);
	}
	
}
