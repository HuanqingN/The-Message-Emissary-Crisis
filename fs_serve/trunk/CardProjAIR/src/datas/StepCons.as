package datas
{
	public class StepCons
	{
		/**
		 * 全体发牌
		 * **/
		public var DealingAll:int = 1;
		/**
		 * 回合开始
		 * **/
		public var StepBegin:int = 3;
		/**
		 * 单个发牌
		 * **/
		public var DealingSingle:int = 2;
		/**
		 * 功能牌和技能使用1（等待出牌）
		 * **/
		public var CardUse1:int = 4;
		/**
		 * 功能牌和技能使用2（等待出牌）
		 * **/
		public var CardUse2:int = 5;
		/**
		 * 功能牌发动
		 * **/
		public var CardLaunch:int = 6;
		/**
		 * 功能牌发动等待
		 * **/
		public var CardWait:int = 7;
		/**
		 *技能发动
		 * **/
		public var SkillLaunch:int = 8;
		/**
		 * 技能发动等待
		 * **/
		public var SkillWait:int = 9;
		/**
		 *等待传递情报
		 * **/
		public var InfoWait:int = 10;
		/**
		 * 传递情报中
		 * **/
		public var InfoSend:int = 11;
		/**
		 * 情报到达
		 * **/
		public var InfoArrive:int = 12;
		/**
		 * 情报接收
		 * **/
		public var InfoReceive:int = 13;
		
		/**
		 * 回合结束
		 * **/
		public var StepEnd:int = 14;
		/**
		 * 玩家死亡阶段
		 * **/
		public var Death:int = 15;
		/**
		 * 死亡结算阶段
		 * **/
		public var DeathSettlement:int = 16;
		/**
		 * 功能牌结算阶段
		 * **/
		public var CardSettlement:int = 17;
	}
}