package skills
{
	import com.greensock.TweenMax;
	
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import utils.Rand;

	/**
	 *救美 
	 */	
	public class Skill30 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playNormalAni();
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
		}
	}
}