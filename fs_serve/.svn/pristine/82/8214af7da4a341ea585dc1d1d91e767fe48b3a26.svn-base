package extension.skills;
import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.cards.Card;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *反噬
 */
public class Skill86 extends Skill {

	@Override
	public Boolean check() {
		if(!getOwner().getIsDead() && !getOwner().getIsOpen() && noInforeceive()){
			if(hasCardColor(6,getOwner()))return true;
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
		if(getOwner().getIsDead() || !hasCardColor(6,getOwner())){
			return;
		}else{
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject obj=new ActionscriptObject();
			getTvo().dur=10000;
			getTvo().setResponse(obj);
			resp.put("tvo",obj);
			resp.putNumber("h",2);
			resp.putNumber("f",25);
			resp.putNumber("oid",bf.operId);
			resp.putBool("goOn", true);
			bf.SendToALL(resp);
			
			bf.sResult.dispose();
			bf.waitfor(10*1000);
			userSelected(bf.sResult);
		}
	}

	private void userSelected(SelectVO svo) {
		if(svo.cards==null){
			svo.cards=new ArrayList<Integer>();
			for(Card ca:getOwner().handcards){
				if(ca.getColor()>2){
					svo.cards.add(ca.getVid());
					break;
				}
			}
		}
		
		ArrayList<Card> temp=new ArrayList<Card>();
		for(Integer i:svo.cards){
			temp.add(getOwner().removeCardFromHand(i, false));
		}
		getOwner().addToHand(temp);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("to",getOwner().getUid());
		resp.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		
		bf.waitfor(2000);
		bf.getCard(getOwner(), temp, 1);
	}
}
