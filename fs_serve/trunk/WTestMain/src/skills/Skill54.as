package skills
{
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import utils.Rand;

	/**
	 * 严刑
	 */
	public class Skill54 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
				playYellowAni();
				App.audio.play(Cons.audio.YELLOW);
				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,3)+".mp3");
		}
	}
}