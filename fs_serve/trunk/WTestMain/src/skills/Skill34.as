package skills
{
	import com.greensock.TweenMax;
	
	import flash.events.MouseEvent;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import utils.effect.EffectsManager;
	
	import views.ACard;
	/**
	 * 牺牲
	 */
	public class Skill34 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playYellowAni();
//			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+1+".mp3");
			App.audio.play(Cons.audio.YELLOW);
			TweenMax.delayedCall(2,delayedFun);
		}
		override public function delayedFun():void
		{
			var p:Player=phash.get(tvo.sponsor);
			p.view.showTime(8000);
			if(p.uid==GL.id){
				bv.showInfo("请选择你要放置的一张黑色手牌");
				bv.showSelectTarget("请选择黑手牌点击确定发动",onSelected,true);
				var arr:Array=p.hand;
				cards=[];
				for each(var c:ACard in arr){
					if(c.color>2)
						cards.push(c);
				}
				this.showCards();
			}else{
				bv.showInfo("请等待老鬼操作");
			}
		}
		public function onSelected(str:String):void{
			var param:Object={tid:GL.tableId,ctype:1,type:1,card:cardvid,oid:bm.oid};
			if(cardvid==0){
				bv.showInfo("请先选择你要放置的一张黑色手牌再发动");
				return;
			}
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
			cardvid=0;
			clearState();
		}
		private var cardvid:int=-1;
		override protected function onCardsSelect(evt:MouseEvent):void
		{
			cardvid=evt.currentTarget.vid;
			clearState();
		}
	}
}