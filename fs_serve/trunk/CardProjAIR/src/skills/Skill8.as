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
	 *计中计 
	 */	
	public class Skill8 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playNormalAni();
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
			TweenMax.delayedCall(1,delayfun);
		}
		public function delayfun():void
		{
			if(GL.id!=tvo.sponsor){
				data.to=tvo.sponsor;
				data.num=1;
				data.cards=null;
			}
			data.type=1;
			Evt.dipatch(BattleHandler.onAddCard,data);
			TweenMax.delayedCall(1,delayedFun1);
		}
		public function delayedFun1():void{
			var p:Player=phash.get(tvo.sponsor);
			p.view.showTime(10000);
			if(p.uid==GL.id){
				var t:Player=phash.get(tvo.target);
				var arr:Array=t.infocards;
				if(arr.length==0)return;
				var temp:Array=[];
				for(var i:int in arr){
					var ac:ACard=new ACard();
					ac.setdata(arr[i]);
					temp.push(ac);
				}
				bv.showCardDialog(temp,"请选择一张情报发动",1,2);
			}else{
				bv.showInfo("请等待峨眉峰操作");
			}
		}
	}
}