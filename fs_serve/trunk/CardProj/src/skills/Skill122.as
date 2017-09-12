package skills
{
	import flash.events.MouseEvent;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import views.ACard;

		/**
		 * 定点抹除
		 */	
		public class Skill122 extends Skill
		{
			override public function launch():void
			{
				var p:Player=phash.get(GL.id);
				var arr:Array=p.hand;
				cards=[];
				for each(var i:ACard in  arr){
					if(i.id==3)cards.push(i);
				}
				bv.showInfo("请选择一张烧毁");
				this.showCards();
			}
			private var cardvid:int;
			override protected function onCardsSelect(evt:MouseEvent):void
			{
				cardvid=evt.currentTarget.vid;
				clearState();
				var arr:Array=phash.values();
				targets=[];
				for each(var i:Player in  arr){
					if(!i.isDead && !i.isLost && i.infocards.length>0){
						targets.push(i.view);
					}
				}
				bv.showInfo("请选择一个玩家发动");
				this.showTarget();
			}
			
			
			private var targetid:int=-1;
//			override protected function onTargetSelect(evt:MouseEvent):void
//			{
//				targetid=evt.currentTarget.uid;
//				clearState();
//				var temp:Array=[];
//				var t:Player=phash.get(targetid);
//				var arr:Array=t.infocards;
//				for(var i:int in arr){
//					var ac:ACard=new ACard();
//					ac.setdata(arr[i]);
//					temp.push(ac);
//				}
//				bv.showCardDialog(temp,"请选择一张情报",1,2,targetid,cardselected);
//			}
//			
//			public function cardselected(arr:Array):void{
//				var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,target:targetid,cvid:cardvid,card:arr[0],oid:bm.oid};
//				SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnSkillLaunch,param);
//				clearState();
//			}
			
			override protected function onTargetSelect(evt:MouseEvent):void{
				targetid=evt.currentTarget.uid;
				var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,target:targetid,cvid:cardvid,oid:bm.oid};
				SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnSkillLaunch,param);
				clearState();
			}
			override public function play(tvo1:SkillVO,obj:Object):void
			{
				super.play(tvo1,obj);
					playNormalAni();
					App.audio.play("assets/sounds/skill/"+rid+"/"+id+"1.mp3");
			}
		}
}