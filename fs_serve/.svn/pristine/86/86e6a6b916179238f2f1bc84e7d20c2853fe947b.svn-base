package skills
{
	import com.greensock.TweenMax;
	
	import flash.events.MouseEvent;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import utils.Rand;
	import utils.effect.EffectsManager;
	
	import views.ACard;

	/**
	 *偷天 
	 */	
	public class Skill13 extends Skill
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
//			var cid:int=data.card;
			var p:Player=phash.get(tvo.sponsor);
			p.view.showTime(9000);
			if(tvo.sponsor==GL.id){
				var t:Player=phash.get(tvo.target);
				var arr:Array=t.infocards;
				var temp:Array=[];
				for(var i:int in arr){
					var ac:ACard=new ACard();
					ac.setdata(arr[i]);
					temp.push(ac);
				}
				bv.showCardDialog(temp,"请选择一张情报发动",1,2);
			}else{
				bv.showInfo("请等待贝雷帽操作");
			}
		}
	}
}