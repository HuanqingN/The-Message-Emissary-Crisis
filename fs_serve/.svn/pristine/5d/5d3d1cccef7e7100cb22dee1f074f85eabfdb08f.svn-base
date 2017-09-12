package core.mng
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	
	import datas.GL;
	import datas.Trans;
	
	import utils.HashMap;
	import utils.OBJUtil;
	import utils.StringUtils;
	import utils.effect.IMGManager;
	
	import views.ACard;
	import views.RoleArea;

	public class Player
	{
		private var _view:RoleArea;
		public var hand:Array=[];  //手卡
		public var uid:int;
		private var _rid:int;
		private var _iden:int;
		public var deadType:int;  //
		public var uname:String;   //用户名
		private var _hname:String;    //潜伏角色临时名称
//		public var first:Boolean=false;
		public var blue:Array=[];
		public var red:Array=[];
		public var black:Array=[];
		public var infocards:Array=[];
		public var sex:int=1;   //0女1男;
		public var myTurn:Boolean;
		public var skillHash:HashMap;
		private var _isLost:Boolean;
		private var _isDead:Boolean=false; 
		private var _isSkip:Boolean=false; 
		private  var _isLock:Boolean=false; 
		private var _isCaptal:Boolean=false;
		
		public function get isPoison():int
		{
			return _isPoison;
		}
		private var poisonMov:MovieClip;
		public function set isPoison(value:int):void
		{
			_isPoison = value;
			if(value>0){
				if(!poisonMov){
					poisonMov=new Eff10();
					poisonMov.x=110;
					poisonMov.y=33;				
					view.addChild(poisonMov);
					poisonMov.gotoAndPlay(1);
				}
				Eff10(poisonMov).txt.num.text=value.toString();
			}else{
				if(poisonMov && view.contains(poisonMov)){
					view.removeChild(poisonMov);
					poisonMov=null;
				}
			}
		}

		public function get rname():String
		{
			return _rname;
		}

		public function set rname(value:String):void
		{
			_rname = value;
			view.rname.text=value;
		}

		public function get iden():int
		{
			return _iden;
		}

		public function set iden(value:int):void
		{
			_iden = value;
			if(GL.id==this.uid)
			GL.iden=value;
			view.g1.skin=Trans.getSkinByIdentity(value);
			view.g1.mouseEnabled=false
		}

		public function get hname():String
		{
			return _hname;
		}

		public function set hname(value:String):void
		{
			_hname = value;
			view.htxt.text=value?value:"";
		}

		public function get pname():String
		{
			if(view){
				return view.pname.text==""?view.htxt.text:view.pname.text;
			}
			return _pname;
		}

		public function set pname(value:String):void
		{
			_pname = value;
		}

		public function get rid():int
		{
			return _rid;
		}

		public function set rid(value:int):void
		{
			_rid = value;
			if(value>0){
				view.back.bitmapData=OBJUtil.getInstanceByClassName("Role" +value) as BitmapData;
				view.pname.text=GL.roleData.get(value).n;
				initSkillByRid(rid);
				view.toolTip=getRoleTip;
			}else{
				view.back.bitmapData=new Role0;
				view.pname.text="";
				roletiptxt=null;
				view.toolTip=null;
			}
		}
		private var roletiptxt:String;
		private function getRoleTip():void
		{
			if(skillHash && !roletiptxt){
				roletiptxt="";
				var arr:Array=skillHash.values();
				for(var i:int in arr){
					roletiptxt+=StringUtils.getColorString(arr[i].name,Trans.getSkillColor(arr[i].color))+"\n";
					roletiptxt+=arr[i].desc+"\n";
				}
				roletiptxt+="────────────────";
				roletiptxt+=StringUtils.getColorString("酱油任务",0x00ff00)+"\n";
				roletiptxt+=GL.taskData.get(GL.roleData.get(rid).st).n;
			}
			App.tipview.setText(roletiptxt);
			App.tip.addChild(App.tipview);
		}
		
		public function get isLost():Boolean
		{
			return _isLost;
		}

		public function set isLost(value:Boolean):void
		{
			_isLost = value;
			if(value){  //失败了
				IMGManager.setSaturation(this.view,-100);
				var eff:Eff5=new Eff5();
				eff.mc.gotoAndStop(deadType+"_"+iden);
				eff.x=view.width/2;
				eff.y=view.height/2;
				view.addChild(eff);
			}
		}

		public function get isDead():Boolean
		{
			return _isDead;
		}
		
		public function set isDead(value:Boolean):void
		{
			_isDead = value;
			if(value){  //死了
				IMGManager.setSaturation(this.view,-100);
				var eff:Eff5=new Eff5();
				eff.mc.gotoAndStop(deadType+"_"+iden);
				eff.x=view.width/2;
				eff.y=view.height/2;
				view.addChild(eff);
			}
		}

		public function get isCaptal():Boolean
		{
			return _isCaptal;
		}
		private var captalMov:MovieClip;
		public function set isCaptal(value:Boolean):void
		{
			_isCaptal = value;
			if(value){
				if(!captalMov){
					captalMov=new Eff4();
					captalMov.x=view.width/2;
					captalMov.y=view.height/2;				
					view.addChild(captalMov);
				}
				captalMov.gotoAndPlay(1);
			}else{
				if(captalMov && view.contains(captalMov)){
					view.removeChild(captalMov);
					captalMov=null;
				}
			}
		}

		public function get isSkip():Boolean
		{
			return _isSkip;
		}
		private var skipMov:MovieClip;
		public function set isSkip(value:Boolean):void
		{
			_isSkip = value;
			if(value){
				if(!skipMov){
				skipMov=new Eff2();
				skipMov.x=view.width/2;
				skipMov.y=view.height/2;				
				view.addChild(skipMov);
				}
				skipMov.gotoAndPlay(1);
			}else{
				if(skipMov && view.contains(skipMov)){
					view.removeChild(skipMov);
					skipMov=null;
				}
			}
		}

		public function get isLock():Boolean
		{
			return _isLock;
		}
		private var lockMov:MovieClip;
		private var _pname:String;
		private var _rname:String;
		private var _isPoison:int;
		public function set isLock(value:Boolean):void
		{
			_isLock = value;
			if(value){
				if(!lockMov){
				lockMov=new Eff1();
				lockMov.x=view.width/2;
				lockMov.y=view.height/2-30;
				view.addChild(lockMov);
				}
				lockMov.gotoAndPlay(1);
			}else{
				if(lockMov && view.contains(lockMov)){
					view.removeChild(lockMov);
					lockMov=null;
				}
			}
		}

		public function get view():RoleArea
		{
			return _view;
		}

		public function set view(value:RoleArea):void
		{
			_view = value;
			value.uid=this.uid;
		}

		public function setValue(obj:Object):void{
			if(obj.hasOwnProperty("hname")){
				hname=obj.hname;
			}else{
				hname=null;
			}
			if(obj.hasOwnProperty("iden"))iden=obj.iden;
			rid=obj.rid;
			view.initBloodBar(rid==29?4:3);
		}
		public function initSkillByRid(rid:int):void{
			if(rid>0){
				sex=GL.roleData.get(rid).sex;
				if(skillHash)return;
				skillHash=new HashMap();
				var rdata:Object=GL.roleData.get(rid);
				for (var i:int = 1; i <= 4; i++) 
				{
					var sid:int=rdata["s"+i];
					if(sid>0){
						var s:Object=OBJUtil.getInstanceByClassName("skills.Skill"+sid);
						s.id=sid;
						s.color=GL.skillData.get(sid).co;
						s.name=GL.skillData.get(sid).n;
						s.desc=GL.skillData.get(sid).desc;
						s.rid=rid;
						skillHash.put(sid,s);
					}
				}
			}
		}
		public function removeInfoCardByVid(vid:int):ACard{
			var result:ACard;
			var temp:ACard;
			temp=removeInfoCard(infocards,vid);
			if(temp){
				var index:int=0;
				index=black.indexOf(temp);
				if(index>=0){
					black.splice(index,1);
					view.setBlack(black.length);
					view.gcount.label=black.length.toString();
				}
				index=red.indexOf(temp);
				if(index>=0){
					red.splice(index,1);
					view.rcount.label=red.length.toString();
				}
				index=blue.indexOf(temp);
				if(index>=0){
					blue.splice(index,1);
					view.bcount.label=blue.length.toString();
				}
			}
//			temp=removeInfoCard(black,vid);
//			if(temp){
//				view.setBlack(black.length);
////				view.gcount.label=black.length.toString();
//				if(!result)result=temp;
//			}
//			temp=removeInfoCard(red,vid);
//			if(temp){
//				view.rcount.label=red.length.toString();
//				if(!result)result=temp;
//			}
//			temp=removeInfoCard(blue,vid);
//			if(temp){
//				view.bcount.label=blue.length.toString();
//				if(!result)result=temp;
//			}
			return temp;
		}
		public function removeInfoCard(arr:Array,vid:int):ACard{
			for(var i:int in arr){
				if(arr[i].vid==vid){
					return arr.splice(i,1)[0];
					break;
				}
			}
			return null;
		}
		public function getHandCardByVid(vid:int):ACard{
			for(var i:int in hand){
				if(hand[i].vid==vid)return hand[i];
			}
			return null;
		}
		
		public function removeHandCardByVid(vid:int):ACard{
			for(var i:int in hand){
				if(hand[i].vid==vid){
					var c:ACard=hand[i];
					hand.splice(i,1);
					return c;
				}
			}
			return null;
		}
	}
}