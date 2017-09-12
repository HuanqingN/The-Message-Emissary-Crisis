package skills
{
	import flash.events.MouseEvent;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import utils.Rand;
	
	import views.ACard;

		/**
		 * 殉道
		 */	
		public class Skill127 extends Skill
		{
			override public function launch():void
			{
				var arr:Array=phash.get(GL.id).hand;
				cards=[];
				for each(var i:ACard in  arr){
					if(i.color>2)
						cards.push(i);
				}
				bv.showInfo("请选择一张黑色手牌");
				this.showCards();
			}
			private var cardvid:int=-1;
			override protected function onCardsSelect(evt:MouseEvent):void
			{
				cardvid=evt.currentTarget.vid;
				clearState();
				var arr:Array=phash.values();
				targets=[];
				for each(var i:Player in  arr){
					if( !i.isDead && !i.isLost && i.uid!=GL.id){
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
				var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,target:targetid,card:cardvid,oid:bm.oid};
				SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnSkillLaunch,param);
				clearState();
			}
			override public function play(tvo1:SkillVO,obj:Object):void
			{
				super.play(tvo1,obj);
				playNormalAni();
				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
			}
		}
}