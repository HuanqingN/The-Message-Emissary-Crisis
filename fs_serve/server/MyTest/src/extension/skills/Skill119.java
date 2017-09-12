package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;

/**灵通**/
public class Skill119 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<2 && selfturn() && (bf.nowStep==StepCons.CardUse1  || bf.nowStep==StepCons.CardUse2) && bf.usedCardStack.size()==0 && noInforeceive()){
			if(getOwner().handcards.size()>0){
				for(Player p:bf.roleSeq){
					if(p.getUid()!=getOwner().getUid()){
						if(p.handcards.size()>0)return true;
					}
				}
			}
		}
		return false;
	}

	ArrayList<Card> temp=new ArrayList<Card>();//给出的牌
	ArrayList<Card> temp1=new ArrayList<Card>();//抽来的牌
	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		temp.clear();
		temp1.clear();
		if(tvo.cards==null){
			tvo.cards=new ArrayList<Integer>();
		}
		if(tvo.cards.size()<1){
			for(Card c:getOwner().handcards){
				if(tvo.cards.indexOf(c.getVid())<0){
					tvo.cards.add(c.getVid());
					if(tvo.cards.size()==1)break;
				}
			}
		}
		for(Integer i:tvo.cards){
			temp.add(getOwner().removeCardFromHand(i, false));
		}
		int num=temp.size();
		
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		tvo.dur=15000;
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
//		ActionscriptObject arr=new ActionscriptObject();
//		bf.setCardsResp(arr, bf.roleMap.get(tvo.target).handcards);
//		resp.put("cards",arr);
		resp.putNumber("tn",bf.roleMap.get(tvo.target).handcards.size());
		resp.putNumber("num",num);
		resp.putNumber("rid", getOwner().getRoleId());
		bf.SendToALL(resp);
		bf.sResult.dispose();
		bf.waitfor(10*1000);
		userSelected(bf.sResult);
	}

	private void userSelected(SelectVO svo) {
		Player target=bf.roleMap.get(getTvo().target);
//		if(svo.cards==null){
//			svo.cards=new ArrayList<Integer>();
//			svo.cards.add(0);
//		}
		if(svo.cards!=null){
			for(Integer i:svo.cards){
				temp1.add(target.handcards.get(i));
			}
			target.removeCardFromHand(temp1,false);
			getOwner().addToHand(temp1);
		}
		
		target.addToHand(temp);
		
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("to",target.getUid());
		resp.putNumber("type",1);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.waitfor(2000);
		
		if(svo.cards!=null){
			arr=new ActionscriptObject();
			bf.setCardsResp(arr, temp1);
			resp.putNumber("from",target.getUid());
			resp.putNumber("to",getOwner().getUid());
			resp.putNumber("type",1);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
			resp.put("cards",arr);
			resp.putNumber("h",2);
			resp.putNumber("f",27);
			bf.SendToALL(resp);
			bf.waitfor(2000);
		}
	}
	
}
