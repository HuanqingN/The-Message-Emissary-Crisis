package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.security.acl.Owner;
import java.util.ArrayList;

import extension.cards.Card;
import extension.vo.SkillVO;

/**合金装备**/
public class Skill64 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && getOwner().getIsOpen() && noInforeceive()){
			return true;
		}
		return false;
	}

	@Override
	public void reset() {
		if(launchCount==1){
			getOwner().isGod=false;
			ArrayList<Card> temp=new ArrayList<Card>();
			for(Card c:getOwner().blackCards){
				if(c.getTurn==bf.turncount){
					temp.add(c);
				}
			}
			getOwner().skillhash.get(this.id).launchCount++;
			if(temp.size()>0)
			bf.Burn(getOwner().getUid(), temp);
		}
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
		bf.waitfor(3000);
		getOwner().isGod=true;
		bf.usedCardStack.removeLast();
	}
	
}
