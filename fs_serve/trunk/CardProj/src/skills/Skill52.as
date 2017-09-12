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
	 * 拷问
	 */	
	public class Skill52 extends Skill
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
			var sp:Player=phash.get(tvo.sponsor);
			sp.view.showTime(tvo.dur);
			if(sp.uid==GL.id){
				var temp:Array=[];
				var len:int=data.num;
				for (var i:int = 0; i < len; i++) 
				{
						var c:ACard=new ACard();
						c.bg.bitmapData=new Act0;
						temp.push(c);
				}
				
				bv.showCardDialog(temp,"请选择要抽取的卡牌",1,1);
			}else{
				bv.showInfo("请等待六姐操作");
			}
		}
	}
}