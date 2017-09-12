package skills
{
	import com.greensock.TweenMax;
	
	import flash.events.MouseEvent;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import views.ACard;
	/**
	 * 灵通
	 */	
	public class Skill119 extends Skill
	{
		override public function launch():void
		{
			
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
		private var targetid:int=-1;
		private var tn:int=0;//目标玩家的手牌数
		private var num:int=0;//递出牌的数量
//		private var m:int=0;
		override protected function onTargetSelect(evt:MouseEvent):void
		{
			targetid=evt.currentTarget.uid;
			clearState();
			var self:Player=phash.get(GL.id);
			self.view.showTime(9000);
			var temp:Array=[];
			for(var i:int in self.hand){
				var ac:ACard=new ACard();
				ac.setdata(self.hand[i]);
				temp.push(ac);
			}
			var n:int=phash.get(GL.id).black.length+1
			bv.showCardDialog(temp,"请选择最多"+n+"张手牌递给目标",n,2,targetid,userselected);
		}
		public function userselected(arr:Array):void{
			var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,target:targetid,cards:arr,oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnSkillLaunch,param);
		}
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playNormalAni();
			TweenMax.delayedCall(1,delayedFun);
		}
		
		override public function delayedFun():void{
//			if(!data.cards)return;
			var s:Player=phash.get(tvo.sponsor);
//			var t:Player=phash.get(tvo.target);
			num=data.num;//递出的张数
			tn=data.tn;//目标玩家的手牌数
//			var n:int=phash.get(tvo.sponsor).black.length+1
//			m=Math.min(n,tn);
			s.view.showTime(9000);
			if(s.uid==GL.id){
				var temp:Array=[]
				for(var i:int=0;i<tn;i++){
					var ac:ACard=new ACard();
					ac.bg.bitmapData=new Act0;
					temp.push(ac);
				}
				bv.showCardDialog(temp,"请选择最多"+num+"张手牌抽到你的手里",num,1);
			}else{
				bv.showInfo("请等待肖惜灵操作");
			}
		}
	}
}