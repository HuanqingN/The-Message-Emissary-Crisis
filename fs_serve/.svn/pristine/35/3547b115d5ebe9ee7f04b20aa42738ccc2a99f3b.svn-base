package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;

/**
 *遗志
 */
public class Skill15 extends Skill {

	@Override
	public Boolean check() {
		return (getOwner().getIsOpen()==true && getOwner().getIsDead()==true && getOwner().skillhash.get(this.id).launchCount<1 && getOwner().handcards.size()>0 && bf.thirdStep==StepCons.AfterDead);
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
		
		bf.sResult.dispose();
		bf.waitfor(10000);
		userSelected(bf.sResult);
	}

	private void userSelected(SelectVO svo) {
		if(svo.cards==null){
			
		}else{
			ArrayList<Card> temp=new ArrayList<Card>();
			for(Integer i:svo.cards){
				temp.add(getOwner().removeCardFromHand(i, false));
			}
			
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject arr=new ActionscriptObject();
			bf.setCardsResp(arr, temp);
			resp.putNumber("from",getOwner().getUid());
			resp.putNumber("to",getTvo().target);
			resp.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
			resp.put("cards",arr);
			resp.putNumber("h",2);
			resp.putNumber("f",27);
			bf.SendToALL(resp);
			
			bf.waitfor(2000);
//			bf.getCard(bf.roleMap.get(getTvo().target), temp, new ReflectVO("SuddenSkillSettlementEnd", bf), 1000);
			bf.getCard(bf.roleMap.get(getTvo().target), temp, 1);
		}
	}
	
}
