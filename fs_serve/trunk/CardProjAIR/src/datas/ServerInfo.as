package datas
{
	public class ServerInfo
	{
		public var IP:String;
		public var PORT:int;
		private static var serverInfo:ServerInfo;
		
		public static function get inst():ServerInfo{
			return serverInfo;
		}
		public static function initiaByXml(xml:XML):void
		{
			if(!serverInfo)serverInfo=new ServerInfo();			
			serverInfo.IP=xml.IP;
			serverInfo.PORT=int(xml.PORT);
		}
	}
}