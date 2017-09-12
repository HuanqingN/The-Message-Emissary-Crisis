package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *������ֲ:��һλ�����ǰ���鱨���ջ�ʱ������Խ��Լ���ǰ��һ���鱨ת�õ�����ǰ
 */
public class Skill116 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && !getOwner().getIsDead() && bf.thirdStep==StepCons.AfterBurn && bf.burnTarget!=getOwner().getUid()){
			return getOwner().infocards.size()>0;
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
		bf.waitfor(3000);
		Card card=bf.cardsMap.get(tvo.card);
		getOwner().removeCardFromInfo(card, false);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject ca=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		card.setResponse(ca);
		arr.put(0,ca);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("to",bf.burnTarget);
		resp.putNumber("type",4);  //type 1�ֿ����ֿ� 2 �鱨���ֿ� 3�ֿ����鱨 4�鱨���鱨 5�ֿ����ƿⶥ 6�鱨���ƿⶥ 7�鱨�����ƶ� 8���ֿ��������е��鱨 9���ƿⶥ���鱨
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		
		bf.waitfor(2000);
		
		Player target=bf.roleMap.get(bf.burnTarget);
		ArrayList<Card> cards=new ArrayList<Card>();
		cards.add(card);
		bf.getCard(target, cards, 1);	
		bf.waitfor(2000);
	}
}
