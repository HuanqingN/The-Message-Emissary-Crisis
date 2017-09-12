package datas
{
	public class StrCons
	{
		public function getNameByStep(index:int):String{
			switch(index)
			{
				case 1: return "全体发牌";
				case 3: return "开始阶段";
				case 2: return "抽牌阶段";
				case 4: return "出牌1阶段";
				case 5: return "出牌2阶段";
				case 11: return "传情报阶段";
				case 12: return "情报到达阶段";
				case 13: return "情报接收阶段";
				case 14: return "回合结束阶段";
			}
			return "";
		}
	}
}