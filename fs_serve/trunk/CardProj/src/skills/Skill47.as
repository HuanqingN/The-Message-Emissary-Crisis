package skills
{
	import com.greensock.TweenMax;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import views.ACard;

	/**
	 *逆转 
	 */	
	public class Skill47 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playYellowAni();
			App.audio.play(Cons.audio.YELLOW);
			TweenMax.delayedCall(3,delayfun);
		}
		public function delayfun():void{
			var p:Player=phash.get(tvo.sponsor);
			p.view.showTime(10000);
			if(p.uid==GL.id){
				var t:Player=phash.get(tvo.target);
				var arr:Array=t.infocards;
				var temp:Array=[];
				for(var i:int in arr){
					if(arr[i].color!=3){
						var ac:ACard=new ACard();
						ac.setdata(arr[i]);
						temp.push(ac);
					}
				}
				bv.showCardDialog(temp,"请选择一张情报发动",1,2);
			}else{
				bv.showInfo("请等待贝雷帽操作");
			}
		}
	}
}