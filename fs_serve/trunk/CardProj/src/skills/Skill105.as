package skills
{
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;

	/**
	 * 心智迷茫
	 */	
	public class Skill105 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
				playNormalAni();
				App.audio.play("assets/sounds/skill/"+rid+"/"+id+"1.mp3");
		}
	}
}