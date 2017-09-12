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
	import utils.effect.EffectsManager;
	
	import views.ACard;
	
	/**
	 *血染玫瑰 
	 */	
	public class Skill32 extends Skill
	{
		override public function launch():void
		{
			var arr:Array=phash.values();
			targets=[];
			for each(var i:Player in  arr){
				if(i.uid!=GL.id && i.isDead==false){
					targets.push(i.view);
				}
				if(i.uid==GL.id){
					bv.showInfo("请选择一个玩家并点击确定发动");
					bv.showSelectTarget("请选择完目标点击确定发动",onSelected);
				}
			}
			this.showTarget();
		}
		
		override public function excuteBlue():void
		{
			var cards:Array=data.cards;
			var temp:Array=[];
			for(var i:int in cards){
				var c:ACard=new ACard();
				c.setdata(cards[i]);
				temp.push(c);
			}
			var p:Player=phash.get(tvo.sponsor);
			p.view.showTime(tvo.dur);
			bm.addCardsToCenter(temp,true);
			TweenMax.delayedCall(1,selectCards,[temp]);
		}
		public function selectCards(arr:Array):void{
			for  (var j:int in arr) 
			{
				bv.removeChild(arr[j]);
			}
			
			var p:Player=phash.get(tvo.sponsor);
			if(p.uid==GL.id){
				var len:int=data.num;
				var temp:Array=[];
				for(var i:int in p.hand){
					if(p.hand[i].color>2){
						var c:ACard=new ACard();
						c.setdata(p.hand[i]);
						temp.push(c);
					}
				}
//				bv.showCardDialog(temp,"请选择最多"+(len==3?"三":"一")+"张卡",len,2);
				bv.showCardDialog(temp,"请选择最多"+len+"张卡",len,2);
			}
		}
		
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			if(obj.goOn){
				excuteBlue();
			}else{
				playTurnAni(0,obj.rid);
				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
				App.audio.play(Cons.audio.TurnRole);
				var p:Player=phash.get(tvo.sponsor);
				p.rid=data.rid;
			}
		}
		
		
		public function onSelected(str:String):void{
			if(targetid<0){
				bv.showInfo("请选择目标后再确定发动");
				return;
			}
			var param:Object={sponsor:GL.id,tid:GL.tableId,ctype:1,target:targetid,sid:id,oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnSkillLaunch,param);
			targetid=-1;
			bm.clearState(true);
		}
		private var targetid:int=-1;
		override protected function onTargetSelect(evt:MouseEvent):void
		{
			targetid=evt.currentTarget.uid;
			clearState();
		}
	}
}