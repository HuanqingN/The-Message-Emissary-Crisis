package datas
{
	import it.gotoandplay.smartfoxserver.data.Room;
	
	import net.singuerinc.media.audio.Audio;

	public class Cons
	{
		public static const ZONE:String="CardGame";
		public static const handler:HandlerCons=new HandlerCons();
		public static var room:RoomCons=new RoomCons();
		public static var step:StepCons=new StepCons();
		public static var module:ModuleCons=new ModuleCons();
		public static var extension:ExtensionCons=new ExtensionCons();
		public static var cmd:CMDCons=new CMDCons();
		public static var err:ERRCons=new ERRCons();
		public static var BWID:int=1000; //战场区尺寸
		public static var BHEI:int=600;
		public static var CWID:int=87;//卡牌尺寸
		public static var CHEI:int=121;
		public static var audio:AudioCons=new AudioCons();
		public static var str:StrCons=new StrCons();
	}
}