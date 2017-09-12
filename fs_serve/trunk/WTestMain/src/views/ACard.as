package views
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import core.mng.Evt;
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	
	import game.ui.test.CardViewUI;
	
	import manage.AM;
	import manage.BM;
	
	import util.GUtil;
	
	import utils.OBJUtil;
	import utils.effect.EffectsManager;
	
	public class ACard extends CardViewUI
	{
		private var _id:int;
		private var _vid:int;
		public var color:int;
		private var _canuse:Boolean;
		private var _target:Object;
		public var bv:BattleView;
		public var send:int;
		private var _cname:String;
		private var _invalid:Boolean=false;  //失效
		public function ACard()
		{
//			this.cacheAsBitmap=true;
			super();
		}

		public function get cname():String
		{
			if(id>0)return GL.cdata.get(id).n;
			return _cname;
		}

		public function set cname(value:String):void
		{
			_cname = value;
		}

		public function get invalid():Boolean
		{
			return _invalid;
		}
		private var invalidEff:MovieClip;
		public function set invalid(value:Boolean):void
		{
			if(value){
				if(!invalidEff){
				invalidEff=new Eff3;
				invalidEff.x=this.width/2;
				invalidEff.y=this.height/2;
				addChild(invalidEff);
				}
				invalidEff.gotoAndPlay(1);
			}else{
				if(invalidEff && this.contains(invalidEff)){
					this.removeChild(invalidEff);
					invalidEff=null;
				}
			}
			_invalid = value;
		}

		public function get clone():ACard{
			var ac:ACard=new ACard();
			ac.color=color;
			ac.id=this.id;
			ac.vid=this.vid;
			return ac;
		}
		public function get target():Object
		{
			return _target;
		}

		public function set target(value:Object):void
		{
			if(value){
				this.addEventListener(MouseEvent.ROLL_OVER,onMouseRollover);
				this.addEventListener(MouseEvent.ROLL_OUT,onMouseRollout);
			}else{
				if(this.hasEventListener(MouseEvent.ROLL_OVER))
				this.removeEventListener(MouseEvent.ROLL_OVER,onMouseRollover);
				if(this.hasEventListener(MouseEvent.ROLL_OUT))
				this.addEventListener(MouseEvent.ROLL_OUT,onMouseRollout);
			}
			_target = value;
		}
		
		protected function onMouseRollout(event:MouseEvent):void
		{
			if(head && bv.contains(head))
			bv.removeChild(head);
			if(arrow &&　bv.contains(arrow))
			bv.removeChild(arrow);
			head=arrow=null;
		}
		private var head:Shape,arrow:Shape;
		protected function onMouseRollover(event:MouseEvent):void
		{
//						bv.usedCardRecovery.push(ca);
						var p1:Point=this.localToGlobal(new Point(this.width/2,this.height/2));
						var p2:Point;
						if(target is Player)
							p2=target.view.localToGlobal(new Point(target.view.width/2,target.view.height/2));
						else{
							p2=target.localToGlobal(new Point(target.width/2,target.height/2));
						}
						var dx:Number=p2.x-p1.x;
						var dy:Number=p2.y-p1.y;
						var dist:Number=Math.sqrt(dx*dx+dy*dy);
						 head=GUtil.getHead();	
						arrow=GUtil.getArrow(dist);
						head.x=p2.x;
						head.y=p2.y;
						arrow.x=p2.x;
						arrow.y=p2.y;
						arrow.rotation=Math.atan2(dy,dx)*180/Math.PI-90;
						head.rotation=Math.atan2(dy,dx)*180/Math.PI+90;
						bv.addChild(head);
						bv.addChild(arrow);
		}
		
		public function get canuse():Boolean
		{
			return _canuse;
		}

		public function set canuse(value:Boolean):void
		{
			value?EffectsManager.Glow(this,0x00ff00,1,3,3,5):EffectsManager.clearGlow(this);
			if(value){
				this.doubleClickEnabled=true;
				this.addEventListener(MouseEvent.DOUBLE_CLICK,onDOUBLE_CLICK);
			}else{
				this.doubleClickEnabled=false;
				this.removeEventListener(MouseEvent.DOUBLE_CLICK,onDOUBLE_CLICK);
				if(targets)cleartargets();
			}
			_canuse = value;
		}
		
		private function cleartargets():void
		{
			for(var i:int in targets){
				EffectsManager.clearGlow(targets[i].view);
				targets[i].view.removeEventListener(MouseEvent.MOUSE_DOWN,onTargetSelect);
			}
			targets=null;
		}
		public var selectType:int=0;  //选择类型  0发动功能牌 1选择弃牌  2选择传情报
		protected function onDOUBLE_CLICK(event:MouseEvent):void
		{
			if(selectType==0)
				AM.inst.excute(this.id,vid);
			else if(selectType==1){
				Evt.dipatch("DISCARD_SELECTED",{vid:vid,id:id});
			}else{
				BM.inst.clearState();
				var st:int=GL.cdata.get(this.id).s;
				if(st==1){
					 targets=[];
					var players:Array=BM.inst.phash.values();
					for each(var p:Player in players){
						if(p.uid!=GL.id && !p.isDead && !p.isLost){
							targets.push(p);
						}
					}
					for each(var p:Player in targets){
						EffectsManager.Glow(p.view,0xff0000,1,4,4,5);
						p.view.addEventListener(MouseEvent.MOUSE_DOWN,onTargetSelect);
					}
				}else{
					SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,{card:_vid,target:-1,ctype:1,tid:GL.tableId,oid:BM.inst.oid});
				}
			}
			
		}
		private var targets:Array;
		public var canDiscover:Boolean=true;
		protected function onTargetSelect(event:MouseEvent):void
		{
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,{card:_vid,target:event.currentTarget.uid,ctype:1,tid:GL.tableId,oid:BM.inst.oid});
		}
		private var targetmov:MovieClip;
		public function showTargetMov(boo:Boolean):void{
			if(boo){
				if(!targetmov)targetmov=new TargetMov();
				targetmov.x=this.width/2;
				targetmov.y=this.height/2;
				this.addChild(targetmov);
				targetmov.play();
			}else{
				if(targetmov && this.contains(targetmov)){
					this.removeChild(targetmov);
					targetmov.stop();
				}
			}
		}
		public function get vid():int
		{
			return _vid;
		}

		public function set vid(value:int):void
		{
			_vid = value;
		}

		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			if(value>0 && value<22){
				this.bg.bitmapData=OBJUtil.getInstanceByClassName("Act"+value+"_"+color) as BitmapData;
			}
			if(value==0)this.bg.bitmapData=OBJUtil.getInstanceByClassName("Act"+value+"_"+color) as BitmapData;
			if(value==99)this.bg.bitmapData=OBJUtil.getInstanceByClassName("Act"+value+"_0") as BitmapData;
			
			_id = value;
		}

		public function setdata(card:Object):void
		{
			this.vid=card.vid;
			this.color=card.color;
			this.id=card.id;
			this.send=card.send;
		}
	}
}