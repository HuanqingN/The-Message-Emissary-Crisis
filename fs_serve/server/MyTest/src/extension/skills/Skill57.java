package extension.skills;

import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cards.Card;
import extension.vo.SelectVO;
import extension.vo.SkillVO;

/**°®Çé**/
public class Skill57 extends Skill {

	@Override
	public Boolean check() {
		 if(getOwner().idenShow)return false;
		if((selfturn() && noInforeceive())){
			return hasBlack();
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().idenShow=true;
		playAni(false);
		bf.waitfor(1500);
		ActionscriptObject resp=new ActionscriptObject();
		resp.putNumber("from",-1);
		resp.putNumber("target",getOwner().getUid());
		resp.putNumber("iden",getOwner().getIndentity());
		resp.putNumber("h",2);
		resp.putNumber("f",30);
		bf.SendToALL(resp);
		bf.waitfor(3000);
	}
	private Boolean hasBlack(){
		for(Player p:bf.roleSeq){
			if(!p.getIsDead() && !p.isLost && p.blackCards.size()>0)return true;
		}
		return false;
	}
	@Override
	public void excute() {
		if(getOwner().getIsDead() || !hasBlack()){
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
			bf.waitfor(10000);
			userSelected(bf.sResult);
		}
	}
	private ArrayList<Integer> players;
	private ArrayList<ArrayList<Card>> temps;
	private int count=0;
	private void userSelected(SelectVO svo) {
		if(svo.cards==null){
			send();
		}else{
			if(players==null)players=new ArrayList<Integer>();
			if(temps==null)temps=new ArrayList<ArrayList<Card>>();
			ArrayList<Card> temp=new ArrayList<Card>();
			for(Integer i:svo.cards){
				temp.add(bf.cardsMap.get(i));
			}
			
			players.add(svo.target);
			temps.add(temp);
			count+=temp.size();
			
			if(count<3){
				excute();
			}else{
				send();
			}
//			bf.SendToALL(resp);
		}
	}

	private void send() {
		if(players==null){
			return;
		}else{
			for (int i = 0; i < players.size(); i++) {
				bf.Burn(players.get(i),temps.get(i));
			}
			players.clear();
			players=null;
			temps.clear();
			temps=null;
			count=0;
		}
	}
	
}
