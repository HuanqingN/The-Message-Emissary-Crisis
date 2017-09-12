package skills
{
	import com.greensock.TweenMax;
	
	import flash.events.MouseEvent;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import morn.core.components.Clip;
	
	import utils.ArrayUtil;
	import utils.HashMap;
	import utils.Rand;

		/**
		 * 筹备圣战
		 */	
		public class Skill148 extends Skill
		{
			override public function play(tvo1:SkillVO,obj:Object):void
			{
				super.play(tvo1,obj);
				playNormalAni();
//				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
			}
		}
}