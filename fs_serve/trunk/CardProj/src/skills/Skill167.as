package skills
{
	import com.greensock.TweenMax;
	
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import utils.OBJUtil;
	import utils.Rand;
	import utils.StringUtils;
	
	import views.ACard;
	import views.DecodeDialog;

		/**
		 * 疾风骤雨
		 */	
		public class Skill167 extends Skill
		{
			override public function play(tvo1:SkillVO,obj:Object):void
			{
				super.play(tvo1,obj);
				if(obj.chooseDiscard){
					chooseDiscard();
				}
				else if(obj.turn){
					roleTurn();
				}else{
					playNormalAni();
					//					App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,3)+".mp3");
					TweenMax.delayedCall(1.5,delayedFun);
				}
			}
			
			override public function delayedFun():void
			{
				var p:Player=phash.get(tvo.sponsor);
				p.view.showTime(10000);
				if(p.uid==GL.id){
					clearState();
					var decodedialog:DecodeDialog = new DecodeDialog();
					decodedialog=new DecodeDialog();
					decodedialog.popupCenter=true;
					decodedialog.bt3.visible=false;
					//					bv.decodedialog.bt3.disabled=true;
					decodedialog.title.text="请选择一项：";
					decodedialog.bt1.label="①弃牌";
					decodedialog.bt1.labelColors="0x000000";
					decodedialog.bt2.label="②翻转";
					decodedialog.bt2.labelColors="0x000000";
					decodedialog.callFun=onTypeChoosed;
					decodedialog.popup();
				}else{
					bv.showInfo("请等待武僧操作");
				}
			}
			private var type:int =0;
			public function onTypeChoosed(type:int):void{//1弃牌 2翻转
				this.type=type;
				if(type==1){
					disCard();
				} else{
					var param:Object={sponsor:GL.id,tid:GL.tableId,ctype:1,type:type,oid:bm.oid};
					SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
					clearState();
				}
			}
			
			private function disCard():void{
				clearState();
				var arr:Array=phash.values();
				targets=[];
				for each(var i:Player in  arr){
					if(i.uid!=GL.id && !i.isDead && !i.isLost && int(i.view.hcount.label)>1)
						targets.push(i.view);
				}
				bv.showInfo("请选择一个玩家");
				this.showTarget();
			}
			
			override protected function onTargetSelect(evt:MouseEvent):void
			{
				var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,target:evt.currentTarget.uid,type:this.type,oid:bm.oid};
				SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
				clearState();
			}
			
			private function chooseDiscard():void{
				clearState();
				var p:Player=phash.get(tvo.sponsor);
				p.view.showTime(10000);
				if(tvo.sponsor==GL.id){
					var temp:Array=[];
					var arr:Array=data.cards;
					for(var i:int in arr){
						var ac:ACard=new ACard();
						ac.setdata(arr[i]);
						temp.push(ac);
					}
					bv.showCardDialog(temp,"以下为目标手牌，请选择一张弃置",1,2);
				}else{
					bv.showInfo("请等待武僧·战斗操作");
				}
			}
			
			private function roleTurn():void{
				var p:Player=phash.get(tvo.sponsor);
				playTurnAni(p.rid,54);
				if(GL.id==p.uid){
					p.skillHash.clear();
					p.skillHash=null;
					p.clearRoleTip(); //清除角色说明。需要写在set rid函数之前。
					p.rid=54;
					bv.initSkillInfo(p);
				}else{
					p.skillHash=null;
					p.clearRoleTip(); //清除角色说明。需要写在set rid函数之前。
					p.rid=54;
				}
				p.view.hint.visible=false;
			}
		}
}
