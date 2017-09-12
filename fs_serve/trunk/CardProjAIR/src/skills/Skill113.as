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
	
	import views.ACard;

		/**
		 * 狗急跳墙
		 */	
		public class Skill113 extends Skill
		{
			override public function play(tvo1:SkillVO,obj:Object):void
			{
				if(obj.goOn){
					var p:Player=phash.get(tvo.sponsor);
					p.view.showTime(10000);
					if(p.uid==GL.id){
						var temp:Array=[];
						var arr:Array=p.black;
						for(var i:int in arr){
							var ac:ACard=new ACard();
							ac.setdata(arr[i]);
							temp.push(ac);
						}
						bv.showCardDialog(temp,"请选择"+obj.num+"张手牌",obj.num,2);
					}else{
						bv.showInfo("请等待军犬操作");
					}
				}else{
					super.play(tvo1,obj);
					playYellowAni();
					App.audio.play("assets/sounds/skill/"+rid+"/1111.mp3");
					TweenMax.delayedCall(3,delayedFun1);
				}
			}
			public function delayedFun1():void{
				var p:Player=phash.get(tvo.sponsor);
				p.view.showTime(10000);
				if(p.uid==GL.id){
					var temp:Array=[];
					var arr:Array=p.hand;
					for(var i:int in arr){
						var ac:ACard=new ACard();
						ac.setdata(arr[i]);
						temp.push(ac);
					}
					bv.showCardDialog(temp,"请选择最多"+p.black.length+"张手牌",p.black.length,2);
				}else{
					bv.showInfo("请等待军犬操作");
				}
			}
		}
}