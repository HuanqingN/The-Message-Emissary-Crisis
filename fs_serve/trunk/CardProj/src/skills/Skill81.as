package skills
{
	import com.greensock.TweenMax;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import utils.Rand;

	/**
	 * "易容"
	 */	
	public class Skill81 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playNormalAni();
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,3)+".mp3");
			TweenMax.delayedCall(1,delayedFun);
		}
		override public function delayedFun():void
		{
			var p:Player=phash.get(tvo.sponsor);
			if(GL.id==p.uid){
				p.skillHash.clear();
				p.skillHash=null;
				p.clearRoleTip();
				p.rid=data.newRid;
				bv.initSkillInfo(p);
			}else{
				p.skillHash=null;
				if(GL.roleData.get(data.newRid).h==0){
					p.clearRoleTip(); //清除角色说明。需要写在set rid函数之前。
					p.rid=data.newRid;
				}
				else{
					p.rid=0;
				}
			}
		}
	}
}