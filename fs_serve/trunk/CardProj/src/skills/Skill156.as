package skills
{
	import com.greensock.TweenMax;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import manage.BM;
	
	import utils.Rand;
	
	import views.ACard;
	
	/**
	 *涌动
	 */	
	public class Skill156 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playTurnAni(0,obj.rid);
			App.audio.play(Cons.audio.TurnRole);
			//				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
			var p:Player=phash.get(tvo.sponsor);
			p.rid=data.rid;
			TweenMax.delayedCall(2,delayfun)				
		}
		public function delayfun():void
		{
			var p:Player=phash.get(tvo.sponsor);
			p.view.showTime(10000);
			if(p.uid==GL.id){
				var temp:Array=[];
				for(var i:int in p.hand){
					var c:ACard=new ACard();
					c.setdata(p.hand[i]);
					temp.push(c);
				}
				bv.showCardDialog(temp,"请选择任意张手牌丢弃",temp.length,2);
			}else{
				bv.showInfo("请等待暗流操作");
			}
		}
		private var cardvid:int;
		override protected function onCardsSelect(evt:MouseEvent):void
		{
			cardvid=evt.currentTarget.vid;
			var param:Object={tid:GL.tableId,ctype:1,type:1,card:cardvid,oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
			clearState();
		}
	}
}