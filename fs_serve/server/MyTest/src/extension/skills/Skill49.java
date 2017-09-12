package extension.skills;

import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;

/**先机**/
public class Skill49 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().getIsOpen())return false;
		if(blueSkillCheck())return true;
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
		Player p=bf.roleMap.get(getTvo().target);
		if(getOwner().getIsDead() || p.getIsDead()==true || p.isLost==true){
			return;
		}else{
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject arr=new ActionscriptObject();
			ActionscriptObject obj=new ActionscriptObject();
//			bf.setCardsResp(arr, p.handcards);
			getTvo().dur=10000;
			getTvo().setResponse(obj);
			resp.put("tvo",obj);
			resp.putNumber("h",2);
			resp.putNumber("f",25);
			resp.putNumber("oid",bf.operId);
			resp.putBool("goOn", true);
//			resp.put("cards",arr);
			resp.putNumber("num",p.handcards.size());
			bf.SendToALL(resp);
			
			bf.sResult.dispose();
			bf.waitfor(10*1000);
			userSelected(bf.sResult);
		}
	}

	private void userSelected(SelectVO svo) {
		if(svo.cards==null){
			targetDrawcard();
		}else{
			Player target=bf.roleMap.get(getTvo().target);
			ArrayList<Card> temp=new ArrayList<Card>();
			for(Integer i:svo.cards){
				temp.add(target.handcards.get(i));
//				temp.add(target.removeCardFromHand(c, false));
			}
			target.removeCardFromHand(temp,false);
			getOwner().addToHand(temp);
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject ca=new ActionscriptObject();
			ActionscriptObject arr=new ActionscriptObject();
			bf.setCardsResp(arr, temp);
			resp.putNumber("from",target.getUid());
			resp.putNumber("to",getOwner().getUid());
			resp.putNumber("type",1);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
			resp.put("cards",arr);
			resp.putNumber("h",2);
			resp.putNumber("f",27);
			bf.SendToALL(resp);
			
			bf.waitfor(1500);
			targetDrawcard();
		}
	}
	
	public void targetDrawcard(){
		bf.drawCard(bf.roleMap.get(getTvo().target), bf.getCardFromCardPack(1), 1, null);
		bf.waitfor(1500);
	}
	
	
}
