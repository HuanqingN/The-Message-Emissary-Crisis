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
		 * 互助
		 */	
		public class Skill132 extends Skill
		{
			override public function launch():void
			{
				other=false;
				var arr:Array=phash.get(GL.id).hand;
				cards=[];
				for each(var i:ACard in  arr){
						cards.push(i);
				}
				bv.showInfo("请选择一张手牌");
				this.showCards();
			}
			private var cardvid:int=-1;
			override protected function onCardsSelect(evt:MouseEvent):void
			{
				cardvid=evt.currentTarget.vid;
				if(other){
					var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,card:cardvid,oid:bm.oid};
					SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
					other=false;
					clearState();
				}else{
					clearState();
					var arr:Array=phash.values();
					targets=[];
					for each(var i:Player in  arr){
						if(i.uid!=GL.id && !i.isDead && !i.isLost && int(i.view.hcount.label)>0)
							targets.push(i.view);
					}
					bv.showInfo("请选择一个玩家");
					this.showTarget();
				}
			}
			override protected function onTargetSelect(evt:MouseEvent):void
			{
				var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,target:evt.currentTarget.uid,card:cardvid,oid:bm.oid};
				SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnSkillLaunch,param);
				clearState();
			}
			override public function play(tvo1:SkillVO,obj:Object):void
			{
				super.play(tvo1,obj);
				playNormalAni();
				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
				TweenMax.delayedCall(1,delayfun);
			}
			private var other:Boolean=false;
			public function delayfun():void{
				var p:Player=phash.get(tvo.target);
				p.view.showTime(10000);
				if(p.uid==GL.id){
					var arr:Array=phash.get(p.uid).hand;
					cards=[];
					for each(var i:ACard in  arr){
						cards.push(i);
					}
					bv.showInfo("请选择一张手牌");
					other=true;
					this.showCards();
				}else{
					bv.showInfo("请等待玩家操作");
				}
			}
		}
}