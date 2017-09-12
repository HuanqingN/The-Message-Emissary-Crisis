package utils
{
	/**
	 * 
	 * 字符串处理类
	 * 
	 * */
	public class StringUtils
	{
		public function StringUtils()
		{
		}
		
		/**
		 * 
		 * 替换字符（所有）
		 * 
		 * @param str 要替换的字符串
		 * @param reg 要替换的字符正则表达式
		 * @param repStr 替换字符
		 * 
		 * */
		public static function replaceAllstr(str : String,reg : RegExp,repStr : String) : String
		{
			return str.replace(reg,repStr);
		}
		public static function getColorString(str : String,color:Object) : String{
			var c:String;
			if(color is String)c=color.toString();
			if(color is int)c=uint(color).toString(16);
			return "<font color='#"+c+"'>"+str+"</font>";
		}
//		<u><a href='event:fdgdfg'>aaaaa</a></u>
		public static function getLinkString(str:String,color:Object,eventName:String,underLine:Boolean=false):String{
			var c:String;
			var temp:String="";
			if(color is String)c=color.toString();
			if(color is int)c=uint(color).toString(16);
			temp="<a href='event:"+eventName+"'>"+str+"</a>";
			if(underLine){
				temp="<u>"+temp+"</u>";
			}
			temp="<font color='#"+c+"'>"+temp+"</font>";
			return temp;
		}
		

	}
}