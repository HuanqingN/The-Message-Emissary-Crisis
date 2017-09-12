package skills
{
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	
	import actions.Action0;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import utils.Rand;
	
	import views.ACard;
	import views.ProbeView;

	/**
	 * 光影浮华
	 */	
	public class Skill92 extends Skill
	{
		override public function launch():void
		{
			var arr:Array=phash.values();
			targets=[];
			for each(var i:Player in  arr){
				if(i.uid!=GL.id  &&  !i.isDead && !i.isLost && int(i.view.hcount.label)>0){
					targets.push(i.view);
				}
			}
			bv.showInfo("请选择一个玩家发动");
			this.showTarget();
		}
		private var targetid:int=-1;
		override protected function onTargetSelect(evt:MouseEvent):void
		{
			targetid=evt.currentTarget.uid;
			if(scards){
				var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,target:targetid,oid:bm.oid};
				SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
			}else{
			var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,target:targetid,oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnSkillLaunch,param);
			}
			clearState();
			scards=null;
		}
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			if(obj.goOn){
				excuteBlue();
			}else{
				playTurnAni(0,obj.rid);
				App.audio.play("assets/sounds/skill/"+rid+"/"+id+"1.mp3");
				App.audio.play(Cons.audio.TurnRole);
				var p:Player=phash.get(tvo.sponsor);
				p.rid=data.rid;
			}
		}
		private var scards:Array;
		public function checkend():void{
			scards=[];
			var arr:Array=phash.values();
			targets=[];
			for each(var i:Player in  arr){
				if(i.uid!=GL.id  &&  !i.isDead && !i.isLost){
					targets.push(i.view);
				}
			}
			bv.showInfo("请选择一个玩家发动");
			this.showTarget();
		}
		override public function excuteBlue():void
		{
			if(data.checkcard){
				var obj:Object=data.checkcard;
				if(GL.id==tvo.sponsor){
					if(!bv.probeView)bv.probeView=new ProbeView();
					bv.probeView.showType=2;
					bv.probeView.setData({cid:obj.id,color:obj.color},null);
					bv.probeView.popupCenter=true;
					bv.probeView.callfun=checkend;
					App.dialog.show(bv.probeView);
				}
			}else{
				var p:Player=phash.get(tvo.sponsor);
				p.view.showTime(tvo.dur);
				if(GL.id==tvo.sponsor){
					var num:int=data.num;
					var temp:Array=[];
					var bmp:BitmapData=new Act0;
					for (var i:int = 0; i < num; i++) {
						var c:ACard=new ACard();
						c.bg.bitmapData=bmp;
						temp.push(c);
					}
					bv.showCardDialog(temp,"请选择一张手牌发动",1,1);
				}else{
					bv.showInfo("请等待血牡丹操作");
				}
			}
		}
	}
}