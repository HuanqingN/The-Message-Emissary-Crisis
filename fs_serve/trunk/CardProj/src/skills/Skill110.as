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
		 * 萦绕
		 */	
		public class Skill110 extends Skill
		{
			override public function play(tvo1:SkillVO,obj:Object):void
			{
				super.play(tvo1,obj);
				playNormalAni();
			}
		}
}