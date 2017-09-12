package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.vo.SelectVO;
import extension.vo.SkillVO;

/**出卖 弃掉你面前的二张红或蓝情报，获取另一玩家面的任意一张情报**/
public class Skill45 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && blueSkillCheck()){
			int num=getOwner().redCards.size()+getOwner().blueCards.size();
			if(num>=2){
				return hashInfoByOther();
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
		bf.waitfor(13*1000);
		userSelected(bf.sResult);
	}

	private void userSelected(SelectVO svo) {
		if(svo.cards==null){
			svo.cards=new ArrayList<Integer>();
		}
		if(svo.cards.size()<2){
			for(Card c:getOwner().infocards){
				if(c.getColor()!=3 && svo.cards.indexOf(c.getVid())<0){
					svo.cards.add(c.getVid());
					if(svo.cards.size()==2)break;
				}
			}
		}
		ArrayList<Card> temp=new ArrayList<Card>();
		for(Integer i:svo.cards){
			temp.add(getOwner().removeCardFromInfo(i, false));
		}
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("type",7);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.waitfor(2000);
		 resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		resp.putBool("goOn",true);
		bf.SendToALL(resp);
		
		bf.sResult.dispose();
		bf.waitfor(10000);
		userSelected1(bf.sResult);
	}
	
	private void userSelected1(SelectVO svo){
		Player target=bf.roleMap.get(getTvo().target);
		if(svo.cards==null){
			return;
		}
		ArrayList<Card> temp=new ArrayList<Card>();
		
		Card result=target.removeCardFromInfo(svo.cards.get(0), false);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		temp.add(result);
		bf.setCardsResp(arr, temp);
		resp.put("cards",arr);
		resp.putNumber("type",4);
		resp.putNumber("from",target.getUid());
		resp.putNumber("to",getOwner().getUid());
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.waitfor(2000);
		bf.getCard(getOwner(), temp, 1);
	}
	
}
