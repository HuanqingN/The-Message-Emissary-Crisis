package
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	
	import core.mng.SFS;
	
	import datas.ServerInfo;
	
	import manage.FM;
	
	import morn.core.handlers.Handler;
	
	import org.hamcrest.collection.array;
	
	import views.ACard;
	import views.RoleArea;
	import views.TipView;

	public class Test1 extends Sprite
	{
		public function Test1()
		{
//			new FM();
//			var arr:Array=["21","3","35","76","256"];
//			arr.sort(Array.NUMERIC|Array.DESCENDING);
//			trace(arr);
			stage.scaleMode=StageScaleMode.NO_SCALE;
			App.init(this);
			App.loader.loadAssets(["assets/comp.swf","assets/custom.swf"], new Handler(loadComplete), new Handler(loadProgress));
		}
		private function loadProgress(value:Number):void {
		}
		
			var r:RoleArea;
		private function loadComplete():void {
			var role:RoleArea=new RoleArea();
			role.pname.embedFonts=true;
			role.pname.text="税务局长";
//			role.pname.text="礼服蒙面人";
			role.pname.font="Microsoft YaHei Bold";
			role.rname.text="我去看了技术的法律j";
			addChild(role);
//			r=new RoleArea();
//			addChild(r);
//			r.addEventListener(MouseEvent.CLICK,aaa);
//			r.showTime(10000);
		}
		public function aaa(evt:MouseEvent):void{
			r.clearTime();
		}
	}
}