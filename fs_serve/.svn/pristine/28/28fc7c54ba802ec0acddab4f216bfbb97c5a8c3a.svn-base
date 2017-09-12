package skills
{
	import com.greensock.TweenMax;
	
	import flash.geom.Point;
	
	import core.mng.Evt;
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import handlers.BattleHandler;
	
	import manage.BM;
	
	import utils.Rand;
	
	import views.ACard;

	/**
	 * 幽灵袭击
	 */	
	public class Skill89 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			if(obj.goOn){
				excuteBlue();
			}else{
				playTurnAni(0,obj.rid);
				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,4)+".mp3");
				App.audio.play(Cons.audio.TurnRole);
				var p:Player=phash.get(tvo.sponsor);
				p.rid=data.rid;
				TweenMax.delayedCall(1,delayedFun);
			}
		}
		override public function delayedFun():void
		{
			var t:Player=phash.get(tvo.target);
			t.isLock=true;
		}
		override public function excuteBlue():void
		{
			if(data.hasOwnProperty("card")){
				var d:Object=data.card[0];
				bm.sendingCard.setdata(d);
				var sp:Point=new Point(bm.sendingCard.x,bm.sendingCard.y);
				var sr:int=bm.sendingCard.rotation;
				BM.inst.sendCardsToGraveyard([bm.sendingCard]);
				var sponsor:Player=phash.get(tvo.sponsor);
				var ac:ACard;
				var p1:Point;
				if(sponsor.uid==GL.id){
					ac=sponsor.removeHandCardByVid(tvo.card);
				    p1=bv.handArea.localToGlobal(new Point(ac.x,ac.y));
				}else{
					ac=new ACard();
					ac.setdata(data.card[1]);
					p1=new Point(sponsor.view.hcount.x,sponsor.view.hcount.y);
				}
				sponsor.view.hcount.label=String(int(sponsor.view.hcount.label)-1);
				ac.x=p1.x;ac.y=p1.y;
				bv.addChild(ac);
				TweenMax.to(ac,1,{x:sp.x,y:sp.y,rotation:sr});
				bm.sendingCard=ac;
				bv.layoutHandArea();
				return;
			}
			var p:Player=phash.get(tvo.sponsor);
			p.view.showTime(10000);
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
				bv.showCardDialog(temp,"请选择一张黑色情报发动",1,68);
			}else{
				bv.showInfo("请等待诺娃操作");
			}
		}
	}
}