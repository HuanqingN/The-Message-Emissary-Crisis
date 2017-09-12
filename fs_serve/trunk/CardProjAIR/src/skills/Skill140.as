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
		 * 
		 */	
		public class Skill140 extends Skill
		{
			override public function launch():void
			{
				bv.showInfo("请选择一张黑色手牌");
				var arr:Array=phash.get(GL.id).hand;
				cards=[];
				for each(var c:ACard in arr){
					if(c.color>2)
						cards.push(c);
				}
				this.showCards();
			}
			private var cardvid:int=-1;
			override protected function onCardsSelect(evt:MouseEvent):void
			{
				cardvid=evt.currentTarget.vid;
				var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,card:cardvid,oid:bm.oid};
				SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnSkillLaunch,param);
				clearState();
			}
		}
}