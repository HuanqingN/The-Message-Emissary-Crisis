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
	 *警觉 
	 */	
	public class Skill16 extends Skill
	{
		override public function launch():void
		{
			var arr:Array=bm.usecardstack;
			cards=[];
			for each(var i:ACard in  arr){
				cards.push(i);
			}
			bv.showInfo("请选择一个使用中的卡牌并点击确定发动");
			bv.showSelectTarget("请选择完目标卡牌点击确定发动",onSelected);
			this.showCards();
		}
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			if(obj.goOn){
				excuteBlue();
			}else{
				playTurnAni(0,obj.rid);
				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+1+".mp3");
				App.audio.play(Cons.audio.TurnRole);
				var p:Player=phash.get(tvo.sponsor);
				p.rid=data.rid;
			}
		}
		override public function excuteBlue():void
		{
			var cvid:int=data.card;
			var temp:Array=bm.usecardstack;
			for each(var i:ACard in temp){
				if(i.vid==cvid){
					i.disabled=true;
					break;
				}
			}
		}
		public function onSelected(str:String):void{
			if(cardvid<0){
				bv.showInfo("请选择目标后再确定发动");
				return;
			}
			var param:Object={sponsor:GL.id,tid:GL.tableId,ctype:1,card:cardvid,sid:id,oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnSkillLaunch,param);
			cardvid=-1;
			bm.clearState(true);
		}
		private var cardvid:int=-1;
		override protected function onCardsSelect(evt:MouseEvent):void
		{
			cardvid=evt.currentTarget.vid;
			clearState();
		}
	}
}