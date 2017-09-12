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
	 *后著 
	 */	
	public class Skill50 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			if(obj.goOn){
				if(obj.cards){
					delayedFun();
				}else{
					if(tvo1.sponsor==GL.id){
						var arr:Array=phash.values();
						targets=[];
						for each(var i:Player in  arr){
							if(i.uid!=GL.id  &&  !i.isDead && !i.isLost){
								targets.push(i.view);
							}
						}
						bv.showInfo("请选择一个玩家");
						this.showTarget();
					}
				}
			}else{
				playNormalAni();
				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
				//				TweenMax.delayedCall(1,delayedFun);
			}
		}
		override public function delayedFun():void
		{
			var p:Player=phash.get(tvo.sponsor);
			p.view.showTime(tvo.dur);
			if(GL.id==tvo.sponsor){
				var cards:Array=data.cards;
				var temp:Array=[];
				for(var i:int in cards){
					var c:ACard=new ACard();
					c.setdata(cards[i]);
					temp.push(c);
				}
				bv.showCardDialog(temp,"请选择一张手牌发动",1,2,targetid,userselected);
			}else{
				bv.showInfo("请等待浮萍操作");
			}
		}
		private var receiveCards:Array;
		public function userselected(arr:Array):void{
			receiveCards=arr;
			var arr:Array=phash.values();
			targets=[];
			for each(var i:Player in  arr){
				if(i.uid!=GL.id  &&  !i.isDead && !i.isLost){
					targets.push(i.view);
				}
			}
			bv.showInfo("请选择一个玩家");
			this.showTarget();
		}
		
		private var targetid:int=-1;
		override protected function onTargetSelect(evt:MouseEvent):void
		{
			targetid=evt.currentTarget.uid;
			clearState();
			if(!receiveCards){
				var param:Object={sponsor:GL.id,tid:GL.tableId,ctype:1,target:targetid,oid:bm.oid};
				SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
			}else{
				var param:Object={tid:GL.tableId,ctype:1,target:targetid,card:receiveCards[0],oid:bm.oid};
				SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
			}
		}
	}
}