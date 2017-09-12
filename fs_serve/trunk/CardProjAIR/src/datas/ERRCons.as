package datas
{
	public class ERRCons
	{
		private var errString:Array;
		public function ERRCons(){
			errString=[
				"",
				"房间密码错误!",  //1
				"你的胜率不符合房间规定!", //2
				"你的风币不符合房间规定!",//3
				"不能用重复IP进入此房间!",//4
				"你的等级不符合房间注金规定!"//5
			]	
		}
		
		public function getErrorString(type:int):String{
			return errString[type];
		}
	}
}