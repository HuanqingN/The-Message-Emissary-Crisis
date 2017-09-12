package extension.skills;

import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;

/**牺牲**/
public class Skill34 extends Skill {

	@Override
	public Boolean check() {
//		if(getOwner().skillhash.get(this.id).launchCount<1 && getOwner().getIsOpen() && selfturn() && noInforeceive() && getOwner().handcards.size()>0){
//			for(Card c:getOwner().handcards){
//				if(c.getColor()>2)return true;
//			}
//		}
//		if(getOwner().skillhash.get(this.id).launchCount<1 && getOwner().getIsOpen() && answer() && getOwner().handcards.size()>0){
//			for(Card c:getOwner().handcards){
//				if(c.getColor()>2){
//					return true;
//				}
//				
//			}
//		}
		if(getOwner().skillhash.get(this.id).launchCount<1 && getOwner().getIsOpen() && blueSkillCheck() && getOwner().handcards.size()>0){
			for(Card c:getOwner().handcards){
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
		playAni(false);
		getOwner().skillhash.get(this.id).launchCount++;
		bf.sResult.dispose();
		bf.waitfor(10000);
		userSelected(bf.sResult);
	}

	private void userSelected(SelectVO svo) {
		if(svo.card<=0){
			for(Card ca:getOwner().handcards){
				if(ca.getColor()>2){
					svo.card=ca.getVid();
					break;
				}
			}
		}
		ArrayList<Card> temp=new ArrayList<Card>();
		
		temp.add(getOwner().removeCardFromHand(svo.card, false));
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("to",getOwner().getUid());
		resp.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		
		bf.waitfor(2000);
		getInfo=temp;
		bf.drawCard(getOwner(),bf.getCardFromCardPack(1) , 1, null);
		bf.waitfor(1500);
		drawcardend();
	}
	private ArrayList<Card> getInfo=null;
	public void drawcardend(){
		if(getInfo==null){
			return;
		}else{
			bf.getCard(getOwner(), getInfo, 1);
		}
	}
}
