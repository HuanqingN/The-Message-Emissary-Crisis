package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *�߻�����һλ��������״̬����һ�ô����ĺ����鱨ʱ���Ƿ��˽�ɫ�ƣ�Ȼ��������ڸ������ǰ����һ�ź��鱨
 */
public class Skill143 extends Skill {
	public Skill143(){
		auto=true;
	}

	@Override
	public Boolean check() {
		if(getOwner().getIsDead() || !getOwner().getIsOpen())return false;
		if(bf.nowStep==StepCons.InfoReceive && bf.skillstep==0 && bf.nowGetCards.size()>0 && bf.nowGetCardPlayer!=null && bf.nowGetCardPlayer.getIsLock()){
			for(Card c:bf.nowGetCards){
				if(c.getColor()!=3){
					return true;
				}
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		playAni(false);
		getOwner().setIsOpen(false);
		bf.sResult.dispose();
		bf.waitfor(11*1000);
		userSelected(bf.sResult);
	}
	public void userSelected(SelectVO svo){
		if(svo.cards==null || svo.cards.size()==0 || !hasCardColor(6, getOwner())){
			return;
		}
		Player target=bf.roleMap.get(this.nowGetCardPlayerUid);
		Card card=bf.cardsMap.get(svo.cards.get(0));
		getOwner().removeCardFromHand(card.getVid(),false);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject ca=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		card.setResponse(ca);
		arr.put(0,ca);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("to",target.getUid());
		resp.putNumber("type",3); //type 1�ֿ����ֿ� 2 �鱨���ֿ� 3�ֿ����鱨 4�鱨���鱨 5�ֿ����ƿⶥ 6�鱨���ƿⶥ 7�鱨�����ƶ� 8���ֿ��������е��鱨 9���ƿⶥ���鱨
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		
		bf.waitfor(2500);
		ArrayList<Card> temp=new ArrayList<Card>();
		temp.add(card);
		
		bf.getCard(bf.nowGetCardPlayer, temp, 1);
	}
}
