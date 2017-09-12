package utils
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	/**
	 * 外部url跳转
	 * 
	 * */
	public class GlobalUtil
	{
		private static var delHtmlreg:RegExp = new RegExp("\<\/?[^\<\>]+\>","gmi");
		public function GlobalUtil()
		{
		}
		public static function getURL(url:String,window:String = "_self"):void
		{
			var request:URLRequest = new URLRequest(url);
			navigateToURL(request,window);
		}
		
		/**
		 *  
		 * @param str  
		 * 
		 * @param length
		 * 
		 * @param type
		 * 
		 * @return 
		 * 
		 */		 
		public static function addBlank(str:String,maxlength:int,type:String="right"):String
		{
			
			var len:int = getStringLength(str);
			var blanks:int = maxlength - len;
			var blank:String = "";
			if(len < maxlength)
			{
				for(var i:int=0;i< blanks;i++)
				{
					blank += "&nbsp;";
				}
				if(type == "left")
				{
					str = blank + str;
				}
				else
				{
					str = str + blank;
				}
			}
			return str;
		}
		
		public static function getStringLength(str:String):int
		{
			var len:int = str.length;
			var mlen:int = 0;
			for(var i:int=0;i<len;i++)
			{
				var n:Number = str.charCodeAt(i);
				if(n > 255||n<0)
				{
					mlen += 2;
				}else
				{
					mlen += 1;
				}
			}
			return mlen;
		}
		
		public static function addBR(str:String,num:int=12):String
		{
			var tempStr:String = '';
			var len:int = Math.ceil(str.length/num);
			for(var i:int=0;i<len;i++)
			{
				tempStr += str.substr(i*num,num)+"<br/>";
			}
			return tempStr;
		}
		
		public static function removeHtml(str:String):String
		{
			if(str)
			{
				return str.replace(delHtmlreg,"");
			}
			return "";
		}
	}
}