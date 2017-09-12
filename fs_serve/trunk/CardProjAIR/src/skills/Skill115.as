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
	import views.DecodeDialog;

		/**
		 * 信息销毁
		 */	
		public class Skill115 extends Skill
		{
			override public function play(tvo1:SkillVO,obj:Object):void
			{
				super.play(tvo1,obj);
				playNormalAni();
				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,3)+".mp3");
				TweenMax.delayedCall(1,delayedFun1);
			}
			public function delayedFun1():void{
				var p:Player=phash.get(tvo.sponsor);
				p.view.showTime(10000);
				if(p.uid==GL.id){
					var arr:Array=phash.values();
					targets=[];
					for each(var i:Player in  arr){
						if(!i.isDead && !i.isLost && i.uid!=tvo.target && i.infocards.length>0){
								targets.push(i.view);
						}
					}
					bv.showInfo("请选择一个玩家发动");
					this.showTarget();
				}else{
					bv.showInfo("请等待黑客操作");
				}
			}
			private var targetid:int=-1;
			override protected function onTargetSelect(evt:MouseEvent):void
			{
				targetid=evt.currentTarget.uid;
				clearState();
				if(!bv.decodedialog){
					bv.decodedialog=new DecodeDialog();
					bv.decodedialog.popupCenter=true;
				}
				bv.decodedialog.callFun=onColorChoosed;
				bv.decodedialog.popup();
			}
			public function onColorChoosed(color:int):void{
				var param:Object={sponsor:GL.id,tid:GL.tableId,ctype:1,target:targetid,type:color,oid:bm.oid};
				SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
				clearState();
			}
		}
}