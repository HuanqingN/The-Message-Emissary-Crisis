package extension.skills;

import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;


/**
 *黄雀在后
 */
public class Skill11 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().getIsDead())return false;
		if(getOwner().getIsOpen()==true && bf.deadman!=null &&  bf.thirdStep==StepCons.AfterDead){
			for(Card c:getOwner().handcards){
				if(c.getColor()>2)return true;
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
		bf.sResult.dispose();
		bf.waitfor(10*1000);
		userSelected(bf.sResult);
	}

	private void userSelected(SelectVO svo) {
		if(svo.cards==null){
//			bf.SuddenSkillSettlementEnd();
			launchCount=0;
			return;
		}
		ArrayList<Card> cas=new ArrayList<Card>();
		for(Integer cid:svo.cards){
			cas.add(bf.cardsMap.get(cid));
		}
		getOwner().removeCardFromHand(cas, false);
		
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject ca=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, cas);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("to",getTvo().target);
		resp.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		
		bf.waitfor(2000);
//		bf.getCard(bf.roleMap.get(getTvo().target), cas,new ReflectVO("skillend",this),1000);
		bf.getCard(bf.roleMap.get(getTvo().target), cas, 1);
		launchCount=0;
	}
}
