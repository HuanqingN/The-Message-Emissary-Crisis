package skills
{
	import com.greensock.TweenMax;
	
	import datas.SkillVO;
	
	import utils.Rand;

	public class Skill14 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playNormalAni();
		}
	}
}