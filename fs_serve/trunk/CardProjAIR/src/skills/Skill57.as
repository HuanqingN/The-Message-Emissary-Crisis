package skills
{
	import flash.events.MouseEvent;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	
	import utils.HashMap;
	import utils.Rand;
	
	import views.ACard;

	/**
	 * 爱情
	 */	
	public class Skill57 extends Skill
	{
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			if(obj.goOn){
				var p:Player=phash.get(tvo.sponsor);
				p.view.showTime(10000);
				if(p.uid==GL.id)
				excuteBlue();
				else
					bv.showInfo("请等待大美女操作");
			}else{
				playNormalAni();
				count=0;
				App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,3)+".mp3");
			}
		}
		private var count:int=0;
		private var uids:HashMap;
		override public function excuteBlue():void
		{
			if(count==0){
				uids=new HashMap();
				selectRole();
			}else{
				bv.passView.setInfo("是否继续烧毁情报?",2,1,"取消","继续",passSelect);
				bv.passView.x=(1000-bv.passView.width)/2;
				bv.passView.y=470;
				bv.passView.popupCenter=false;
				App.dialog.show(bv.passView);
			}
		}
		public function selectRole():void{
			bv.showInfo("请选择要烧毁的玩家");
			targets=[];
			var arr:Array=phash.values();
			for each(var p:Player in arr){
				if(!p.isDead && !p.isLost && !uids.containsKey(p.uid) && p.black.length>0){
					targets.push(p.view);
				}
			}
			showTarget();
		}
		private var targetid:int=0;
		override protected function onTargetSelect(evt:MouseEvent):void
		{
			bv.hideInfo();
			clearState();
			targetid=evt.currentTarget.uid;
			uids.put(targetid,true);
			var temp:Array=[];
			var ta:Player=phash.get(targetid);
			for(var i:int in ta.black){
				var ac:ACard=new ACard();
				ac.setdata(ta.black[i]);
				temp.push(ac);
			}
			bv.showCardDialog(temp,"请选择最多"+(3-count)+"张黑情报烧毁",(3-count),2,targetid,cardseleted);
		}
		public function cardseleted(arr:Array):void{
			var param:Object={type:1,tid:GL.tableId,ctype:1,target:targetid,cards:arr,oid:bm.oid};
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
			count+=arr.length;
		}
		
		public function passSelect(evt:MouseEvent):void{
			if(evt.currentTarget.name=="yesbtn"){
				selectRole();
			}else{
				SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,{type:1,tid:GL.tableId,ctype:1,oid:bm.oid});
			}
		}
	}
}