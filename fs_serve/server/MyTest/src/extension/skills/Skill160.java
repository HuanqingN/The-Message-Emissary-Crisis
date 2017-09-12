package extension.skills;
import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *��˰��[��Ӧ��]�������������һ�š���˰���Ƴ���Ϸ�����㣺�������ƣ�Ȼ��ѡ��һ�����ƷŻ��ƿⶥ��
 */
public class Skill160 extends Skill {

	@Override
	public Boolean check() {
		if(!disabled && (answer() || bf.nowStep==StepCons.InfoSend || (noInforeceive() && selfturn()))){
			for(Card c:getOwner().handcards){
				if(c.getId()==22)return true;//22����˰
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		playAni(false);
		bf.waitfor(1000);
		ArrayList<Card> temp=new ArrayList<Card>();
		temp.add(bf.cardsMap.get(tvo.card));
		bf.disCard(getOwner(), temp, 1, null);
		bf.waitfor(2000);
//		disCardend();
	}
//	public void disCardend(){
	@Override
	public void excute() {
//		bf.drawCard(getOwner(), , 1,new ReflectVO("drawCardend", this,2000));
		if(getOwner().getIsDead())return;
		ArrayList<Card> temp=new ArrayList<Card>();
		temp=bf.getCardFromCardPack(3);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		getTvo().dur=10000;
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putBool("goOn", true);
		resp.putNumber("rid", getOwner().getRoleId());
		resp.putNumber("num",3);//�ĳ������Ļ��ǵø�����
		resp.putNumber("oid",bf.operId);
		resp.put("cards", arr);
		bf.SendToALL(resp);
		getOwner().addToHand(temp);
		drawCardend();
	}
	public void drawCardend(){
		bf.sResult.dispose();
		bf.waitfor(10000);
		userSelected(bf.sResult);
	}

	private void userSelected(SelectVO svo) {
		if(svo.cards==null){
			svo.cards=new ArrayList<Integer>();
			for(Card c:getOwner().handcards){
				svo.cards.add(c.getVid());
				if(svo.cards.size()==1)break;
			}
		}
		ArrayList<Card> temp=new ArrayList<Card>();
		for(Integer i:svo.cards){
			temp.add(getOwner().removeCardFromHand(i, false));
		}
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("type",5);  //type 1�ֿ����ֿ� 2 �鱨���ֿ� 3�ֿ����鱨 4�鱨���鱨 5�鱨���ⶥ 6�鱨���ƿⶥ 7�鱨�����ƶ� 8���ֿ��������е��鱨 9���ƿⶥ���鱨
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		
		bf.waitfor(2000);
		bf.cards.addAll(0, temp);
//		bf.usedCardStack.removeLast();
	}
	
}
