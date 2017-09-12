package skills
{
	import flash.events.MouseEvent;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import utils.Rand;

		/**
		 * 火来水淹
		 */	
		public class Skill124 extends Skill
		{
			override public function play(tvo1:SkillVO,obj:Object):void
			{
				super.play(tvo1,obj);
				playYellowAni();
				App.audio.play(Cons.audio.YELLOW);
			}
		}
}