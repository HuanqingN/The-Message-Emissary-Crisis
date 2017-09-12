package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;
import java.util.Iterator;

import extension.Player;
import extension.cards.Card;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
import extension.vo.TargetVO;


/**
 *弃卒保帅
 */
public class Skill23 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().getIsOpen()==false && bf.nowSettlement instanceof TargetVO && ((TargetVO)bf.nowSettlement).cid==4 &&((TargetVO)bf.nowSettlement).disabled==false){
			 if(bf.cardsMap.get(((TargetVO)bf.nowSettlement).card).getOwner()==getOwner())
				 return true;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().setIsOpen(true);
		ArrayList<Card> cards=bf.getCardFromCardPack(5);
		getOwner().getCards.addAll(cards);
//		getOwner().addToHand(cards);
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, cards);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		tvo.dur=10000;
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("to",getOwner().getUid());
		resp.putNumber("type",1);
		resp.putNumber("rid", getOwner().getRoleId());
		for(Player p:bf.roleSeq){
			resp.putNumber("oid",bf.operId);
			if(p.getUid()==getOwner().getUid()){
				resp.put("cards", arr);
			}else{
				resp.putNumber("num", cards.size());
			}
			bf.trigger.sendResponse(resp, -1, null, p.getChannel());
			resp.removeElement("cards");
		}
		
		bf.sResult.dispose();
		bf.waitfor(13000);
		userSelected(bf.sResult);
	}

	private void userSelected(SelectVO svo) {
		if(svo.cards==null){
			svo.cards=new ArrayList<Integer>();
		}
		ArrayList<Card> temp=new ArrayList<Card>();
		ArrayList<Card> temp1=new ArrayList<Card>();
		temp.addAll(getOwner().handcards);
		temp.addAll(getOwner().getCards);
		if(svo.cards.size()<2){
			for(Card c:temp){
				if(svo.cards.indexOf(c.getVid())<0){
					svo.cards.add(c.getVid());
					if(svo.cards.size()==2)break;
				}
			}
		}
		
		for(Integer i:svo.cards){
			Iterator<Card> iter=temp.iterator();
			while(iter.hasNext()){
				Card gc=iter.next();
				if(gc.getVid()==i){
					temp1.add(gc);
					iter.remove();
				}
			}
		}
		bf.cards.addAll(0, temp1);
		getOwner().handcards.clear();
		getOwner().getCards.clear();
		getOwner().addToHand(temp);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp1);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("type",5);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.waitfor(2000);
	}
	
}
