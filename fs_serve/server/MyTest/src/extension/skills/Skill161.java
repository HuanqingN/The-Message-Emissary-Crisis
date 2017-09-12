package extension.skills;
import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
/**
 *��˰��[��Ӧ��]��������������ƣ�ָ��һλ��ǰ�С���˰���鱨��������ҡ����㣺�ڸ������ǰ�����������ź��鱨
 */
public class Skill161 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().getIsDead() || getOwner().idenShow) return false;
		if(blueSkillCheck() && hasCardColor(6, getOwner())){
			for(Player p : bf.roleSeq){
				if(p != getOwner()){
					for(Card c : p.infocards){
						if(c.getId()==22)return true;
					}
				}
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		tvo.dur=10000;
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
//		resp.putNumber("target1",tvo.target);
		resp.putNumber("oid",bf.operId);
		resp.putNumber("from",-1);
		resp.putNumber("target",getOwner().getUid());
		resp.putNumber("iden",getOwner().getIndentity());
		bf.SendToALL(resp);
		getOwner().idenShow=true;
		bf.waitfor(4500);
	}

	@Override
	public void excute() {
		if(getOwner().getIsDead() || bf.roleMap.get(getTvo().target).getIsDead() || getOwner().handcards.size()==0){
			return;
		}
		if(!hasCardColor(6,getOwner())){
			return;
		}
		
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		getTvo().dur=10000;
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putBool("goOn", true);
		resp.putNumber("oid",bf.operId);
		bf.SendToALL(resp);
		
		bf.sResult.dispose();
		bf.waitfor(10*1000);
		userSelected(bf.sResult);
	}
	public void userSelected(SelectVO svo){
//		bf.isExcute=true;
		if(svo.type==0)return;
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject ca=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		int index=0;
		for(Integer i:svo.cards){
			ActionscriptObject obj=new ActionscriptObject();
			Card c=bf.cardsMap.get(i);
			c.setResponse(obj);
			arr.put(index++, obj);
			getOwner().removeCardFromHand(i,false);
		}
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("to",bf.roleMap.get(getTvo().target).getUid());
		resp.putNumber("type",3);  //type 1�ֿ����ֿ� 2 �鱨���ֿ� 3�ֿ����鱨 4�鱨���鱨 5�鱨���ⶥ 6�鱨���ƿⶥ 7�鱨�����ƶ� 8���ֿ��������е��鱨 9���ƿⶥ���鱨
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.waitfor(3000);
		excuteSkill(svo);
	}
	public void excuteSkill(SelectVO svo){
		if(svo.cards==null)return;
		Player target=bf.roleMap.get(getTvo().target);
		ArrayList<Card> cards=new ArrayList<Card>();
		for(Integer i:svo.cards){
			cards.add(bf.cardsMap.get(i));
		}
		bf.getCard(target, cards, 1);
	}
	
}
