package datas
{
	public class TargetVO
	{
		public var sponsor:int;  //发动者
		public var target:int;//发动目标玩家
		public var cvid:int;  
		public var cid:int;  
		public var color:int=-1;
		public var card:int;  
		public var targets:Array;
		public var cards:Array;
		public var dur:int;
		public var discards:Array;  //失效的多个目标
		public var disabled:Boolean;
		public var sid:int;
		public var canDiscover:Boolean=true;
		public function setData(obj:Object):void{
			sponsor=obj.sponsor;
			target=obj.target;
			cvid=obj.cvid;
			cid=obj.cid;
			color=obj.color;
			card=obj.card;
			dur=obj.dur;
			disabled=obj.disabled;
			targets=obj.targets;
			cards=obj.cards;
			discards=obj.discards;
			sid=obj.sid;
			canDiscover=obj.canDiscover;
		}
	}
}