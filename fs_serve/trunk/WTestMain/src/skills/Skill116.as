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
		 * 病毒植入
		 */	
		public class Skill116 extends Skill
		{
			override public function launch():void
			{
				var p:Player=phash.get(GL.id);
					var temp:Array=[];
					for each(var i:ACard in  p.infocards){
							var c:ACard=new ACard();
							c.setdata(i);
							temp.push(c);
					}
					bv.showCardDialog(temp,"请选择一张情报",1,2,1,selectedfun);
			}
			
			public function selectedfun(arr:Array):void{
				var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,card:arr[0],oid:bm.oid};
				SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnSkillLaunch,param);
				bm.clearState(true);
			}
			override public function play(tvo1:SkillVO,obj:Object):void
			{
				super.play(tvo1,obj);
				playYellowAni();
				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
				App.audio.play(Cons.audio.YELLOW);
			}
		}
}