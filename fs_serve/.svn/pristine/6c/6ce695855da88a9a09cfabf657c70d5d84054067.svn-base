package extension.skills;
import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.cards.Card;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *寻觅：依次展示牌库顶的牌，直到出现锁定或展示牌达到三张为止。所有被展示的牌加入你的手牌，然后你须选择一张手牌放回牌库顶
 */
public class Skill154 extends Skill {

	@Override
	public Boolean check() {
		return (getOwner().skillhash.get(this.id).launchCount<1 && blueSkillCheck());
//		return false;
	}

	@Override
	public void reset() {
	}
	
	int i=0;//最终展示的总张数-1
	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		ArrayList<Card> cards=new ArrayList<Card>();
		for(int j=0;j<3;j++){
			cards.addAll(bf.getCardFromCardPack(1));
			i++;
			if(cards.get(i-1).getId()==1)break;
		}
		
		bf.cards.addAll(0, cards);
		ActionscriptObject arr1=new ActionscriptObject();
		bf.setCardsResp(arr1, cards);
//		int index=0;
//		for(Card c:cards){
//			ActionscriptObject o=new ActionscriptObject();
//			c.setResponse(o);
//			arr.put(index++,o);
//		}
	
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		tvo.dur=10000;
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		resp.put("cards",arr1);
		bf.SendToALL(resp);
//		bf.sResult.dispose();
//		bf.waitfor(3000+(i+1)*1000);//等动画做好后用这个
		bf.waitfor(3000+3000);
		
		bf.drawCard(getOwner(), bf.getCardFromCardPack(i), 1, null);
		bf.waitfor(1500);
		i=0;
		ActionscriptObject resp1=new ActionscriptObject();
//		ActionscriptObject obj=new ActionscriptObject();
		ActionscriptObject arr2=new ActionscriptObject();
		getTvo().dur=10000;
		getTvo().setResponse(obj);
		resp1.put("tvo",obj);
		resp1.putNumber("h",2);
		resp1.putNumber("f",25);
		resp1.putBool("goOn", true);
		resp1.putNumber("rid", getOwner().getRoleId());
		resp1.putNumber("oid",bf.operId);
		resp1.put("cards", arr2);
		bf.SendToALL(resp1);
		drawCardEnd();
		}
	
	public void drawCardEnd(){
		bf.sResult.dispose();
		bf.waitfor(10000);
		userSelected(bf.sResult);
	}
	
	private void userSelected(SelectVO svo) {
		bf.isExcute=true;
		if(svo.type==0){
			int num=getOwner().handcards.size();
			svo.card=getOwner().handcards.get((int)Math.floor(Math.random()*num)).getVid();
		}
		Card card=bf.cardsMap.get(svo.card);
		getOwner().removeCardFromHand(svo.card,false);
		bf.cards.addFirst(card);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject ca=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		card.setResponse(ca);
		arr.put(0,ca);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("type",5);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.waitfor(2000);
		
	}
	
}
