package manage
{
	import com.greensock.TweenMax;
	import com.greensock.TweenNano;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;
	
	import core.mng.Evt;
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	import datas.TargetVO;
	import datas.Trans;
	
	import events.WEvent;
	
	import handlers.BattleHandler;
	
	import morn.core.components.Image;
	
	import skills.Skill;
	
	import util.GUtil;
	
	import utils.ArrayUtil;
	import utils.HashMap;
	import utils.OBJUtil;
	import utils.Rand;
	import utils.StringUtils;
	
	import views.ACard;
	import views.BattleView;
	import views.ProbeView;
	import views.RoleArea;
	import views.RoleChoose;
	
	public class BM
	{
		private static var bm:BM=new BM();
		public var phash:HashMap=new HashMap();//玩家hash
		public var bv:BattleView;
		public var graveyardArr:Array=[]; //弃牌堆
		private var spotlight:SpotLight;
		private var arrowspr:Sprite=new Sprite();
		private var endp:int,arx:int,ary:int,arindex:int;
		public var usecardstack:Array=[];	
		public var truefalseCards:HashMap=new HashMap();
		public var sendingCard:ACard;
		public var getCardPlayerID:int;
		public static function get inst():BM{
			return bm;
		}
		public function BM():void{
		}
		public function dispose():void{
			clearState();
			clearAllstatus();
			spotlight=null;
			usecardstack=[];
			truefalseCards.clear();
			sendingCard=null;
			getCardPlayerID=0;
			setEvents(false);
//			App.keyboard.removeQuickKick();
			App.audio.backPlay(Cons.audio.BACK);
			bv=null;
			phash.clear();
			graveyardArr=null;			
		}
		private function setEvents(boo:Boolean):void{
			var temp:String=boo?"add":"remove";
			//			Evt[temp](BattleHandler.onChooseRole,onChooseRole);
			Evt[temp](BattleHandler.onGetFoldCards,onGetFoldCards);
			Evt[temp](BattleHandler.onPoison,onPoison);
			Evt[temp](BattleHandler.onRemoveUsedCard,onRemoveUsedCard);
			Evt[temp](BattleHandler.onShowIden,onShowIden);
			Evt[temp](BattleHandler.onRoleChoosed,onRoleChoosed);
			Evt[temp](BattleHandler.onDealingAll,onDealingAll);
			Evt[temp](BattleHandler.onDealingSingle,onDealingSingle);
			Evt[temp](BattleHandler.onShowCanUseCard,onShowCanUseCard);
			Evt[temp](BattleHandler.onUseCard,onUseCard);
			Evt[temp](BattleHandler.onCardLaunch,onCardLaunch);
			Evt[temp](BattleHandler.onAddCard,onAddCard);
			Evt[temp](BattleHandler.onDisCard,onDisCard);
			Evt[temp](BattleHandler.onDisCardSelect,onDisCardSelect);
			Evt[temp](BattleHandler.onProbeChoose,onProbeChoose);
			Evt[temp](BattleHandler.onShowInfo,onShowInfo);
			Evt[temp](BattleHandler.onTrueFlaseDeal,onTrueFlaseDeal);
			Evt[temp](BattleHandler.onWaitForSend,onWaitForSend);
			Evt[temp](BattleHandler.onSendingInfo,onSendingInfo);
			Evt[temp](BattleHandler.onRecieveInfo,onRecieveInfo);
			Evt[temp](BattleHandler.onClearAllStatus,onClearAllStatus);
			Evt[temp](BattleHandler.onWaitForRecieve,onWaitForRecieve);
			Evt[temp](BattleHandler.onManifestoShared,onManifestoShared);
			Evt[temp](BattleHandler.onSharedCard,onSharedCard);
			Evt[temp](BattleHandler.onQuickChat,onQuickChat);
			Evt[temp](BattleHandler.onChangeStep,onChangeStep);
			Evt[temp](BattleHandler.onChaneTurn,onChaneTurn);
			Evt[temp](BattleHandler.onDead,onDead);
			Evt[temp](BattleHandler.onVictory,onVictory);
			Evt[temp](BattleHandler.onSkillUse,onSkillUse);
			Evt[temp](BattleHandler.onUserExit,onUserExit);
			Evt[temp](BattleHandler.onCardMoveTo,onCardMoveTo);
			Evt[temp](BattleHandler.onCheckNetState,onCheckNetState);
			Evt[temp](BattleHandler.onLaunchSingleSkill,onLaunchSingleSkill);
			Evt[temp](BattleHandler.onChatMsg,onChatMsg);
		}
		private function onGetFoldCards(evt:WEvent):void{
			var arr:Array=evt.param.cards;
			if(arr.length==0)return;
			var temp:Array=[];
			for(var i:int in arr){
				var ac:ACard=new ACard();
				ac.setdata(arr[i]);
				temp.push(ac);
			}
			bv.showCardDialog(temp,"弃牌堆",0,9);
		}
		private function onPoison(evt:WEvent):void{
			var p:Player=phash.get(evt.param.target);
			var c:int=evt.param.num;
			p.isPoison=c;
		}
		private function onRemoveUsedCard(evt:WEvent):void{
			var c:ACard=bm.usecardstack.pop() as ACard;
			var uid:int=evt.param.moveto;
			c.canDiscover=true;
			if(uid==0){
				sendCardsToGraveyard([c]);
			}else{
				var p:Player=phash.get(uid);
				sendCardsToPoint([c],p);
//				p.hand.push(c);
			}
		}
		private function onChatMsg(evt:WEvent):void{
			var p:Player=phash.get(evt.param.uid);
			p.view.showChat(evt.param.msg);
			bv.msgarea.appendText(StringUtils.getColorString(p.rname,0xffff00)+":"+evt.param.msg);
			bv.msgarea.scrollTo(bv.msgarea.maxScrollV);
		}
		private function onShowIden(evt:WEvent):void{
			if(evt.param.from>=0){
				var from:Player=phash.get(evt.param.from);
				from.view.showTime(3000);
				if(from.uid!=GL.id){
					bv.showInfo("请等待玩家查看!");
					return;
				}
			}
			var target:Player=phash.get(evt.param.target);
			var iden:int=evt.param.iden;
			var img:Image=new Image();
			img.width=85;
			img.height=120;
			if(iden==0)img.bitmapData=new Iden0;
			else if(iden==1)img.bitmapData=new Iden1;
			else if(iden==2)img.bitmapData=new Iden2;
			
			var p1:Point=new Point(target.view.x+target.view.g1.x,target.view.y+target.view.g1.y);
			var p2:Point=new Point((Cons.BWID-85)/2,(Cons.BHEI-120)/2);
			img.scaleX=img.scaleY=0;
			img.x=p1.x;
			img.y=p1.y;
			bv.addChild(img);
			TweenMax.to(img,1,{x:p2.x,y:p2.y,scaleX:1,scaleY:1});
			TweenMax.delayedCall(2,idenShowed,[img,p1,iden,target]);
		}	
		private function idenShowed1(img:Image,iden:int,target:Player):void{
			bv.removeChild(img);
			img=null;
			target.view.g1.skin=Trans.getSkinByIdentity(iden);
			target.view.g1.mouseEnabled=false;
		}
		private function idenShowed(img:Image,p:Point,iden:int,target:Player):void{
			TweenMax.to(img,1,{x:p.x,y:p.y,scaleX:0,scaleY:0});
			TweenMax.delayedCall(1,idenShowed1,[img,iden,target]);
		}
		private function onLaunchSingleSkill(evt:WEvent):void
		{
			clearState();
			var p:Player=phash.get(evt.param.uid) as Player;
			p.view.showTime(evt.param.time);
			if(p.uid==GL.id){
				oid=evt.param.oid;
				if(evt.param.skill){
					var obj:Object=evt.param.skill;
					bv.setPassState(true,evt.param.time);
					bv.setSkillBtnState(obj);	
				}
			}else{
				bv.showInfo("请等待玩家操作");
			}
		}
		
		private function onDead(evt:WEvent):void
		{
			var p:Player=phash.get(evt.param.uid) as Player;
			p.iden=evt.param.iden;
			p.rid=evt.param.rid;
			p.deadType=(evt.param.type==true?2:1);
			if(p.deadType==1){  //1死2失败
				App.audio.play("assets/sounds/skill/"+p.rid+"/lost.mp3");
				App.audio.play(Cons.audio.DEAD);
				p.isDead=true;
				bv.setReport(StringUtils.getColorString("["+p.pname+"]",0xffff00)+"死亡了,身份是"+StringUtils.getColorString(Trans.getIdenStr(p.iden),Trans.getIdenColor(p.iden)));
			}else if(p.deadType==2){
				App.audio.play(Cons.audio.DEAD);
				App.audio.play("assets/sounds/skill/"+p.rid+"/lost.mp3");
				p.isLost=true;
				bv.setReport(StringUtils.getColorString("["+p.pname+"]",0xffff00)+"失败了,身份是"+StringUtils.getColorString(Trans.getIdenStr(p.iden),Trans.getIdenColor(p.iden)));
			}
			
		}
		
		private function onQuickChat(evt:WEvent):void
		{
			App.audio.play("assets/sounds/chat/chat"+evt.param.value+".mp3");		
		}
		
		private function onManifestoShared(evt:WEvent):void  //破译宣言公告
		{
			var suc:Boolean=evt.param.card;
			var c:int=evt.param.color;
			var p:Player=phash.get(evt.param.uid) as Player;
			if(p.rid==38)
				App.audio.play("assets/sounds/card/dog1.mp3");
				else
			App.audio.play("assets/sounds/decode"+p.sex+""+c+".mp3");
			if(p.uid==GL.id){
				if(!bv.probeView){
					bv.probeView=new ProbeView();
				}
				oid=evt.param.oid;
				bv.probeView.showType=1;
				bv.probeView.success=evt.param.success;
				bv.probeView.setData({cid:evt.param.card.id,color:evt.param.card.color},null);
				bv.probeView.popupCenter=true;
				bv.probeView.popup();
			}else{
				bv.showInfo("等待玩家选择是否公开破译");
			}
		}
		private function onWaitForRecieve(evt:WEvent):void
		{
			clearState();
			if(evt.param.target == GL.id){
				bv.passView.setInfo("是否接收此情报？",2,1,"不接收","确定");
				bv.passView.x=(1000-bv.passView.width)/2;
				bv.passView.y=440;
				oid=evt.param.oid;
				bv.passView.popupCenter=false;
				App.dialog.show(bv.passView);
			}else{
				bv.showInfo("等待玩家决定是否接收情报");
			}
			var p:Player=phash.get(evt.param.target) as Player;
			p.view.showTime(evt.param.time);
		}
		
		private function onClearAllStatus(evt:WEvent):void
		{
			clearState();
		}
		
		private function onRecieveInfo(evt:WEvent):void
		{
			clearState();
			sendingCard.setdata(evt.param.card);
			var p:Player=phash.get(evt.param.target) as Player;
			bv.setReport(StringUtils.getColorString("["+p.pname+"]",0xffff00)+"获得了一张"+StringUtils.getColorString(Trans.getColorStr(sendingCard.color),Trans.getColor(sendingCard.color)));
			sendCardsToInfoarea(sendingCard,p);
			sendingCard=null;
			clearAllstatus();
		}
		
		private function clearAllstatus():void  //清除所有的锁定截获调虎状态
		{
			var ps:Array=phash.values();
			for each(var p:Player in ps){
				p.isLock=p.isCaptal=p.isSkip=false;
			}
		}
		private function onCheckNetState(evt:WEvent):void
		{
			nowTime=getTimer();
			var inst:Number=nowTime-oldTime;
			if(inst<=500){
				bv.neticon.frame=0
			}else if(inst<=1000){
				bv.neticon.frame=1
			}else{
				bv.neticon.frame=2
			}
			bv.neticon.toolTip="延时"+inst+"毫秒";
		}
		//type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶6情报到牌库顶7情报到弃牌堆8从手卡到传递中的情报9从牌库顶到情报
		private function onCardMoveTo(evt:WEvent):void
		{
			if(evt.param.hasOwnProperty("SkillID")){
				var p:Player=phash.get(evt.param.from);
				p.skillHash.get(evt.param.SkillID).playAni();
				//				App.audio.play("assets/sounds/skill/"+evt.param.from+"/"+evt.param.SkillID+""+Rand.range(1,2)+".mp3");
				delete evt.param.SkillID;
				TweenMax.delayedCall(1,onCardMoveTo,[evt]);
				return;
			}
			var from:Player=phash.get(evt.param.from);
			var to:Player
			if(evt.param.hasOwnProperty("to"))
				to=phash.get(evt.param.to);
			var card:Array=evt.param.cards;
			var temp:Array=[];
			switch(evt.param.type)
			{
				case 1:
					if(from.uid==GL.id ){
						for(var i:int in card){
							temp.push(from.getHandCardByVid(card[i].vid));
							from.removeHandCardByVid(card[i].vid);
						}
					}else if(to.uid==GL.id){
						for(var i:int in card){
							var c:ACard=new ACard();
							c.setdata(card[i]);
							temp.push(c);
						}
					}else{
						for(var i:int in card){
							var c:ACard=new ACard();
							c.bg.bitmapData=new Act0;
							temp.push(c);
						}
					}
					sendCardsToCenter(temp,from);
					TweenMax.delayedCall(1,sendCardsToPoint,[temp,to]);
					break;
				case 2: //情报到手卡 
					for(var i:int in card){
						temp.push(from.removeInfoCardByVid(card[i].vid));
						temp[i].rotation=0;
						temp[i].scaleX=1;
						temp[i].scaleY=1;
					}
					sendCardsToCenter(temp,from,2);
					TweenMax.delayedCall(1,sendCardsToPoint,[temp,to]);
					break;
				case 3://手卡到情报
					if(from.uid==GL.id ){
						for(var i:int in card){
							temp.push(from.getHandCardByVid(card[i].vid));
							from.removeHandCardByVid(card[i].vid);
						}
					}else{
						for(var i:int in card){
							var c:ACard=new ACard();
							c.setdata(card[i]);
							temp.push(c);
						}
					}
					sendCardsToCenter(temp,from);
					TweenMax.delayedCall(1,sendAllCardsToInfo,[temp,to]);
					break;
				case 4://情报到情报
					for(var i:int in card){
						temp.push(from.removeInfoCardByVid(card[i].vid));
						temp[i].rotation=0;
						temp[i].scaleX=1;
						temp[i].scaleY=1;
					}
					sendCardsToCenter(temp,from,2);
					TweenMax.delayedCall(1,sendAllCardsToInfo,[temp,to]);
					break;
				case 5:
					if(from.uid==GL.id ){
						for(var i:int in card){
							temp.push(from.getHandCardByVid(card[i].vid));
							from.removeHandCardByVid(card[i].vid);
						}
					}else{
						for(var i:int in card){
							var c:ACard=new ACard();
							c.bg.bitmapData=new Act0;
							temp.push(c);
						}
					}
					sendCardsToCenter(temp,from);
					TweenMax.delayedCall(1,sendCardsTodispear,[temp]);
					break;
				case 6:
					for(var i:int in card){
						temp.push(from.removeInfoCardByVid(card[i].vid));
						temp[i].rotation=0;
						temp[i].scaleX=1;
						temp[i].scaleY=1;
					}
					sendCardsToCenter(temp,from,2);
					TweenMax.delayedCall(1,sendCardsTodispear,[temp]);
					break;
				case 7:
					for(var i:int in card){
						temp.push(from.removeInfoCardByVid(card[i].vid));
						temp[i].rotation=0;
						temp[i].scaleX=1;
						temp[i].scaleY=1;
					}
					sendCardsToCenter(temp,from,2);
					TweenMax.delayedCall(1,sendCardsToGraveyard,[temp]);
					break;
				case 9:
					for(var i:int in card){
						var c:ACard=new ACard();
						c.setdata(card[i]);
						temp.push(c);
					}
					addCardsToCenter(temp,true);
					TweenMax.delayedCall(1,sendAllCardsToInfo,[temp,from]);
					break;
			}
		}
		
		private function sendAllCardsToInfo(arr:Array,t:Player):void{
			getCardPlayerID=t.uid;
			for(var i:int in arr){
				sendCardsToInfoarea(arr[i],t);
			}
		}
		public function sendCardsTodispear(arr:Array):void{
			for(var i:int in arr){
				TweenNano.to(arr[i],0.8,{alpha:0});
			}
		}
		private function onUserExit(evt:WEvent):void
		{
			var p:Player=phash.get(evt.param.uid);
			if(evt.param.type==1){//离开
				p.view.trusttee(evt.param.boo);
			}else{
				p.view.offLine(evt.param.boo);
			} 
		}
		
		private function onSkillUse(evt:WEvent):void   //技能发动
		{
			var tvo:SkillVO=new SkillVO();
			tvo.setData(evt.param.tvo);
			var p:Player=phash.get(tvo.sponsor);
			if(evt.param.hasOwnProperty("rid")){
				p.initSkillByRid(evt.param.rid);
			}
			var target:Player;
			if(tvo.target>0){
				target=phash.get(tvo.target);
				showArrow(p,target);
			}
			if(evt.param.hasOwnProperty("oid"))oid=evt.param.oid;
			App.log.info("发动技能:  "+oid);
			p.skillHash.get(tvo.sid).play(tvo,evt.param);
		}
		
		private function onVictory(evt:WEvent):void
		{
			bv.playVictory(phash,evt.param);
		}
		
		private function onChaneTurn(evt:WEvent):void
		{
			clearAllstatus();
			var p:Player=phash.get(evt.param.uid) as Player;
			var arr:Array=phash.values();
			for(var i:int in arr){
				arr[i].myTurn=false;
			}
			p.myTurn=true;
			setRoleTurn(p);
			GUtil.clearSoundState();
		}
		public var nowStep:int;
		public function onChangeStep(evt:WEvent):void  //切换流程
		{
			if(nowStep!=-1){
				if(bv.hasOwnProperty("step"+nowStep))
					bv["step"+nowStep].selected=false;
			}
			nowStep=evt.param.index;
			bv.setReport("进入"+StringUtils.getColorString(Cons.str.getNameByStep(nowStep),0x00ff00));
			if(bv.hasOwnProperty("step"+nowStep))
				bv["step"+nowStep].selected=true;
		}
		
		private function onSharedCard(evt:WEvent):void
		{
			clearState();
			bv.showInfo("传递中的情报已被公开！");
			sendingCard.setdata(evt.param.card);
		}
		
		private function onSendingInfo(evt:WEvent):void
		{
			clearState();
			var to:Player=phash.get(evt.param.to) as Player;			
			var from:Player=phash.get(evt.param.from) as Player;
			var card:Object=evt.param.card;
			
			if(from.uid==GL.id){  //自己
				if(!sendingCard){
					var ca:ACard=from.getHandCardByVid(card.vid);
					var spos:Point=bv.handArea.localToGlobal(new Point(ca.x,ca.y));
					from.removeHandCardByVid(ca.vid);
					from.view.hcount.label=String(int(from.view.hcount.label)-1);
					bv.addChild(ca);
					ca.x=spos.x;
					ca.y=spos.y;
					bv.layoutHandArea();
					ca.setdata(card);
					sendingCard=ca;
					if(card.id==0){
						if(from.rid==38)
							App.audio.play("assets/sounds/info/dog3.mp3");
						else
						App.audio.play(card.color==0?Cons.audio["Info"+from.sex+"0"]:Cons.audio["Info"+from.sex+"1"]);
						bv.setReport(StringUtils.getColorString("["+from.pname+"]",0xffff00)+"对"+StringUtils.getColorString("["+to.pname+"]",0xffff00)+"传出一张"+(card.send==3?"密电 ":"直达"));
					}else{
						if(from.rid==38)
							App.audio.play("assets/sounds/info/dog3.mp3");
						else
						App.audio.play(Cons.audio["Info"+from.sex+"2"]);
						bv.setReport(StringUtils.getColorString("["+from.pname+"]",0xffff00)+"对"+StringUtils.getColorString("["+to.pname+"]",0xffff00)+"传出一张文本");
					}
				}
			}else{
				if(!sendingCard){
					sendingCard=new ACard();
					sendingCard.setdata(card);
					sendingCard.x=from.view.infoPos.x;
					sendingCard.y=from.view.infoPos.y;
					bv.addChild(sendingCard);
					from.view.hcount.label=String(int(from.view.hcount.label)-1);
					if(card.id==0){
						if(from.rid==38)
							App.audio.play("assets/sounds/info/dog3.mp3");
						else
						App.audio.play(card.color==0?Cons.audio["Info"+from.sex+"0"]:Cons.audio["Info"+from.sex+"1"]);
						bv.setReport(StringUtils.getColorString("["+from.pname+"]",0xffff00)+"对"+StringUtils.getColorString("["+to.pname+"]",0xffff00)+"传出一张"+(card.send==0?"密电 ":"直达"));
					}else{
						if(from.rid==38)
							App.audio.play("assets/sounds/info/dog3.mp3");
						else
						App.audio.play(Cons.audio["Info"+from.sex+"2"]);
						bv.setReport(StringUtils.getColorString("["+from.pname+"]",0xffff00)+"对"+StringUtils.getColorString("["+to.pname+"]",0xffff00)+"传出一张文本");
					}
				}
			}
			//			from.view.hcount.label=String(int(from.view.hcount.label)-1);
			sendSendingCardtoTarget(to);
		}
		
		public function sendSendingCardtoTarget(target:Player):void{
			var topos:Object=target.view.infoPos;
			TweenMax.to(sendingCard,0.8,{x:topos.x,y:topos.y,rotation:topos.r});
		}
		private function onWaitForSend(evt:WEvent):void
		{
			clearState();
			oid=evt.param.oid;
			var p:Player=phash.get(evt.param.target) as Player;
			p.view.showTime(evt.param.time);
			if(p.uid==GL.id){
				for each(var c:ACard in p.hand){
					c.selectType=2;
					c.canuse=true;
				}
				bv.showInfo("请双击选择将传递的情报！");
			}else{
				bv.showInfo("等待玩家选择将传递的情报！");
			}
		}
		private function onTrueFlaseDeal(evt:WEvent):void  //真伪发牌
		{
			var ca:ACard=truefalseCards.get(evt.param.vid);
			var p:Player=phash.get(evt.param.target) as Player;
			ca.id=ca.id;
			sendCardsToInfoarea(ca,p);
		}
		private function onShowInfo(evt:WEvent):void
		{
			clearState();
			switch(evt.param.type)
			{
				case 1:
					var p:Player=phash.get(evt.param.target) as Player;
					bv.showInfo(p.rname+"宣言‘我是一个好人’");
					if(p.rid==38)
						App.audio.play("assets/sounds/info/dog3.mp3");
					else
					App.audio.play("assets/sounds/card/13/"+p.sex+"2.mp3");
					break;
			}
		}	
		public function clearState(isSelf:Boolean=false):void{
			App.dialog.closeAll();
			bv.setPassState(false);
			bv.clearSkillBtnState();
			var arr:Array
			if(isSelf)
				arr=[phash.get(GL.id)];
			else
				arr=phash.values();
			for each(var p:Player in arr){
				p.view.clearTime();
				var temp:Array=p.hand;
				for each(var ac:ACard in temp){
					ac.canuse=false;
				}
				if(p.skillHash){
					temp=p.skillHash.values();
					for each(var sk:Skill in temp){
						sk.clearState();
					}
				}
			}
			AM.inst.clearState();
		}
		
		private function onProbeChoose(evt:WEvent):void
		{
		}
		private function onDisCardSelect(evt:WEvent):void
		{
			clearState();
			var p:Player=phash.get(evt.param.target) as Player;
			if(GL.id==p.uid){
				oid=evt.param.oid;
				bv.showInfo("请选择要丢弃的牌！");
				for each(var c:ACard in p.hand){
					c.canuse=true;
					c.selectType=1;
				}
				Evt.add("DISCARD_SELECTED",onDiscardSelected);
			}else{
				bv.showInfo("等待玩家选择弃牌！");
			}
			p.view.showTime(evt.param.time);
		}		
		private function onDisCard(evt:WEvent):void //弃牌
		{
			clearState();
			var target:Player=phash.get(evt.param.target) as Player;
			var cards:Array=evt.param.cards;
			var temp:Array=[];
			if(GL.id==target.uid){
				if(evt.param.type==3){
					temp=temp.concat(target.hand);
					target.hand=[];
				}else{
					for(var i:int in cards){
						temp.push(ArrayUtil.removeItemByParm(target.hand,"vid",cards[i].vid));
					}
				}
			}else{
				for(var i:int in cards){
					var acard:ACard=new ACard();
					acard.setdata(cards[i]);
					temp.push(acard);
				}
			}
			if(temp.length==0)return
			
			sendCardsToCenter(temp,target);
			TweenMax.delayedCall(1,sendCardsToGraveyard,[temp]);
		}
		public function sendCardsToGraveyard(arr:Array):void{ // 把卡移动墓地
			var p:Point=new Point(bv.d1.x+bv.d1.width/2,bv.d1.y+bv.d1.height/2);
			for (var i:int = 0; i < arr.length; i++) 
			{
				TweenMax.to(arr[i],0.8,{x:p.x,y:p.y,scaleX:0.1,scaleY:0.1,onComplete:onCardMoveToGraveyardEnd,onCompleteParams:[arr[i]]});
			}
		}
		//注意,自己的卡先从HAND里移除，不要从HANDAREA移除
		public function sendCardsToCenter(arr:Array,target:Player,type:int=1):void{ // 把卡从目标移动中间
			if(target.uid==GL.id){   //如果是自己 把ARR所有牌放在自己本身的位置
				for each(var ac:ACard in  arr){
					var p1:Point;
					if(type==1)
						p1=bv.handArea.localToGlobal(new Point(ac.x,ac.y));
					else
						p1=target.view.localToGlobal(new Point(target.view.hcount.x,target.view.hcount.y));
					ac.x=p1.x;ac.y=p1.y;
					bv.addChild(ac);
				}
				bv.layoutHandArea();
			}else{    //如ARR放在手卡区
				for each(var ac:ACard in  arr){
					var p1:Point=target.view.localToGlobal(new Point(target.view.hcount.x,target.view.hcount.y));
					ac.x=p1.x;
					ac.y=p1.y;
					ac.scaleX=0.1;
					ac.scaleY=0.1;
					bv.addChild(ac);
				}
			}
			if(type==1){
				target.view.hcount.label=String(int(target.view.hcount.label)-arr.length);  //把手牌数减去弃的卡
			}
			
			if(type==1){
				var centArr:Array=OBJUtil.getCenterPos(Cons.BWID,Cons.BHEI,arr.length+usecardstack.length,Cons.CWID,Cons.CHEI);
				var index:int=usecardstack.length;
				for(var i:int in arr){
					var param:Object={x:centArr[i+index].x,y:centArr[i+index].y,scaleX:1,scaleY:1,rotation:0};
					TweenMax.to(arr[i],0.8,param);
				}
			}else{
				var centArr:Array=OBJUtil.getCenterPos(Cons.BWID,Cons.BHEI,arr.length,Cons.CWID,Cons.CHEI);
				for(var i:int in arr){
					var param:Object={x:centArr[i].x,y:centArr[i].y,scaleX:1,scaleY:1,rotation:0};
					TweenMax.to(arr[i],0.8,param);
				}
			}
		}
		
		public function sendCardsToPoint(arr:Array,target:Player):void{   //把卡从中间移动目标
			if(target.uid==GL.id){
				var tPoint:Array=OBJUtil.getCenterPos(bv.handArea.width,bv.handArea.height,arr.length+target.hand.length,Cons.CWID,Cons.CHEI);
				var index:int=0;
				for(var i:int in tPoint){
					if(i<target.hand.length){
						TweenMax.to(target.hand[i],0.8,{x:tPoint[i].x,y:tPoint[i].y});
					}else{
						var npoint:Point=bv.handArea.localToGlobal(new Point(tPoint[i].x,tPoint[i].y));
						TweenMax.to(arr[index],0.8,{x:npoint.x,y:npoint.y,onComplete:onMoveToSelf,onCompleteParams:[arr[index],target,tPoint[i]]});
						index++;
					}
				}
			}else{
				var targetPoint:Point=target.view.localToGlobal(new Point(target.view.hcount.x,target.view.hcount.y));	
				for(var i:int in arr){
					TweenMax.to(arr[i],0.8,{x:targetPoint.x,y:targetPoint.y,scaleX:0.1,scaleY:0.1,onComplete:onCardMoveEnd,onCompleteParams:[arr[i],target]});
				}
			}
		}
		private function onMoveToSelf(ca:ACard,p:Player,po:Object):void{//单张卡片移动到自己结束动画，将此卡加到牌区布局
			bv.handArea.addChild(ca);
			ca.x=po.x;
			ca.y=po.y;
			p.view.hcount.label= String(int(p.view.hcount.label)+1);
			p.hand.push(ca);
		}
		
		private function onCardMoveToGraveyardEnd(ca:ACard):void{//单张卡片移动结束动画，移除此卡
			bv.removeChild(ca);
			if(ca.id>=13 && ca.id<=18){
				
			}else{
				graveyardArr.push(ca);
			}
		}
		private function onCardMoveEnd(ca:ACard,p:Player):void{//单张卡片移动结束动画，移除此卡
			p.view.hcount.label=String(int(p.view.hcount.label)+1);
			bv.removeChild(ca);
		}	
		public function addCardsToCenter(arr:Array,isShow:Boolean=false):void{   //把卡组添加到屏幕中间
			var cpoint:Array=OBJUtil.getCenterPos(Cons.BWID,Cons.BHEI,arr.length,Cons.CWID,Cons.CHEI);
			for(var i:int in arr){
				arr[i].x=cpoint[i].x;
				arr[i].y=cpoint[i].y;
				if(isShow){
					TweenNano.from(arr[i],0.8,{alpha:0});
				}
				bv.addChild(arr[i]);
			}
		}
		private function onDiscardSelected(evt:WEvent):void
		{
			var p:Player=phash.get(GL.id) as Player;
			for each(var c:ACard in p.hand){
				c.canuse=false;
				c.selectType=0;
			}
			var param:Object={card:evt.param.vid,tid:GL.tableId,ctype:1,oid:oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
		}
		
		private function onAddCard(evt:WEvent):void
		{
			if(evt.param.hasOwnProperty("iden")){
				App.audio.play("assets/sounds/card/20/"+evt.param.iden+".mp3");
				return ;
			}
			if(evt.param.type==1)
				onDealingSingle(evt);
		}
		private function onCardLaunch(evt:WEvent):void
		{
			clearState();
			if(evt.param.disabled){
//				var c:ACard=usecardstack.pop() as ACard;
//				if(evt.param.moveto==0){
//					c.invalid=true;
//					sendCardsToGraveyard([c]);
//				}else{
//					sendCardsToPoint([c],phash.get(evt.param.moveto));
//				}
			}else{
				if(evt.param.hasOwnProperty("oid"))oid=evt.param.oid;
				AM.inst.action.play(evt.param);		
			}
		}
		private function onUseCard(evt:WEvent):void
		{
			clearState();
			var tvo:TargetVO=new TargetVO();
			tvo.setData(evt.param);
			var target:Object;
			var sponsor:Player=phash.get(tvo.sponsor) as Player;
			var centArr:Array;
			if(tvo.target>0)  //目标是玩家
				target=phash.get(tvo.target);
			else if(tvo.card>0){
				for each(var o:ACard in usecardstack){
					if(o.vid==tvo.card){
						target=o;
						break;
					}
				}
			}
			if(target && target is Player){
				bv.setReport(StringUtils.getColorString("["+sponsor.pname+"]",0xffff00)+"对"+StringUtils.getColorString("["+target.pname+"]",0xffff00)+"使用了"+StringUtils.getColorString("["+GL.cdata.get(tvo.cid).n+"]",0x00ff00));
				showArrow(sponsor,target);
			}else if(target && target is ACard){
				bv.setReport(StringUtils.getColorString("["+sponsor.pname+"]",0xffff00)+"对"+StringUtils.getColorString("["+target.cname+"]",0xffff00)+"使用了"+StringUtils.getColorString("["+GL.cdata.get(tvo.cid).n+"]",0x00ff00));
				showArrow(sponsor,target);
			}else{
				bv.setReport(StringUtils.getColorString("["+sponsor.pname+"]",0xffff00)+"使用了"+StringUtils.getColorString("["+GL.cdata.get(tvo.cid).n+"]",0x00ff00));
			}
			
			if(tvo.sponsor==GL.id){  //是自己发动的
				var arr:Array=sponsor.hand;
				var card:ACard;
				for (var i:int=0;i<arr.length;i++){
					if(arr[i].vid==tvo.cvid){
						card=arr[i] as ACard;
						if(card.id!=tvo.cid){
							card.color=tvo.color;
							card.id=tvo.cid;
						}
						card.canDiscover=tvo.canDiscover;
						card.canuse=false;
						arr.splice(i,1);
						break;
					}
				}
				usecardstack.push(card);
				card.bv=bv;			
				card.target=target;
				sendCardsToCenter([card],sponsor);
				GUtil.playCardSound(card,sponsor);
			}else{
				var p1:Point=sponsor.view.localToGlobal(new Point(sponsor.view.hcount.x,sponsor.view.hcount.y));
				var ca:ACard=new ACard();
				ca.color=tvo.color;
				ca.id=tvo.cid;
				ca.vid=tvo.cvid;
				ca.bv=bv;			
				ca.target=target;
				ca.canDiscover=tvo.canDiscover;
				usecardstack.push(ca);
				sendCardsToCenter([ca],sponsor);
				GUtil.playCardSound(ca,sponsor);
			}
			centArr=OBJUtil.getCenterPos(Cons.BWID,Cons.BHEI,usecardstack.length,Cons.CWID,Cons.CHEI);    //以下是把以前已经存在的卡布局
			if(centArr.length>1){
				var len:int=centArr.length-1;
				for (var j:int = 0; j < len; j++) 
				{
					TweenMax.to(usecardstack[j],0.8,{x:centArr[j].x,y:centArr[j].y});					
				}
			}
		}
		public function showArrow(other:Player, target:Object):void
		{
			arx=ary=arindex=0;
			bv.addChild(arrowspr);
			var dx:int=other.view.x+other.view.width/2;
			var dy:int=other.view.y+other.view.height/2;
			var tx:int=target is Player?(target.view.x+target.view.width/2):(target.x+target.width/2);
			var ty:int=target is Player?(target.view.y+target.view.height/2):(target.y+target.height/2);
			arrowspr.x=dx;
			arrowspr.y=dy;
			dx=dx-tx;
			dy=dy-ty;
			var dist:int=Math.sqrt(dx*dx+dy*dy);
			var rt:Number=Math.atan2(dy,dx)*(180/Math.PI)+180;
			arrowspr.rotation=rt;
			endp=(dist-15)/10+1;
			App.timer.doLoop(3,arrowMovie);
		}
		private function arrowMovie():void{
			var a:Arrow1=new Arrow1();
			arrowspr.addChild(a);
			a.x=arx;
			a.y=ary;
			arx+=10;
			arindex++;
			if(arindex==endp)App.timer.clearTimer(arrowMovie);
		}
		private function onUseCardMoveEnd(ca:ACard,target:Object):void{
			ca.bv=bv;			
			ca.target=target;
		}
		public var oid:int=0;
		private function onShowCanUseCard(evt:WEvent):void  //显示牌的可用状态
		{
			clearState();
			oid=evt.param.oid;
			var p:Player=	phash.get(GL.id) as Player;
			var hand:Array=p.hand;
			if(evt.param.cards){
				var arr:Array=evt.param.cards as Array;
				bv.setPassState(true,evt.param.time);
				for each(var obj:Object in arr){
					for each(var card:ACard in hand){
						if(card.vid==obj.vid){
							card.selectType=0;
							card.canuse=true;
							break;
						}
					}
				}
			}
			if(evt.param.skills){
				var arr:Array=evt.param.skills as Array;
				bv.setPassState(true,evt.param.time);
				for each(var obj:Object in arr){
					bv.setSkillBtnState(obj);	
				}
			}
			var arr1:Array=evt.param.users as Array;
			for each(var obj:Object in arr1){
				var p1:Player=phash.get(obj.uid) as Player;
				p1.view.showTime(evt.param.time);
			}
		}
		private function onDealingSingle(evt:WEvent):void
		{
			if(evt.param.cards){//自己发牌
				var arr:Array=evt.param.cards as Array;
				var p:Player=	phash.get(GL.id) as Player;
				bv.setReport(StringUtils.getColorString("["+(p.view.pname.text==""?p.view.htxt.text:p.view.pname.text)+"]",0xffff00)+"抽了"+arr.length+"张牌");
				var temp:Array=[];
				for(var i:int in arr){
					var c:ACard=new ACard();
					c.setdata(arr[i]);
					temp.push(c);
				}
				addCardsToCenter(temp);
				App.audio.play(Cons.audio.Deal);
				sendCardsToPoint(temp,p);
			}else{      //别人发牌
				var other:Player=phash.get(evt.param.to) as Player;
				var temp:Array=[];
				var len:int=evt.param.num;
				bv.setReport(StringUtils.getColorString("["+other.view.pname.text==""?other.view.htxt.text:other.view.pname.text+"]",0xffff00)+"抽了"+len+"张牌");
				for(var i:int=0;i<len;i++){
					var c:ACard=new ACard();
					c.bg.bitmapData=OBJUtil.getInstanceByClassName("Act0") as BitmapData;
					temp.push(c);
				}
				addCardsToCenter(temp);
				App.audio.play(Cons.audio.Deal);
				sendCardsToPoint(temp,other);
			}
		}
		private function onDealingAll(evt:WEvent):void   //发所有人的牌
		{
			bv.setReport("进入公共发牌阶段");
			var cards:Array=evt.param.cards as Array;
			var other:Array=phash.values(); 
			for each(var pp:Player in other){
				if(pp.uid!=GL.id){ //别人
					var temp:Array=[];
					for (var j:int = 0; j < 3; j++) 
					{
						var ca:ACard=new ACard();
						ca.bg.bitmapData=OBJUtil.getInstanceByClassName("Act0") as BitmapData;
						temp.push(ca);
					}
					addCardsToCenter(temp);
					App.audio.play(Cons.audio.Deal);
					sendCardsToPoint(temp,pp);
					
				}else{//自己
					var temp:Array=[];
					for(var i:int in cards){
						var c:ACard=new ACard();
						c.setdata(cards[i]);
						temp.push(c);
					}
					addCardsToCenter(temp);
					App.audio.play(Cons.audio.Deal);
					sendCardsToPoint(temp,pp);
				}
			}
		}
		private function onRoleChoosed(evt:WEvent):void
		{
			App.audio.backPlay(Cons.audio.GAMING1);
			var plist:Array=evt.param.plist;
			App.dialog.removeChild(rc);
			rc.dispose();
			var p:Player;
			for each(var o:Object in plist){
				p=phash.get(o.uid);
				if(o.uid==GL.id){
					o.rid=evt.param.rid;
					o.iden=evt.param.iden;
					GL.iden=o.iden;
				}
				p.setValue(o);
				bv.setReport(StringUtils.getColorString("["+p.view.rname.text+"]",0xffff00)+"选择了"+StringUtils.getColorString("["+(p.view.pname.text==""?p.view.htxt.text:p.view.pname.text)+"]",0xffff00));
				
			}
			bv.initSkillInfo(phash.get(GL.id));
		}
		public function setRoleTurn(p:Player):void   //设置到玩家回合了
		{
			if(!spotlight)spotlight=new SpotLight;
			spotlight.x=122;
			spotlight.y=178;
			p.view.addChild(spotlight);
			bv.setReport("当前"+StringUtils.getColorString("["+(p.view.pname.text==""?p.view.htxt.text:p.view.pname.text+"]"),0xffff00)+"的回合");
		}
		private var rc:RoleChoose;
		
		public function start(d:Object):void
		{
			bv.setReport("选择角色阶段");
//			App.keyboard.addQuickKick();
			App.audio.play(Cons.audio.CHOOSEROLE);
			AM.inst.initAction(0,phash,bv);
			rc=new RoleChoose();
			rc.init(d);
			rc.x = (App.stage.stageWidth - rc.width) * 0.5;
			rc.y = (App.stage.stageHeight - rc.height) * 0.5;
			App.dialog.addChild(rc);
		}
		public function register(bv:BattleView,d:Object):void{
			setEvents(true);
			this.bv=bv;
			phash=bv.initSeat(d);
			checkNetState();
			App.timer.doLoop(60000,checkNetState);
//			start(d);
		}
		private var nowTime:Number;
		private var oldTime:Number;
		private function checkNetState():void
		{
			oldTime=getTimer();
			SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.CheckNetState,{ctype:1});
		}
		public function sendCardsToInfoarea(c:ACard,target:Player):void  //把卡牌移到情报区当情报
		{
			var tpoint:Point;
			switch(c.color)
			{
				case 1:
					tpoint=target.view.localToGlobal(new Point(target.view.bcount.x,target.view.bcount.y));
					break;
				case 2:
					tpoint=target.view.localToGlobal(new Point(target.view.rcount.x,target.view.rcount.y));
					break;
				default:
					tpoint=target.view.localToGlobal(new Point(target.view.gcount.x,target.view.gcount.y));
					break;
			}
			TweenMax.to(c,0.8,{x:tpoint.x,y:tpoint.y,scaleX:0.1,scaleY:0.1,onComplete:onCardMovetoInfoEnd,onCompleteParams:[c,target]});
		}
		private function onCardMovetoInfoEnd(c:ACard,target:Player):void{
			bv.removeChild(c);
			target.infocards.push(c);
			switch(c.color)
			{
				case 1:
					target.blue.push(c);
					target.view.bcount.label=String(target.blue.length);
					if(target.rid==38)
						App.audio.play("assets/sounds/info/dog2.mp3");
					else
					App.audio.play(Cons.audio["true"+target.sex+""+Rand.range(1,3)]);
					break;
				case 2:
					target.red.push(c);
					target.view.rcount.label=String(target.red.length);
					if(target.rid==38)
						App.audio.play("assets/sounds/info/dog2.mp3");
					else
					App.audio.play(Cons.audio["true"+target.sex+""+Rand.range(1,3)]);
					break;
				case 3:
					target.black.push(c);
					target.view.setBlack(target.black.length);
					if(target.rid==38)
						App.audio.play("assets/sounds/info/dog1.mp3");
					else
					App.audio.play(Cons.audio["black"+target.sex+""+Rand.range(1,3)]);
					break;
				case 4:
					target.black.push(c);
					target.view.setBlack(target.black.length);
					target.red.push(c);
					target.view.rcount.label=String(target.red.length);
					if(target.rid==38)
						App.audio.play("assets/sounds/info/dog1.mp3");
					else
					App.audio.play(Cons.audio["black"+target.sex+""+Rand.range(1,3)]);
					break;
				case 5:
					target.black.push(c);
					target.view.setBlack(target.black.length);
					target.blue.push(c);
					target.view.bcount.label=String(target.blue.length);
					if(target.rid==38)
						App.audio.play("assets/sounds/info/dog1.mp3");
					else
					App.audio.play(Cons.audio["black"+target.sex+""+Rand.range(1,3)]);
					break;
			}
		}
	}
}