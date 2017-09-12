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
	 *吞噬
	 */	
	public class Skill158 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			if(obj.goOn){
				if(tvo1.sponsor==GL.id){
					bv.showSelectTarget("是否要放置情报?",onChoosed,true);
				}
			}else{
				var p:Player=phash.get(tvo.sponsor);
				playTurnAni(p.rid,0);
				App.audio.play(Cons.audio.TurnRole);
//				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
				p.rid=0;
			}
		}
		public function onChoosed(n:String):void{
			if(n=="nobtn"){
				var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,type:0,oid:bm.oid};
				SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
			}else{
				var p:Player=phash.get(tvo.sponsor);
				p.view.showTime(10000);
				if(p.uid==GL.id){
					bv.showInfo("请选择一张手牌");
					var arr:Array=p.hand;
					cards=[];
					for each(var c:ACard in arr){
						if(c.color>2){
							cards.push(c);
						}
					}
					this.showCards();
				}else{
					bv.showInfo("请等待暗流操作");
				}
			}
		}
		
		private var cardvid:int;
		override protected function onCardsSelect(evt:MouseEvent):void
		{
			cardvid=evt.currentTarget.vid;
			clearState();
			var arr:Array=phash.values();
			targets=[];
			for each(var i:Player in  arr){
				if(!i.isDead && !i.isLost){
					targets.push(i.view);
				}
			}
			bv.showInfo("请选择一个玩家发动");
			this.showTarget();
		}
		private var targetid:int=-1;
		override protected function onTargetSelect(evt:MouseEvent):void
		{
			targetid=evt.currentTarget.uid;
			App.log.info("第二次OID:::::: "+bm.oid);
			var param:Object={sponsor:GL.id,tid:GL.tableId,ctype:1,target:targetid,card:cardvid,type:1,oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
			clearState();
		}
	}
}