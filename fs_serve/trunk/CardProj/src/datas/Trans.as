package datas
{
	public class Trans
	{
		public static  function getStrByIdentity(index:int):String
		{
			switch(index)
			{
				case 0: return "军";
				case 1: return "潜";
				case 2: return "酱";
				case 3: return "?";
			}
			return "";
		}
		public static  function getSkinByIdentity(index:int):String
		{
			switch(index)
			{
				case 0: return "png.custom.btn_identity_junqing";
				case 1: return "png.custom.btn_identity_qianfu";
				case 2: return "png.custom.btn_identity_jiangyou";
				case 3: return "png.custom.btn_identity_unknown";
			}
			return "";
		}
		public static function getStrByColor(index:int):String{
			switch(index)
			{
				case 1: return "red";
				case 2: return "blue";
				case 3: return "yellow";
			}
			return "";
		}
		
		public static function getColorStr(index:int):String{
			switch(index)
			{
				case 1: return "蓝色情报";
				case 2: return "红色情报";
				case 3: return "黑色情报";
				case 4: return "红黑情报";
				case 5: return "蓝黑情报";
			}
			return "";
		}
		public static function getIdenStr(index:int):String{
			switch(index)
			{
				case 0: return "军情";
				case 1: return "潜伏";
				case 2: return "酱油";
				case 3: return "未知";
			}
			return "";
		}
		public static function getColor(index:int):uint{
			switch(index)
			{
				case 1: return 0x0000ff;
				case 2: return 0xff0000;
				case 3: return 0xaaaaaa;
				case 4: return 0xaaaaaa;
				case 5: return 0xaaaaaa;
			}
			return 0;
		}
		public static function getIdenColor(index:int):uint{
			switch(index)
			{
				case 1: return 0x0000ff;
				case 2: return 0xff0000;
				case 3: return 0x00ff00;
			}
			return 0;
		}
		public static function getSkillColor(index:int):uint{
			switch(index)
			{
				case 1: return 0xff0000;
				case 2: return 0x0000ff;
				case 3: return 0xffff00;
			}
			return 0;
		}
	}
}