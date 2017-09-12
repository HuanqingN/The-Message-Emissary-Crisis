package skills
{
	import com.greensock.TweenMax;
	
	import core.mng.Player;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import utils.Rand;
	
	import views.ACard;

	/**
	 * 情报诱捕
	 */	
	public class Skill91 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playYellowAni();
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,3)+".mp3");
			App.audio.play(Cons.audio.YELLOW);
			TweenMax.delayedCall(3,delayedFun);
		}
		override public function delayedFun():void
		{
			if(!data.cards)return;
			var p:Player=phash.get(tvo.sponsor);
			p.view.showTime(10000);
			if(p.uid==GL.id){
				var temp:Array=[];
				var arr:Array=data.cards;
				for(var i in arr){
					var ac:ACard=new ACard();
					ac.setdata(arr[i]);
					temp.push(ac);
				}
				bv.showCardDialog(temp,"请选择一张手牌",1,2);
			}else{
				bv.showInfo("请等待诺娃操作");
			}
		}
	}
}