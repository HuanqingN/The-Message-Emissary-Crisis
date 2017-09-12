package skills
{
	import com.greensock.TweenMax;
	
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.SkillVO;
	import datas.TargetVO;
	
	import morn.core.components.Clip;
	
	import utils.ArrayUtil;
	import utils.HashMap;
	import utils.Rand;
	import utils.effect.EffectsManager;

	/**亮剑**/
	public class Skill35 extends Skill
	{
		
		override public function launch():void
		{
			var arr:Array=phash.values();
			targets=[];
			for each(var i:Player in  arr){
				if(i.uid!=GL.id && i.isDead==false){
					targets.push(i.view);
				}
				if(i.uid==GL.id){
					bv.showInfo("请选择单个或多个目标并点击确定发动");
					bv.showSelectTarget("请选择完目标点击确定发动",onSelected);
				}
			}
			this.showTarget();
		}
		public function onSelected(str:String):void{
			var temp:Array=[];
			var param:Object={sponsor:GL.id,tid:GL.tableId,sid:id,ctype:1,oid:bm.oid};
			if(dict && dict.size()>0){
					var keys:Array=dict.keys();
					for each(var o:Object in keys){
						temp.push(o.uid);
					}
					param.targets=temp;	
			}else{
					param.targets=null;	
			}
			SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnSkillLaunch,param);
			clearState();
		}
		override public function play(tvo1:SkillVO,obj:Object):void
		{
			super.play(tvo1,obj);
			playNormalAni();
			App.audio.play("assets/sounds/skill/"+rid+"/"+id+""+Rand.range(1,2)+".mp3");
			if(tvo.targets)
			TweenMax.delayedCall(1,delayedFun);
		}
		
		override public function delayedFun():void
		{
			for(var i:int in tvo.targets){
				phash.get(tvo.targets[i]).isLock=true;
			}
		}
		
		
		private var dict:HashMap;
		private var nums:Array;
		override protected function onTargetSelect(evt:MouseEvent):void
		{
			if(!dict)dict=new HashMap();
			var obj:Object=evt.currentTarget;
			if(dict.get(obj)){
				bv.removeChild(dict.get(obj));
				ArrayUtil.removeItem(nums,dict.get(obj));
				dict.get(obj).dispose();
				dict.remove(obj);
				flushClips();
			}else{
				if(!nums)nums=[];
				var clip:Clip=new Clip();
				clip.autoPlay=false;
				clip.skin="png.comp.clip_num";
				clip.clipX=10;
				clip.x=obj.x+obj.width/2-clip.width;
				clip.y=obj.y+obj.height/2-clip.height;
				bv.addChild(clip);		
				nums.push(clip);
				dict.put(obj,clip);
				flushClips();
			}
		}
		private function flushClips():void{
			var index:int=0;
			if(nums){
				for each(var o:Clip in nums){
					o.index=index++;
				}
			}
		}
		override public function clearState():void
		{
			super.clearState();
			nums=null;
			if(dict){
				var arr:Array=dict.values();
				for(var i in arr){
					bv.removeChild(arr[i] as Clip);	
				}
				dict.clear();
				dict=null;
			}
		}
	}
}