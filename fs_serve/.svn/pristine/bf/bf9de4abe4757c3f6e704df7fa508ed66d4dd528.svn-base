package extension.skills;

import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.vo.SelectVO;
import extension.vo.SkillVO;


/**釜底抽薪**/
public class Skill24 extends Skill {

	@Override
	public Boolean check() {
		if(launchCount>=1 || getOwner().getIsDead())return false;
		if(getOwner().getIsOpen() && bf.nowGetCards.size()>0  && bf.nowGetCardPlayer==getOwner() && hasCardColor(6, getOwner())){
			return true;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
		bf.sResult.dispose();
		bf.waitfor(11000);
		userSelected(bf.sResult);
	}

	private void userSelected(SelectVO svo) {
		if(svo.card==0)return;
		ArrayList<Card> temp=new ArrayList<Card>();
		Card c=getOwner().removeCardFromHand(svo.card, false);
		temp.add(c);
		getOwner().setIsOpen(false);
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

		bf.getCard(getOwner(), temp, 1);
		if(!getOwner().getIsDead()){
			ArrayList<Player> alive=bf.getAlivePlayers();
			if(getOwner().handcards.size()==0)return;
//			while(alive.size()>0){
				ActionscriptObject resp1=new ActionscriptObject();
				ActionscriptObject obj=new ActionscriptObject();
				ActionscriptObject arr1=new ActionscriptObject();
				int index=0;
				for(Player p:alive){
					if(p!=getOwner())arr1.putNumber(index++, p.getUid());
				}
				getTvo().setResponse(obj);
				resp1.put("tvo",obj);
				resp1.putNumber("h",2);
				resp1.putNumber("f",25);
				resp1.putNumber("oid",bf.operId);
				resp1.putBool("goOn",true);
				resp1.put("users",arr1);
				bf.SendToALL(resp1);
				bf.sResult.dispose();
				bf.waitfor(10000);
				userSelected1(bf.sResult,alive);
//			}
		}
	}

	private void userSelected1(SelectVO svo,ArrayList<Player> alive) {
		if(svo.type==0){
			alive.clear();
			return;
		}
		if(svo.target==0 || svo.card==0){
			return;
		}else{
			ArrayList<Card> temp=new ArrayList<Card>();
			Player target=bf.roleMap.get(svo.target);
			Card c=getOwner().removeCardFromHand(svo.card, false);
			temp.add(c);
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject arr=new ActionscriptObject();
			bf.setCardsResp(arr, temp);
			resp.putNumber("from",getOwner().getUid());
			resp.putNumber("to",svo.target);
			resp.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
			resp.put("cards",arr);
			resp.putNumber("h",2);
			resp.putNumber("f",27);
			bf.SendToALL(resp);
			bf.waitfor(2000);
			bf.getCard(target, temp,1);
			alive.remove(target);
			if(getOwner().getIsDead() || getOwner().handcards.size()==0)alive.clear();
		}
	}
	
}
