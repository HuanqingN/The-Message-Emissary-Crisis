package skills
{
	import com.greensock.TweenMax;
	
	import flash.events.MouseEvent;
	
	import core.mng.Evt;
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import handlers.BattleHandler;
	
	import utils.Rand;
	import utils.effect.EffectsManager;
	
	import views.ACard;

	/**
	 * 笑里藏刀
	 */	
	public class Skill19 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playNormalAni();
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
			TweenMax.delayedCall(1,delayedFun1);
		}
		
		override public function playAni():void
		{
			playNormalAni();
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
		}
		public function delayedFun1():void{
			if(tvo.sponsor==GL.id){
				bv.showInfo("请选择你要放置的一张黑色手牌");
				bv.showSelectTarget("请选择黑手牌点击确定发动",onSelected,true);
				var arr:Array=phash.get(GL.id).hand;
				cards=[];
				for each(var c:ACard in arr){
					if(c.color>2)
						cards.push(c);
				}
				this.showCards();
				phash.get(GL.id).view.showTime(tvo.dur-1000);
			}else{
				bv.showInfo("请等待戴笠操作");
				var p:Player=phash.get(tvo.sponsor);
				p.view.showTime(tvo.dur-1000);
			}
		}
		public function onSelected(str:String):void{
			var param:Object={tid:GL.tableId,ctype:1,type:1,card:cardvid,oid:bm.oid};
			if(cardvid<0 || str=="nobtn")param.type=0;
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
			cardvid=-1;
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