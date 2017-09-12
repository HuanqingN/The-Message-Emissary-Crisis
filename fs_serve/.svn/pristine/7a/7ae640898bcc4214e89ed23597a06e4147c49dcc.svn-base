package
{
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	
	import game.ui.test.PopViewUI;
	
	import views.PopDialog;
	import views.PopView;
	
	public class InfoManager extends Sprite
	{
		public function InfoManager()
		{
			super();
		}
		
		public function show(str:String):void{
			var pv:PopView=new PopView();
			pv.x=(1000-pv.width)/2;
			pv.y=(700-pv.height)/2;
			addChild(pv);
			pv.show(str);
		}
		
		public function showInBattle():void{
			var pd:PopDialog=new PopDialog();
			pd.popupCenter=true;
			pd.show();
		}
		public function clearPop(pv:PopView):void{
			removeChild(pv);
			pv=null;
		}
	}
}