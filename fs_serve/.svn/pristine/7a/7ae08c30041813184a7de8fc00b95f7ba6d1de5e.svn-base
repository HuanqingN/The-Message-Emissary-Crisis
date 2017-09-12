package extension.skills;


import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;

/**狙击**/
public class Skill72 extends Skill {

	@Override
	public Boolean check() {
		if(!getOwner().getIsOpen() && blueSkillCheck()){
			for(Player p:bf.roleSeq){
				if(p.getUid()!= getOwner().getUid()){
					if(p.blackCards.size()>0 || p.redCards.size()>0 || p.blueCards.size()>0)return true;
				}
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().setIsOpen(true);
		playAni(true);
		
		
	}
	
	@Override
	public void excute() {
		if(getOwner().getIsDead() || bf.roleMap.get(getTvo().target).getIsDead())return;
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		getTvo().dur=10000;
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		resp.putBool("goOn", true);
		bf.SendToALL(resp);
		bf.sResult.dispose();
		bf.waitfor(10*1000);
		userSelected(bf.sResult);
	}

	private void userSelected(SelectVO svo) {
		if(svo.cards==null){
			return;
		}else{
			Player target=bf.roleMap.get(getTvo().target);
			ArrayList<Card> temp=new ArrayList<Card>();
			for(Integer i:svo.cards){
				temp.add(bf.cardsMap.get(i));
			}
			bf.Burn(target.getUid(),temp);
//			ActionscriptObject resp=new ActionscriptObject();
//			ActionscriptObject arr=new ActionscriptObject();
//			bf.setCardsResp(arr, temp);
//			resp.putNumber("from",target.getUid());
//			resp.putNumber("type",7);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
//			resp.put("cards",arr);
//			resp.putNumber("h",2);
//			resp.putNumber("f",27);
//			bf.SendToALL(resp);
//			
//			bf.waitfor(2000, null);
		}
	}
	
}
