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
	 *反噬
	 */	
	public class Skill86 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			if(obj.goOn){
				excuteBlue();
			}else{
				playTurnAni(0,obj.rid);
				App.audio.play(Cons.audio.TurnRole);
				var p:Player=phash.get(tvo.sponsor);
				p.rid=data.rid;
			}
		}
		override public function excuteBlue():void
		{
			var p:Player=phash.get(tvo.sponsor);
			p.view.showTime(tvo.dur);
			if(p.uid==GL.id){
				var arr:Array=p.hand;
				var temp:Array=[];
				for(var i:int in arr){
					if(arr[i].color>2){					
						var ac:ACard=new ACard();
						ac.setdata(arr[i]);
						temp.push(ac);
					}
				}
				bv.showCardDialog(temp,"请选择一张黑色情报发动",1,2);
			}else{
				bv.showInfo("请等待卯先生操作");
			}
		}
	}
}