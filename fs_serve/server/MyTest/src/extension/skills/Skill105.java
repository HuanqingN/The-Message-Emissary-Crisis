package extension.skills;
import extension.cons.StepCons;
import extension.vo.SkillVO;
import extension.vo.TargetVO;
/**
 *������ã ���������ʹ�õĵ�����ɽ����󣬽����������
 */
public class Skill105 extends Skill {
	public Skill105(){
		auto=true;
	}
	@Override
	public Boolean check() {
		return (bf.thirdStep==0 && !getOwner().getIsDead() && bf.subStep==StepCons.CardSettlementEnd && ((TargetVO)bf.nowSettlement).cid==2 && ((TargetVO)bf.nowSettlement).sponsor!=getOwner().getUid());
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		playAni(false);
		bf.waitfor(1500);
		((TargetVO)bf.nowSettlement).moveto=getOwner().getUid();
		getOwner().addToHand(bf.cardsMap.get(((TargetVO)bf.nowSettlement).cvid));
	}
	
}
