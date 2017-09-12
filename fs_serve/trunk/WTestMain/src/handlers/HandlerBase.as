package handlers
{
	public class HandlerBase
	{
		public var funcArr:Array;
		
		public function HandlerBase():void{
			initFunArr();
		}
		
		protected function initFunArr():void
		{
			
		}
		public function excute(param:Object):void{
			funcArr[param.f].call(null,param);
		}
	}
}