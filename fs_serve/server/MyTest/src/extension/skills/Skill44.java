package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;

/**收买**/
public class Skill44 extends Skill {

	@Override
	public Boolean check() {
		if(bf.usedCardStack.size()==0 && noInforeceive()){
			if(getOwner().handcards.size()>=4){
				for(Player p:bf.roleSeq){
					if(p.getUid()!=getOwner().getUid()){
						if(p.redCards.size()>0 || p.blackCards.size()>0 || p.blueCards.size()>0)return true;
					}
				}
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		playAni(false);
		
		bf.sResult.dispose();
		bf.waitfor(10*1000);
		userSelected(bf.sResult);
	}

	private void userSelected(SelectVO svo) {
		if(svo.cards==null){
			svo.cards=new ArrayList<Integer>();
		}
			if(svo.cards.size()<4){
				for(Card c:getOwner().handcards){
					if(svo.cards.indexOf(c.getVid())<0){
						svo.cards.add(c.getVid());
						if(svo.cards.size()==4)break;
					}
				}
			}
			ArrayList<Card> temp=new ArrayList<Card>();
			for(Integer i:svo.cards){
				temp.add(getOwner().removeCardFromHand(i, false));
			}
			Player target=bf.roleMap.get(getTvo().target);
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
			temp.clear();
			Card car=target.removeCardFromInfo(getTvo().card, false);
			temp.add(car);
			arr=new ActionscriptObject();
			bf.setCardsResp(arr, temp);
			resp.put("cards",arr);
			resp.putNumber("type",4);
			resp.putNumber("from",target.getUid());
			resp.putNumber("to",getOwner().getUid());
			bf.SendToALL(resp);
			bf.waitfor(2000);
			bf.getCard(getOwner(), temp, 1);
		
	}
	
}
