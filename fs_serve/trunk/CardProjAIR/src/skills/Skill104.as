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
	 * 香气传达
	 */	
	public class Skill104 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			if(obj.goOn){
				excuteBlue();
			}else{
				playNormalAni();
				App.audio.play("assets/sounds/skill/"+rid+"/"+id+"1.mp3");
			}
		}
		override public function excuteBlue():void
		{
			var p:Player=phash.get(tvo.sponsor);
			p.view.showTime(10000);
			if(p.uid==GL.id){
				bv.showInfo("请选择一张手牌");
				var arr:Array=phash.get(GL.id).hand;
				cards=[];
				for each(var c:ACard in arr){
					cards.push(c);
				}
				this.showCards();
			}else{
				bv.showInfo("请等待千金小姐操作");
			}
		}
		private var cardvid:int;
		override protected function onCardsSelect(evt:MouseEvent):void
		{
			cardvid=evt.currentTarget.vid;
			clearState();
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
			var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,target:targetid,card:cardvid,oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
			clearState();
		}
	}
}