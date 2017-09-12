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
	
	import views.ACard;
	
	/**
	 * 收税
	 */	
	public class Skill160 extends Skill
	{
		override public function launch():void
		{
			bv.showInfo("请选择一张纳税发动");
			var arr:Array=phash.get(GL.id).hand;
			cards=[];
			for each(var c:ACard in arr){
				if(c.id==22)cards.push(c);
			}
			this.showCards();
		}
		private var cardvid:int;
		override protected function onCardsSelect(evt:MouseEvent):void
		{
			cardvid=evt.currentTarget.vid;
			var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,card:cardvid,oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnSkillLaunch,param);
			clearState();
		}
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			if(obj.goOn){
				data.to=tvo.sponsor;
				if(GL.id!=tvo.sponsor)data.cards=null;
				data.type=1;
				Evt.dipatch(BattleHandler.onAddCard,data);
				TweenMax.delayedCall(1,delayedFun1);
			}else{
				playNormalAni();
				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
				TweenMax.delayedCall(1,delayedFun);
			}
		}
		public function delayedFun1():void{
			var p:Player=phash.get(tvo.sponsor);
			p.view.showTime(8000);
			if(p.uid==GL.id){
				var temp:Array=[];
				var arr:Array=p.hand;
				for(var i:int in arr){
					var ac:ACard=new ACard();
					ac.setdata(arr[i]);
					temp.push(ac);
				}
				bv.showCardDialog(temp,"请选择1张手牌",1,2);
			}else{
				bv.showInfo("请等待税务局长操作");
			}
		}
	}
}