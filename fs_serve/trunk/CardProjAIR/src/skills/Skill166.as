package skills
{
	import datas.SkillVO;
	import core.mng.Player;

	/**
	 * 严酷戒律
	 */	
	public class Skill166 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			var p:Player=phash.get(tvo.sponsor);
			playNormalAni();
//			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+1+".mp3");
		}
	}
}