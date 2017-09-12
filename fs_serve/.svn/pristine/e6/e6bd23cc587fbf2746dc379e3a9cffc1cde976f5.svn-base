package skills
{
	import flash.events.MouseEvent;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	import datas.TargetVO;
	
	import manage.BM;
	
	import utils.HashMap;
	import utils.effect.EffectsManager;
	
	import views.BattleView;

	public class Skill
	{
		public var bm:BM;
		public var self:Player;
		public var phash:HashMap;
		public var bv:BattleView;
		public var id:int;
		public var color:int;
		public var name:String;
		public var desc:String;
		public var tvo:SkillVO;
		public var rid:int;
		public var data:Object;
		public function Skill()
		{
			bm=BM.inst;
			phash=bm.phash;
//			self=phash.get(GL.id);
			bv=bm.bv;
		}
		public var targets:Array;
		public var cards:Array;
		public function launch():void{
			var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnSkillLaunch,param);
			bm.clearState(true);
		}
		
		protected function showTarget():void{
			for(var i:int in targets){
				EffectsManager.Glow(targets[i],0xff0000,1,4,4,5);
				targets[i].showTargetMov(true);
				targets[i].addEventListener(MouseEvent.MOUSE_DOWN,onTargetSelect);
			}
		}
		protected function showCards():void{
			for(var i:int in cards){
				EffectsManager.Glow(cards[i],0x00ff00,1,4,4,5);
				cards[i].addEventListener(MouseEvent.MOUSE_DOWN,onCardsSelect);
			}
		}
		protected function onTargetSelect(evt:MouseEvent):void{
		}
		protected function onCardsSelect(evt:MouseEvent):void{
		}
		public function clearState():void{
			if(targets){
				for(var i:int in targets){
					EffectsManager.clearGlow(targets[i]);
					targets[i].showTargetMov(false);
					targets[i].removeEventListener(MouseEvent.MOUSE_DOWN,onTargetSelect);
				}
				targets=null;
			}
			if(cards){
				for(var i:int in cards){
					EffectsManager.clearGlow(cards[i]);
					cards[i].removeEventListener(MouseEvent.MOUSE_DOWN,onCardsSelect);
				}
				cards=null;
			}
		}
		public function excuteBlue():void{
			
		}
		public function play(tvo1:SkillVO,obj:Object):void{
			this.tvo=tvo1;
			this.data=obj;
		}
		public function delayedFun():void{
			
		}
		public function playAni():void{
			
		}
		public function playYellowAni():void{
			bv.playplayYellowAnimation(color,name,phash.get(tvo.sponsor).rid);
		}
		public function playNormalAni():void{
			bv.playSkillNormalAnimation(color,name,phash.get(tvo.sponsor).rid);
		}
		public function playTurnAni(frid:int=0,rid:int=0):void{
			bv.playSkillTurnAnimation(color,name,frid,rid);
		}
	}
}