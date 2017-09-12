package actions
{
	import com.greensock.TweenMax;
	
	import flash.events.MouseEvent;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	
	import manage.BM;
	
	import utils.OBJUtil;
	import utils.Rand;
	import utils.effect.EffectsManager;
	
	import views.ACard;
	import views.CardDialog;
	import views.ProbeView;
	
	public class Action0 extends Action
	{
		public var targets:Array=[];
		private function showTarget():void
		{
			for(var i:int in targets){
				EffectsManager.Glow(targets[i],0xff0000,1,4,4,5);
				bv.showInfo("请单击选择目标");
				targets[i].addEventListener(MouseEvent.MOUSE_DOWN,onTargetSelect);
				targets[i].showTargetMov(true);
			}
		}
		public function onTargetSelect(evt:MouseEvent):void{
			var obj:Object=evt.currentTarget;
			this["actionSelected"+nowAid](evt.currentTarget);
		}
		
		override public function clearState():void
		{
			if(targets){
				for(var i:int in targets){
					EffectsManager.clearGlow(targets[i]);
					targets[i].removeEventListener(MouseEvent.MOUSE_DOWN,onTargetSelect);
					targets[i].showTargetMov(false);
				}
				targets=[];
				bv.hideInfo();
			}
		}
		
		
		public function doAction1():void{   //锁定
			var arr:Array=phash.values();
			for each(var i:Player in  arr){
				if(i.uid!=GL.id && i.isDead==false){
					targets.push(i.view);
				}
			}
			showTarget();
		}
		//ttype   1 角色 2功能牌 0无
		public function actionSelected1(obj:Object):void{
			var param:Object={target:obj.uid,sponsor:GL.id,tid:GL.tableId,cvid:nowVid,ctype:1,oid:BM.inst.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.UseCard,param);
			clearState();
		}
		public function doAction2():void{  //调虎
			var arr:Array=phash.values();
			for each(var i:Player in  arr){
				if(i.uid!=GL.id && !i.myTurn &&  !i.isDead && !i.isLost &&  !i.isLock && !i.isCaptal){
					targets.push(i.view);
				}
			}
			showTarget();
		}
		public function doAction3():void{//烧毁
			var arr:Array=phash.values();
			for each(var i:Player in  arr){
				if(! i.isDead && !i.isLost &&int(i.view.gcount.label)>0){
					targets.push(i.view);
				}
			}
			showTarget();
		}
		public function actionSelected2(obj:Object):void{
			actionSelected1(obj);
		}
		public function actionSelected3(obj:Object):void{
			actionSelected1(obj);
			/*if(!bv.cardDidialog){
				bv.cardDidialog=new CardDialog();
			}
			bv.cardDidialog.setBurnData(bm.phash.get(obj.uid),nowVid);
			bv.cardDidialog.popupCenter=true;
			bv.cardDidialog.popup();*/
		}
		public function doAction4():void{ //识破
			targets=[];
			var arr:Array=bm.usecardstack;
			for(var i:int in arr){
				if(arr[i].canDiscover)targets.push(arr[i]);
			}
			showTarget();
		}
		public function actionSelected4(obj:Object):void{
			var param:Object={card:obj.vid,sponsor:GL.id,tid:GL.tableId,cvid:nowVid,ctype:1,oid:BM.inst.oid};
			clearState();
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.UseCard,param);
		}
		public function doAction5():void{
			doAction8();
		}
		public function doAction6():void{   //截获
			doAction8();
		}
		public function doAction7():void{    //博弈
			var arr:Array=phash.values();
			for each(var i:Player in  arr){
				targets.push(i.view);
			}
			showTarget();
		}
		public function actionSelected7(obj:Object):void{
			var param:Object={target:obj.uid,sponsor:GL.id,tid:GL.tableId,cvid:nowVid,ctype:1,oid:BM.inst.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.UseCard,param);
			clearState();
		}
		public function doAction8():void{ //真伪
			var param:Object={sponsor:GL.id,tid:GL.tableId,cvid:nowVid,ctype:1,oid:BM.inst.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.UseCard,param);
		}
		public function doAction9():void{//转移
			var arr:Array=phash.values();
			for each(var i:Player in  arr){
				if(i.uid!=GL.id && !i.isDead && !i.isLost){
					targets.push(i.view);
				}
			}
			showTarget();
		}
		public function actionSelected9(obj:Object):void{
			actionSelected7(obj);
		}
		public function doAction10():void{   //调包
			doAction8();
		}
		public function doAction11():void{//权衡
			doAction8();
		}
		public function doAction12():void{//增援
			doAction8();
		}
		public function doAction13():void{
			doAction1();
		}
		public function actionSelected13(obj:Object):void{
			actionSelected1(obj);
		}
		public function doAction14():void{
			doAction1();
		}
		public function actionSelected14(obj:Object):void{
			actionSelected1(obj);
		}
		public function doAction15():void{
			doAction1();
		}
		public function actionSelected15(obj:Object):void{
			actionSelected1(obj);
		}
		public function doAction16():void{
			doAction1();
		}
		public function actionSelected16(obj:Object):void{
			actionSelected1(obj);
		}
		public function doAction17():void{
			doAction1();
		}
		public function actionSelected17(obj:Object):void{
			actionSelected1(obj);
		}
		public function doAction18():void{
			doAction1();
		}
		public function actionSelected18(obj:Object):void{
			actionSelected1(obj);
		}
		public function play1(obj:Object):void{				//锁定生效
			var p:Player=phash.get(obj.target) as Player;
			p.isLock=true;
		}
		public function play2(obj:Object):void{    //调虎
			var p:Player=phash.get(obj.target) as Player;
			p.isSkip=true;
		}
		public function play3(obj:Object):void{				//烧毁
//			if(!bv.cardDidialog){
//			bv.cardDidialog=new CardDialog();
//			}
//			bv.cardDidialog.setBurnData(bm.phash.get(obj.target),obj.cvid);
//			bv.cardDidialog.popupCenter=true;
//			bv.cardDidialog.popup();
			if(obj.isChoose){
				var p:Player=phash.get(obj.sponsor);
				p.view.showTime(10000);
				BM.inst.oid=obj.oid;
				if(p.uid==GL.id){
					var target:Player=phash.get(obj.target);
					var arr:Array=[];
					if(obj.ddmc){
						arr=target.infocards;
					}else{
						arr=target.black;
					}
					var temp:Array=[];
					for(var i:int in arr){
						var ac:ACard=new ACard();
						ac.setdata(arr[i]);
						temp.push(ac);
					}
					bv.showCardDialog(temp,"请选择一张情报烧毁",1,2);
				}else{
					bv.showInfo("请等待玩家进行烧毁操作");
				}
			}else{
				var target:Player=bm.phash.get(obj.target);
				var tcard:ACard=target.removeInfoCardByVid(obj.card);
				if(tcard)bm.graveyardArr.push(tcard);
			}
		}
		public function play4(obj:Object):void{				//识破
			var arr:Array=bm.usecardstack;
			for (var i:int = 0; i < arr.length; i++) 
			{
				if(arr[i].vid==obj.card){
					arr[i].invalid=true;
					break;
				}
			}
		}
		public function play5(obj:Object):void{  //破译
			var p:Player=bm.phash.get(obj.sponsor);
			p.view.showTime(5000);
			if(p.uid==GL.id){
				bv.showChooseColor();
			}else{
				bv.showInfo("等待玩家宣言破译情报颜色！");
			}
		}
		public function play6(obj:Object):void{  //截获
			var target:Player=bm.phash.get(obj.sponsor);
			target.isCaptal=true;
			bm.sendSendingCardtoTarget(target);
		}
		public function play7(obj:Object):void{  //博弈
//			var c:ACard=bm.usecardstack.pop() as ACard;
//			BM.inst.sendCardsToGraveyard([c]);
			var c:ACard=new ACard();
			c.setdata(obj.card);
			c.alpha=0;
			bm.addCardsToCenter([c]);
			TweenMax.to(c,0.8,{alpha:1});
			var p:Player=bm.phash.get(obj.target) as Player;
			TweenMax.delayedCall(1,bm.sendCardsToInfoarea,[c,p]);
//			bm.sendCardsToInfoarea(c,p);
		}
		public function play8(obj:Object):void{  //真伪
//			var c:ACard=bm.usecardstack.pop() as ACard;
			bm.truefalseCards.clear();
//			BM.inst.sendCardsToGraveyard([c]);
				var arr:Array= obj.cards as Array;
				var pos:Array=OBJUtil.getCirclePos(arr.length,Cons.BWID/2,Cons.BHEI/2,150);
				for(var i:int in arr){
					var ac:ACard=new ACard();
					ac.alpha=0;
					ac.setdata(arr[i]);
					ac.bg.bitmapData=new Act0();
					ac.alpha=1;
					arr[i]=ac;
					bm.truefalseCards.put(ac.vid,ac);
					TweenMax.delayedCall(0.3*i,moveToPos,[ac,pos[i]]);
					if(i==arr.length-1){
						TweenMax.delayedCall((0.3*i)+1,xchangePos,[arr]);
						playcount=0;
					}
				}
								
		}
		private var playcount:int=0;
		private function xchangePos(arr:Array):void{
			playcount++;
			if(playcount==3)return;
			var opos:Array=[];
			for (var i:int = 0; i < arr.length; i++) 
			{
				opos.push({x:arr[i].x,y:arr[i].y});
			}
			
			var indexarr:Array=Rand.randNotRepeatNum(0,arr.length-1,arr.length);
			
			for (var j:int = 0; j < arr.length; j++) 
			{
//				arr[j].rotation=0;
				TweenMax.to(arr[j],0.2,{x:opos[indexarr[j]].x,y:opos[indexarr[j]].y});
			}
			TweenMax.delayedCall(1,xchangePos,[arr]);
		}
		private function moveToPos(ac:ACard,pos:Object):void{
			ac.x=Cons.BWID;
			ac.y=Cons.BHEI;
			ac.scaleX=ac.scaleY=0.1;
			bv.addChild(ac);
			TweenMax.to(ac,0.5,{x:pos.x,y:pos.y,scaleX:1,scaleY:1});
		}
		
		public function play9(obj:Object):void{ //转移
//			var c:ACard=bm.usecardstack.pop() as ACard;
//			BM.inst.sendCardsToGraveyard([c]);
			var target:Player=bm.phash.get(obj.target);
			target.isCaptal=true;
			bm.sendSendingCardtoTarget(target);
		}
		public function play10(obj:Object):void{ //调包
			var c:ACard=bm.usecardstack.pop() as ACard;
			TweenMax.to(c,0.8,{x:bm.sendingCard.x,y:bm.sendingCard.y,rotation:bm.sendingCard.rotation});
			bm.sendingCard.setdata(obj.card);
			BM.inst.sendCardsToGraveyard([bm.sendingCard]);
			bm.sendingCard=c;
		}
		public function play11(obj:Object):void{//权衡
//			var c:ACard=bm.usecardstack.pop() as ACard;
//			BM.inst.sendCardsToGraveyard([c]);
		}
		public function play12(obj:Object):void{//增援
			play11(obj);
		}
		public function play13(obj:Object):void{//试探
//			var c:ACard=bm.usecardstack.pop() as ACard;
//			BM.inst.sendCardsToGraveyard([c]);
				var p:Player=phash.get(obj.target) as Player;
				p.view.showTime(obj.time);
			if(GL.id==obj.target){
				bv.probeView=new ProbeView();
				bv.probeView.setData(obj,p);
				bv.probeView.popupCenter=true;
				bv.probeView.show();
			}else{
				bv.showInfo("等待玩家选择！");
			}
		}
		public function play14(obj:Object):void{
			play13(obj);	
		}
		public function play15(obj:Object):void{
			play13(obj);	
		}
		public function play16(obj:Object):void{
			play13(obj);		
		}
		public function play17(obj:Object):void{
			play13(obj);			
		}
		public function play18(obj:Object):void{
			play13(obj);				
		}
		public function play99(obj:Object):void{
			play13(obj);	
		}
	}
}