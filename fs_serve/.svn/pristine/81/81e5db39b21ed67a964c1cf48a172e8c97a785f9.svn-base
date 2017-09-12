package skills
{
	import com.greensock.TweenMax;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import utils.Rand;
	
	import views.ACard;

	/**
	 *搜取 
	 */	
	public class Skill53 extends Skill
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
			var p:Player=phash.get(tvo.sponsor);
			p.view.showTime(9000);
			if(tvo.sponsor==GL.id){
				var temp:Array=[];
				var arr:Array=data.cards;
				for(var i:int in arr){
					var ac:ACard=new ACard();
					ac.setdata(arr[i]);
					temp.push(ac);
				}
				bv.showCardDialog(temp,"请选择一张手牌",1,66);
			}else{
				bv.showInfo("请等待六姐操作");
			}
		}
	}
}