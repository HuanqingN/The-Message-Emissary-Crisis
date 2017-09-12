package extension.skills;
import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *收税：[响应技]发动：将手里的一张【纳税】移出游戏。结算：抽三张牌，然后选择一张手牌放回牌库顶。
 */
public class Skill160 extends Skill {

	@Override
	public Boolean check() {
		if(!disabled && (answer() || bf.nowStep==StepCons.InfoSend || (noInforeceive() && selfturn()))){
			for(Card c:getOwner().handcards){
				if(c.getId()==22)return true;//22：纳税
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		playAni(false);
		bf.waitfor(1000);
		ArrayList<Card> temp=new ArrayList<Card>();
		temp.add(bf.cardsMap.get(tvo.card));
		bf.disCard(getOwner(), temp, 1, null);
		bf.waitfor(2000);
//		disCardend();
	}
//	public void disCardend(){
	@Override
	public void excute() {
//		bf.drawCard(getOwner(), , 1,new ReflectVO("drawCardend", this,2000));
		if(getOwner().getIsDead())return;
		ArrayList<Card> temp=new ArrayList<Card>();
		temp=bf.getCardFromCardPack(3);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		getTvo().dur=10000;
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putBool("goOn", true);
		resp.putNumber("rid", getOwner().getRoleId());
		resp.putNumber("num",3);//改抽牌数的话记得改这里
		resp.putNumber("oid",bf.operId);
		resp.put("cards", arr);
		bf.SendToALL(resp);
		getOwner().addToHand(temp);
		drawCardend();
	}
	public void drawCardend(){
		bf.sResult.dispose();
		bf.waitfor(10000);
		userSelected(bf.sResult);
	}

	private void userSelected(SelectVO svo) {
		if(svo.cards==null){
			svo.cards=new ArrayList<Integer>();
			for(Card c:getOwner().handcards){
				svo.cards.add(c.getVid());
				if(svo.cards.size()==1)break;
			}
		}
		ArrayList<Card> temp=new ArrayList<Card>();
		for(Integer i:svo.cards){
			temp.add(getOwner().removeCardFromHand(i, false));
		}
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("type",5);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报 5情报到库顶 6情报到牌库顶 7情报到弃牌堆 8从手卡到传递中的情报 9从牌库顶到情报
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		
		bf.waitfor(2000);
		bf.cards.addAll(0, temp);
//		bf.usedCardStack.removeLast();
	}
	
}
