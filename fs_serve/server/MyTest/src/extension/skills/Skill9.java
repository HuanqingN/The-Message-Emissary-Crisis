package extension.skills;

import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;

/**Ǳ�ط���**/
public class Skill9 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().getIsOpen()==false){
//			if((noInforeceive() && selfturn()) || bf.nowStep==StepCons.InfoSend){
			if(blueSkillCheck()){
				if(hashInfoByOther())return true;
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
		if(getOwner().getIsDead() || bf.roleMap.get(getTvo().target).getIsDead() || !hasInfoBySomeone(bf.roleMap.get(getTvo().target)) || getTvo().cards.size()==0){ //��Ϊcards��������ܵĿͻ�����һ�������������������size==0�ж϶����ǣ�=null
			return;
		}
		Card card=bf.cardsMap.get(getTvo().cards.get(0));		
		Player target=bf.roleMap.get(getTvo().target);
		if(!target.hasInfoCard(card)){
			return;
		}
		target.removeCardFromInfo(card,false);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject ca=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		card.setResponse(ca);
		arr.put(0,ca);
		resp.putNumber("from",target.getUid());
		resp.putNumber("type",6);  //type 1�ֿ����ֿ� 2 �鱨���ֿ� 3�ֿ����鱨 4�鱨���鱨5�ֿ����ƿⶥ6�鱨���ƿⶥ
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.cards.add(0, card);
		bf.waitfor(2000);
	}
	
}
