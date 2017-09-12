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
	 *黑枪射击 
	 *当一位玩家获得第二张黑情报时，你可以弃掉两张手牌在他面前放置一张黑色情报
	 */	
	public class Skill75 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			if(obj.goOn){
				var p:Player=phash.get(tvo.sponsor);
				p.view.showTime(10000);
				if(p.uid==GL.id){
					bv.showInfo("请选择一张黑色手牌");
					var arr:Array=phash.get(GL.id).hand;
					cards=[];
					for each(var c:ACard in arr){
						if(c.color>2)
						cards.push(c);
					}
					this.showCards();
				}else{
					bv.showInfo("请等待厄运小姐操作");
				}
			}else{
				playYellowAni();
				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,3)+".mp3");
				TweenMax.delayedCall(3,delayedFun1);
			}
		}
		public function delayedFun1():void{
			var p:Player=phash.get(tvo.sponsor);
			p.view.showTime(10000);
			if(p.uid==GL.id){
				var temp:Array=[];
				for(var i:int in p.hand){
						var c:ACard=new ACard();
						c.setdata(p.hand[i]);
						temp.push(c);
				}
				bv.showCardDialog(temp,"请选择两张手牌丢弃",2,2);
			}else{
				bv.showInfo("请等待厄运小姐操作");
			}
		}
		private var cardvid:int;
		override protected function onCardsSelect(evt:MouseEvent):void
		{
			cardvid=evt.currentTarget.vid;
			var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,card:cardvid,oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
			clearState();
		}
	}
}