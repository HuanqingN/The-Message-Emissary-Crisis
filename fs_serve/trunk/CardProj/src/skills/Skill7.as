package skills
{
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import utils.Rand;
	
	
	/**
	 *截上截
	 */	
	public class Skill7 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playTurnAni(0,obj.rid);
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
			App.audio.play(Cons.audio.TurnRole);
			var p:Player=phash.get(tvo.sponsor);
			p.rid=data.rid;
		}
	}
}