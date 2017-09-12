package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *ӿ����[������]��ĳ��ƽ׶Σ������ϴ�����ǰ�����Ż����Ϻ��鱨��������ң�����Է����˽�ɫ�ƣ�����X�����ƣ�Ȼ���X+2����
 */
public class Skill156 extends Skill {

	@Override
	public Boolean check() {
		if(!getOwner().getIsDead() && !getOwner().getIsOpen() && bf.nowPlayer==getOwner() && getOwner().handcards.size()>0 && (bf.nowStep==StepCons.CardUse1 || bf.nowStep==StepCons.CardUse2) && bf.usedCardStack.size()==0 ){
			for(Player p:bf.roleSeq){
				if(p!=getOwner() && p.blackCards.size()>=2){
					return true;
				}
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().setIsOpen(true);
		playAni(true);
		bf.sResult.dispose();
		bf.waitfor(12000);
		userSelected(bf.sResult);
		
	}
	
	private void userSelected(SelectVO svo){
		ArrayList<Card> temp=new ArrayList<Card>();
		if(svo.cards!=null){
			for(Integer i:svo.cards){
				temp.add(bf.cardsMap.get(i));
			}
			bf.disCard(getOwner(), temp, 1, null);
			bf.waitfor(2000);
		}
		bf.drawCard(getOwner(),bf.getCardFromCardPack(temp.size()+2) , 1, null); 
		bf.waitfor(1500);
	}
	
}