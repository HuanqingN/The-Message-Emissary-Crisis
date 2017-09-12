package skills
{
	import com.greensock.TweenMax;
	
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import utils.Rand;

	/**
	 *反击 
	 */	
	public class Skill66 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playYellowAni();
			App.audio.play(Cons.audio.YELLOW);
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+"1.mp3");
		}
	}
}