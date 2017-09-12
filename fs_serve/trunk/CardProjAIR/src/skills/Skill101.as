package skills
{
	import com.greensock.TweenMax;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import manage.BM;
	
	import utils.Rand;
	
	import views.ACard;
	
	/**
	 *移花接木
	 */	
	public class Skill101 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			if(obj.goOn){
				excuteBlue();
			}else{
				playTurnAni(0,obj.rid);
				App.audio.play(Cons.audio.TurnRole);
				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
				var p:Player=phash.get(tvo.sponsor);
				p.rid=data.rid;
			}
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
				bv.showInfo("请选择一张手牌");
				var arr:Array=phash.get(GL.id).hand;
				cards=[];
				for each(var c:ACard in arr){
					cards.push(c);
				}
				this.showCards();
			}else{
				bv.showInfo("请等待议长操作");
			}
		}
		private var cardvid:int;
		override protected function onCardsSelect(evt:MouseEvent):void
		{
			cardvid=evt.currentTarget.vid;
			var param:Object={tid:GL.tableId,ctype:1,type:1,card:cardvid,oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
			clearState();
		}
	}
}