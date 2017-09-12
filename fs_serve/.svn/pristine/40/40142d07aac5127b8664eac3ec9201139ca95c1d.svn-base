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
	 * 漏洞入侵
	 */	
	public class Skill114 extends Skill
	{
		override public function launch():void
		{
			var arr:Array=phash.values();
			targets=[];
			for each(var i:Player in  arr){
				if(!i.isDead && !i.isLost){
					if(i.black.length==0 || i.blue.length==0 || i.red.length==0)
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
			var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,target:targetid,oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnSkillLaunch,param);
			clearState();
		}
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playNormalAni();
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
			TweenMax.delayedCall(1,delayedFun1);
		}
		public function delayedFun1():void{
			var p:Player=phash.get(tvo.sponsor);
			p.view.showTime(10000);
			if(p.uid==GL.id){
				bv.showInfo("请选择一张手牌");
				var t:Player=phash.get(tvo.target);
				var r:Boolean=t.red.length==0;
				var g:Boolean=t.black.length==0;
				var b:Boolean=t.blue.length==0;
				var arr:Array=p.hand;
				cards=[];
				for each(var c:ACard in arr){
					if(r && (c.color==2 || c.color==4))cards.push(c);
					else if(g && (c.color==3|| c.color==4|| c.color==5))cards.push(c);
						else if(b && (c.color==1 || c.color==5))cards.push(c);
				}
				this.showCards();
			}else{
				bv.showInfo("请等待黑客操作");
			}
		}
		private var cardvid:int;
		override protected function onCardsSelect(evt:MouseEvent):void
		{
			cardvid=evt.currentTarget.vid;
			clearState();
			var param:Object={sponsor:GL.id,tid:GL.tableId,ctype:1,card:cardvid,oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
		}
	}
}