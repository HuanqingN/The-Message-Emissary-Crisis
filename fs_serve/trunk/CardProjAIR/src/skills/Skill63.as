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
	 *咄咄逼人 
	 */	
	public class Skill63 extends Skill
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
			if(p.uid==GL.id){
				var temp:Array=[];
				for(var i:int in p.hand){
					if(p.hand[i].color>2){
					var c:ACard=new ACard();
					c.setdata(p.hand[i]);
					temp.push(c);
					}
				}
				bv.showCardDialog(temp,"请选择两张黑色手牌",2,2);
			}else{
				bv.showInfo("请等待戴笠操作");
			}
		}
	}
}