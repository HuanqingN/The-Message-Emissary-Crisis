package skills
{
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import views.ACard;
	import views.ProbeView;
	
	/**
	 *速译 
	 */	
	public class Skill5 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			if(obj.goOn){
				excuteBlue();
			}else{
				playTurnAni(0,obj.rid);
				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+1+".mp3");
				App.audio.play(Cons.audio.TurnRole);
				var p:Player=phash.get(tvo.sponsor);
				p.rid=data.rid;
			}
		}
		override public function excuteBlue():void
		{
			var obj:Object=data.sendcard;
			if(GL.id==tvo.sponsor){
				if(!bv.probeView)bv.probeView=new ProbeView();
				bv.probeView.showType=2;
				bv.probeView.setData({cid:obj.id,color:obj.color},null);
				bv.probeView.popupCenter=true;
				App.dialog.show(bv.probeView);
			}
		}
	}
}