package skills
{
	import com.greensock.TweenMax;
	
	import core.mng.Evt;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import handlers.BattleHandler;
	
	import utils.Rand;
	
	import views.ProbeView;

	/**
	 * 真相
	 */
	public class Skill1 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playNormalAni();
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
			TweenMax.delayedCall(1,delayedFun);
		}
		override public function delayedFun():void
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