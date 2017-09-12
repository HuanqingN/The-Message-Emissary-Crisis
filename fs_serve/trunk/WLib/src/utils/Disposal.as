package utils
{
	public class Disposal
	{
		public static function disposalEnabledFalse(...args):void{
			for(var i:uint=0;i<args.length;i++){				
				args[i].enabled = false;
			}	
		}
		public static function disposalEnabledTrue(...args):void{
			for(var i:uint=0;i<args.length;i++){				
				args[i].enabled = true;
			}	
		}
		
		public static function disposalTabIndex(...args):void{
			for(var i:uint=0;i<args.length;i++){
				args[i].tabEnabled=true;
				args[i].tabIndex = i+1;
			}
		}
		public static function disposalSelectAbleTrue(...args):void{
			for(var i:uint=0;i<args.length;i++){
				args[i].selectable = true;
			}	
		}
		public static function disposalSelectAbleFalse(...args):void{
			for(var i:uint=0;i<args.length;i++){
				args[i].selectable=false;
			}	
		}
	}
}