package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *侵蚀
 */
public class Skill87 extends Skill {

	@Override
	public Boolean check() {
		if(launchCount>=1 || getOwner().getIsDead() || !getOwner().getIsOpen())return false;
		if(!answer() && bf.nowGetCards.size()>0 && bf.nowGetCardPlayer==getOwner()){
			if(bf.nowGetCards.get(0).getColor()>2)return true;
		}
		return false;
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
		if(svo.cards==null){
		}else{
			ArrayList<Card> temp=new ArrayList<Card>(); //从卯先生情报区到目标手牌的牌
			Player target=bf.roleMap.get(getTvo().target);
			for(Integer i:svo.cards){
				temp.add(getOwner().removeCardFromInfo(i, false));
			}
			Card card1 = temp.get(0);
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject arr=new ActionscriptObject();
			bf.setCardsResp(arr, temp);
			resp.putNumber("from",getOwner().getUid());
			resp.putNumber("to",target.getUid());
			resp.putNumber("type",2);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
			resp.put("cards",arr);
			resp.putNumber("h",2);
			resp.putNumber("f",27);
			bf.SendToALL(resp);
			
			ArrayList<Card> temp2=new ArrayList<Card>();//从目标手牌到卯先生情报区的牌
			int num=(int)(Math.random()*target.handcards.size());
			temp2.add(target.removeCardFromHand(target.handcards.get(num).getVid(),false));
			Card card2 = temp2.get(0);
			resp=new ActionscriptObject();
			arr=new ActionscriptObject();
			bf.setCardsResp(arr, temp2);
			resp.putNumber("from",target.getUid());
			resp.putNumber("to",getOwner().getUid());
			resp.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
			resp.put("cards",arr);
			resp.putNumber("h",2);
			resp.putNumber("f",27);
			bf.SendToALL(resp);
			bf.waitfor(2000);
			target.addToHand(temp);
			bf.getCard(getOwner(), temp2, 1);
//			bf.getCard(getOwner(), temp, new ReflectVO("SuddenSkillSettlementEnd", bf), 1000);
			getOwner().skillhash.get(this.id).launchCount--;
			if(card1.getColor()>=3 && card2.getColor()>=3) bf.drawCard(getOwner(), bf.getCardFromCardPack(1), 1, null);
			bf.waitfor(1000);
		}
	}
	
}
