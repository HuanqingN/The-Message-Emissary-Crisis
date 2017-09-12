package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.cards.Card;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *狗急跳墙 当你收到黑情报时，你可以弃X张手牌，然后烧毁你面前的X张黑情报。（X不大于你面前的黑情报数）
 */
public class Skill113 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && !getOwner().getIsDead() && bf.nowGetCards.size()>0 && bf.nowGetCardPlayer==getOwner()){
			for(Card c:bf.nowGetCards){
				if(c.getColor()>2)return true;
			}
		}
		return false;
	}
	
	@Override
	public void reset() {
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

	private void userSelected(SelectVO svo) {
		if(svo.cards==null)return;
		ArrayList<Card> temp=new ArrayList<Card>();
		for(Integer i:svo.cards){
			temp.add(bf.cardsMap.get(i));
		}
		bf.disCard(getOwner(), temp, 1,null);
		bf.waitfor(1500);
		
		if(temp.size()==getOwner().blackCards.size()){//全烧
			ArrayList<Card> temp1=new ArrayList<Card>();
			temp1.addAll(getOwner().blackCards);
			getOwner().removeCardFromInfo(temp1,true);
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject arr=new ActionscriptObject();
			bf.setCardsResp(arr, temp1);
			resp.putNumber("from",getOwner().getUid());
			resp.putNumber("type",7);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
			resp.put("cards",arr);
			resp.putNumber("h",2);
			resp.putNumber("f",27);
			bf.SendToALL(resp);
			bf.waitfor(1500);
		}else{//选择烧
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject obj=new ActionscriptObject();
			getTvo().dur=10000;
			getTvo().setResponse(obj);
			resp.put("tvo",obj);
			resp.putNumber("h",2);
			resp.putNumber("f",25);
			resp.putBool("goOn",true);
			resp.putNumber("oid",bf.operId);
			resp.putNumber("num",temp.size());
			bf.SendToALL(resp);
			bf.sResult.dispose();
			bf.waitfor(10000);
			userSelected1(bf.sResult,temp.size());
		}
	}

	private void userSelected1(SelectVO svo,int num) {
		if(svo.cards==null){
			svo.cards=new ArrayList<Integer>();
			int index=0;
			for(Card c:getOwner().blackCards){
				svo.cards.add(c.getVid());
				index++;
				if(index==num)break;
			}
		}
		ArrayList<Card> temp1=new ArrayList<Card>();
		for(Integer i:svo.cards){
			temp1.add(bf.cardsMap.get(i));
		}
		bf.Burn(getOwner().getUid(), temp1);
//		ActionscriptObject resp=new ActionscriptObject();
//		ActionscriptObject arr=new ActionscriptObject();
//		bf.setCardsResp(arr, temp1);
//		resp.putNumber("from",getOwner().getUid());
//		resp.putNumber("type",7);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
//		resp.put("cards",arr);
//		resp.putNumber("h",2);
//		resp.putNumber("f",27);
//		bf.SendToALL(resp);
//		bf.waitfor(1500,null);
	}
}
