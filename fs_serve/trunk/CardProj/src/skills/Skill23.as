package skills
{
	import com.greensock.TweenMax;
	
	import core.mng.Evt;
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import handlers.BattleHandler;
	
	import utils.Rand;
	
	import views.ACard;

	/**
	 *弃卒保帅 
	 */	
	public class Skill23 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playTurnAni(0,obj.rid);
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+1+".mp3");
			App.audio.play(Cons.audio.TurnRole);
			TweenMax.delayedCall(1,delayedFun);
		}
		override public function delayedFun():void
		{
			var p:Player=phash.get(tvo.sponsor);
			p.rid=data.rid;
			data.uid=tvo.sponsor;
			Evt.dipatch(BattleHandler.onAddCard,data);
			TweenMax.delayedCall(2,delayedFun1);
		}
		public function delayedFun1():void
		{
			var self:Player=phash.get(tvo.sponsor);
			self.view.showTime(10000);
			if(GL.id==tvo.sponsor){
				var temp:Array=[];
				for(var i:int in self.hand){
					var ac:ACard=new ACard();
					ac.setdata(self.hand[i]);
					temp.push(ac);
				}
				bv.showCardDialog(temp,"请选择两张手牌",2,2);
			}else{
				bv.showInfo("请等待老金操作");
			}
		}
	}
}