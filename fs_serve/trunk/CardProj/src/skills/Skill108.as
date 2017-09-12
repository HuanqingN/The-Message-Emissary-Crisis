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
	import utils.StringUtils;
	
	import views.ACard;
	import views.DecodeDialog;

		/**
		 * 治愈天籁
		 */	
		public class Skill108 extends Skill
		{
			override public function launch():void
			{
				var arr:Array=phash.values();
				targets=[];
				for each(var i:Player in  arr){
//					if(!i.myTurn &&  !i.isDead && !i.isLost && i.uid!=GL.id && !i.isLock && !i.isCaptal){
					if(!i.isDead && !i.isLost && (i.isLock || i.isSkip)){
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
				var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,target:targetid,oid:bm.oid};
				SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnSkillLaunch,param);
				clearState();
			}
			override public function play(tvo1:SkillVO,obj:Object):void
			{
				super.play(tvo1,obj);
				if(obj.goOn){
					delayedFun();
				}else if (obj.tanxun)	{
					showTanxun();
				}else if(obj.draw){
					drawCard();
				}else if(obj.turn){
					roleTurn();
				}else{
					playTurnAni(0,obj.rid);
					App.audio.play(Cons.audio.TurnRole);
					App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,4)+".mp3");
					var p:Player=phash.get(tvo.sponsor);
					p.rid=data.rid;
				}
			}
			
			override public function delayedFun():void
			{
				var sponsor:Player=phash.get(tvo.sponsor);
				var target:Player=phash.get(tvo.target);
				sponsor.isSkip= sponsor.isLock = target.isSkip = target.isLock = false;
				sponsor.view.showTime(10000);
				if(sponsor.uid==GL.id){
					clearState();
					var decodedialog:DecodeDialog = new DecodeDialog();
					decodedialog.popupCenter=true;
					decodedialog.bt3.visible=false;
					//					bv.decodedialog.bt3.disabled=true;
					decodedialog.title.text="请选择一项：";
					decodedialog.bt1.label="①探寻分牌";
					decodedialog.bt1.labelColors="0x000000";
					decodedialog.bt2.label="②弃牌盖伏";
					decodedialog.bt2.labelColors="0x000000";
					if(int(sponsor.view.hcount.label) < 1) decodedialog.bt2.disabled = true; //如果没手牌，就不能选择弃牌盖伏
					decodedialog.callFun=onTypeChoosed;
					decodedialog.popup();
				}else{
					bv.showInfo("请等待梦音操作");
				}
			}
			private var type:int =0;
			public function onTypeChoosed(type:int):void{//1探寻分牌 2弃牌盖伏
				this.type=type;
//				if(type==1){
//					showTanxun();
//				} else{
					var param:Object={sponsor:GL.id,tid:GL.tableId,ctype:1,type:type,oid:bm.oid};
					SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
					clearState();
//				}
			}
			
			public function showTanxun():void{//展示探寻的牌
				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(5,5)+".mp3");
				var cards:Array=data.cards;
				var temp:Array=[];
				for(var i:int in cards){
					var c:ACard=new ACard();
					c.setdata(cards[i]);
					temp.push(c);
				}
				//				p.view.showTime(tvo.dur);
				bm.addCardsToCenter(temp,true);//展示四张牌
				TweenMax.delayedCall(2,delayedFun1,[temp]);
			}
			
			public function delayedFun1(arr:Array):void{//选择要加入手牌的牌
				for  (var j:int in arr) {
					bv.removeChild(arr[j]);
				}
				var p:Player=phash.get(tvo.sponsor);
				p.view.showTime(10000);
				if(tvo.sponsor==GL.id){
					var temp:Array=[];
					var arr2:Array=data.cards2;
					for(var i:int in arr2){
						var ac:ACard=new ACard();
						ac.setdata(arr2[i]);
						temp.push(ac);
					}
					bv.showCardDialog(temp,"请选择要加入手牌的牌",4,2);
				}else{
					bv.showInfo("请等待梦音探寻");
				}
			}
			
			private function drawCard():void //展示要加入手牌的牌
			{
				bv.hideInfo();//关掉中间的信息显示，不然会挡住牌的显示
				
				var p:Player = phash.get(tvo.sponsor);
				var arr:Array=data.cards3;
				var temp_draw:Array=[];
				bv.setReport(StringUtils.getColorString("["+(p.view.pname.text==""?p.view.htxt.text:p.view.pname.text)+"]",0xffff00)+"探寻到了"+arr.length+"张牌");
				for(var j:int in arr){
					var c:ACard=new ACard();
					c.setdata(arr[j]);
					temp_draw.push(c);
				}
				bm.addCardsToCenter(temp_draw,true);
				TweenMax.delayedCall(1.5,drawCard2,[temp_draw]);
			}
			
			public function drawCard2(arr:Array):void{//梦音选择的牌加入手牌
				var p:Player = phash.get(tvo.sponsor);
				bm.sendCardsToPoint(arr, p);
				App.audio.play(Cons.audio.Deal);
				TweenMax.delayedCall(1,drawCard3);
			}
			
			public function drawCard3():void{//展示选剩的牌
				
				var arr2:Array=data.cards4;
				var temp_drop:Array=[];
				for(var k:int in arr2){
					var c2:ACard=new ACard();
					c2.setdata(arr2[k]);
					temp_drop.push(c2);
				}
				bm.addCardsToCenter(temp_drop,true);
				TweenMax.delayedCall(1.5,drawCard4,[temp_drop]);
			}
			
			public function drawCard4(arr:Array):void{//选剩的牌进入目标手牌动画
				var p:Player = phash.get(tvo.target);
				bm.sendCardsToPoint(arr, p);
				App.audio.play(Cons.audio.Deal);
				bv.setReport(StringUtils.getColorString("[梦音]分给了["+(p.view.pname.text==""?p.view.htxt.text:p.view.pname.text)+"]",0xffff00)+arr.length+"张牌");
			}
			
			private function roleTurn():void{
				var p:Player=phash.get(tvo.sponsor);
				playTurnAni(p.rid,0);
				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(6,6)+".mp3");
				p.rid=0;
			}
		}
}