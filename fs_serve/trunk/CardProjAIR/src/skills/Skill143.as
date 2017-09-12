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
	
	import views.ACard;
	
	/**
	 *催化
	 */	
	public class Skill143 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			var p:Player=phash.get(tvo.sponsor);
			playTurnAni(p.rid,0);
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
			p.rid=0;
			TweenMax.delayedCall(1,delayedFun1);
		}
		public function delayedFun1():void{
			var p:Player=phash.get(tvo.sponsor);
			p.view.showTime(tvo.dur-1000);
			if(tvo.sponsor==GL.id){
			var temp:Array=[];
				var arr:Array=phash.get(GL.id).hand;
				for each(var c:ACard in arr){
					if(c.color>2){
						var acard:ACard=new ACard();
						acard.setdata(c);
						temp.push(acard);
					}
				}
				bv.showCardDialog(temp,"请选择一张黑色手牌，不想放置请直接按确定",1,2);
			}else{
				bv.showInfo("请等待双面药师操作");
			}
		}
	}
}