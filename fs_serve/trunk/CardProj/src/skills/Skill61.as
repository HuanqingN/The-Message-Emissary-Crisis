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
	 * 鑿壁偷光
	 */	
	public class Skill61 extends Skill
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
				var arr:Array=data.cards;
				for(var i:int in arr){
						var c:ACard=new ACard();
						c.setdata(arr[i]);
						temp.push(c);
				}
				bv.showCardDialog(temp,"请选择一张牌进行交换",1,1);
			}else{
				bv.showInfo("请等待情报处长操作");
			}
		}
	}
}