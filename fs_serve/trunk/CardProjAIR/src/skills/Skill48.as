package skills
{
	import com.greensock.TweenMax;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import utils.Rand;
	
	import views.ACard;

	/**
	 *诡计 
	 */	
	public class Skill48 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playYellowAni();
			App.audio.play(Cons.audio.YELLOW);
			TweenMax.delayedCall(3,delayedFun1);
		}
		public function delayedFun1():void{
			var p:Player=phash.get(tvo.sponsor);
			p.view.showTime(10000);
			if(GL.id==p.uid){
				var temp:Array=[];
				var arr:Array=p.infocards;
				for (var i:int in arr) 
				{
					if(arr[i].color!=3){
					var c:ACard=new ACard();
					c.setdata(arr[i]);
					temp.push(c);
					}
				}
				bv.showCardDialog(temp,"请选择一张情报发动",1,2);
			}else{
				bv.showInfo("请等待怪盗九九操作");
			}
		}
	}
}