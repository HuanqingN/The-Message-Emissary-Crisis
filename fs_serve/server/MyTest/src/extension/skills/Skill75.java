package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.vo.SelectVO;
import extension.vo.SkillVO;

//��ǹ��� ��һλ��һ�õڶ��ź��鱨ʱ�������������������������ǰ����һ�ź�ɫ�鱨
public class Skill75 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && getOwner().handcards.size()>=3 && bf.nowGetCards.size()>0 && bf.nowGetCardPlayer.blackCards.size()==2){
			for(Card c:bf.nowGetCards){
				if(c.getColor()>2){
					return true;
				}
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
		tvo.target=bf.roleMap.get(this.nowGetCardPlayerUid).getUid();
		playAni(false);
		bf.sResult.dispose();
		bf.waitfor(13*1000);
		DiscardResult(bf.sResult);
	}
	public void DiscardResult(SelectVO svo){
		if(svo.cards==null){//�����һ1��Ҫ�Լ�ѡ��������
			svo.cards=new ArrayList<Integer>();
		}	
		if(svo.cards.size()<2){
			for(Card c:getOwner().handcards){
				if(svo.cards.indexOf(c.getVid())<0){
					svo.cards.add(c.getVid());
					if(svo.cards.size()==2)break;
				}
			}
		}
		ArrayList<Card> temp=new ArrayList<Card>();
		for(Integer i:svo.cards){
			temp.add(bf.cardsMap.get(i));
		}
		bf.disCard(getOwner(), temp, 1, null);
		bf.waitfor(2000);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		getTvo().dur=10000;
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		resp.putBool("goOn",true);
		bf.SendToALL(resp);
		bf.sResult.dispose();
		bf.waitfor(10*1000);
		userSelected(bf.sResult);
	}

	private void userSelected(SelectVO svo) {
		if(svo.card==0){
			return ;
		}else{
			Card card=bf.cardsMap.get(svo.card);
			Player target=bf.roleMap.get(getTvo().target);
			ArrayList<Card> temp=new ArrayList<Card>();
			temp.add(card);
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject ca=new ActionscriptObject();
			ActionscriptObject arr=new ActionscriptObject();
			bf.setCardsResp(arr,temp);
			resp.putNumber("from",getOwner().getUid());
			resp.putNumber("to",target.getUid());
			resp.putNumber("type",3);  //type 1�ֿ����ֿ� 2 �鱨���ֿ� 3�ֿ����鱨 4�鱨���鱨5�ֿ����ƿⶥ
			resp.put("cards",arr);
			resp.putNumber("h",2);
			resp.putNumber("f",27);
			bf.SendToALL(resp);
			
			bf.waitfor(2000);
			bf.getCard(target, temp, 1);
		}
	}
	
}
