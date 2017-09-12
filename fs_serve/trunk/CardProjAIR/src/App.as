/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import manage.AudioManager;
	import manage.EffectManager;
	import manage.KeyBoardManager;
	
	import morn.core.components.View;
	import morn.core.handlers.Handler;
	import morn.core.managers.AssetManager;
	import morn.core.managers.DialogManager;
	import morn.core.managers.DragManager;
	import morn.core.managers.LangManager;
	import morn.core.managers.LoaderManager;
	import morn.core.managers.LogManager;
	import morn.core.managers.MassLoaderManager;
	import morn.core.managers.RenderManager;
	import morn.core.managers.TimerManager;
	import morn.core.managers.TipManager;
	
	import views.TipView;
	
	/**全局引用入口*/
	public class App {
		/**全局stage引用*/
		public static var stage:Stage;
		public static var main:Sprite;
		/**资源管理器*/
		public static var asset:AssetManager = new AssetManager();
		/**加载管理器*/
		public static var loader:LoaderManager = new LoaderManager();
		/**时钟管理器*/
		public static var timer:TimerManager = new TimerManager();
		/**渲染管理器*/
		public static var render:RenderManager = new RenderManager();
		/**对话框管理器*/
		public static var dialog:DialogManager = new DialogManager();
		public static var scene:Sprite= new Sprite();
		/**日志管理器*/
		public static var log:LogManager = new LogManager();
		/**日志管理器*/
		public static var info:InfoManager = new InfoManager();
		/**字体管理器*/
//		public static var font:FM= new FM();
		/**提示管理器*/
		public static var tip:TipManager = new TipManager();
		/**拖动管理器*/
		public static var drag:DragManager = new DragManager();
		/**语言管理器*/
		public static var lang:LangManager = new LangManager();
		/**声音管理器*/
		public static var audio:AudioManager = new AudioManager();
		/**键盘管理器*/
		public static var keyboard:KeyBoardManager = new KeyBoardManager();
		/**多线程加载管理器*/
		public static var mloader:MassLoaderManager = new MassLoaderManager();
		/**动画效果管理器*/
		public static var effect:EffectManager=new EffectManager();
		
		public static var tipview:TipView;
		public static function init(main:Sprite):void {
			main=main;
			stage = main.stage;
//			stage = CardProj.stag;
			stage.frameRate = Config.GAME_FPS;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.stageFocusRect = false;
			stage.tabChildren = false;
//			Security.allowDomain("*");
//			Security.loadPolicyFile("xmlsocket://127.0.0.1:5000");
			//覆盖配置
			var gameVars:Object = stage.loaderInfo.parameters;
			if (gameVars != null) {
				for (var s:String in gameVars) {
					if (Config[s] != null) {
						Config[s] = gameVars[s];
					}
				}
			}
			stage.addChild(scene);
			stage.addChild(dialog);
			stage.addChild(tip);
			stage.addChild(log);
			stage.addChild(info);
			
			//如果UI视图是加载模式，则进行整体加载
			if (Boolean(Config.uiPath)) {
				App.loader.loadDB(Config.uiPath, new Handler(onUIloadComplete));
			}
		}
		
		private static function onUIloadComplete(content:*):void {
			View.xmlMap = content;
		}
		
		/**获得资源路径(此处可以加上资源版本控制)*/
		public static function getResPath(url:String):String {
			return /^http:\/\//g.test(url) ? url : Config.resPath + url;
		}
	}
}