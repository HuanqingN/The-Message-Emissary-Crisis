package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.cards.Card;
import extension.vo.SkillVO;
/**
 *ѳ�� ��������ʱ�������ѡ��һ�ź�ɫ���Ƹ�һλ�����Ϊ�鱨
 */
public class Skill127 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().getIsOpen()==true && getOwner().getIsDead()==true && getOwner().skillhash.get(this.id).launchCount<1 && hasCardColor(6,getOwner())){
			if(bf.getAlivePlayers().size()>1)return true;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
		bf.waitfor(1500);
		ArrayList<Card> temp=new ArrayList<Card>();
		Card c=bf.cardsMap.get(tvo.card);
		temp.add(c);
		getOwner().removeCardFromHand(c,false);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("to",tvo.target);
		resp.putNumber("type",3);  //type 1�ֿ����ֿ� 2 �鱨���ֿ� 3�ֿ����鱨 4�鱨���鱨5�ֿ����ƿⶥ
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.waitfor(2000);
		bf.getCard(bf.roleMap.get(tvo.target),temp, 3);
	}
	
}