package core.mng
{
	import flash.utils.Dictionary;
	
	import datas.Cons;
	
	import handlers.HandlerBase;

	public class Assign
	{
		private static var assign:Assign=new Assign();
		public static  function get inst():Assign
		{
			return assign;
		}
		public var handlers:Dictionary=new Dictionary();
		public function register(handname:int,handClass:HandlerBase):void{
			handlers[handname]=handClass;
		}
		
		public function remove(handname:int):void{
			delete handlers[handname];
		}
		public function invoke(params:Object):void
		{
			var hb:HandlerBase=handlers[params.h];
			if(hb){
				hb.excute(params);
			}
		}
	}
}