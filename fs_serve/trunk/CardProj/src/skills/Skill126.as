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
		 * 复仇
		 */	
		public class Skill126 extends Skill
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
				var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,card:cardvid,oid:bm.oid};
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