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
		 * 窃听
		 */	
		public class Skill120 extends Skill
		{
			override public function play(tvo1:SkillVO,obj:Object):void
			{
				super.play(tvo1,obj);
				playYellowAni();
				App.audio.play(Cons.audio.YELLOW);
				selectPlayers=[];
				TweenMax.delayedCall(3,delayedFun1);
			}
			public function delayedFun1():void{
				var p:Player=phash.get(tvo.sponsor);
				if(selectPlayers.length==0)
					p.view.showTime(10000);
				if(p.uid==GL.id){
					var arr:Array=phash.values();
					targets=[];
					for each(var i:Player in  arr){
						if(i.uid!=GL.id  &&  !i.isDead && !i.isLost && int(i.view.hcount.label)>0){
							if(selectPlayers.length==0 || selectPlayers[0]!=i.uid)
								targets.push(i.view);
						}
					}
					bv.showInfo("请选择第"+(selectPlayers.length+1)+"位玩家");
					this.showTarget();
				}else{
					bv.showInfo("请等待肖惜灵操作");
				}
			}
			private var targetid:int=-1;
			private var selectPlayers:Array;
			override protected function onTargetSelect(evt:MouseEvent):void
			{
				selectPlayers.push(evt.currentTarget.uid);
				clearState();
				var arr:Array=phash.values();
				var h:int;//有手牌的其他玩家的数量
				for each(var i:Player in arr){
					if(i.uid!=GL.id && int(i.view.hcount.label)>0){
						h++;
					}
				}
				if(h>=2 && selectPlayers.length<2){
					delayedFun1();
					return;
				}
				var param:Object={sponsor:GL.id,tid:GL.tableId,ctype:1,targets:selectPlayers,oid:bm.oid};
				SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
			}
		}
}