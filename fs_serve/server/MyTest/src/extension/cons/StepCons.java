package extension.cons;

public class StepCons {
	/**
	 * 全体发牌
	 * **/
	final public static int DealingAll=1;
	/**
	 * 回合开始
	 * **/
	final public static int StepBegin=3;
	/**
	 * 单个发牌
	 * **/
	final public static int DealingSingle=2;
	/**
	 * 功能牌和技能使用1（等待出牌）
	 * **/
	final public static int CardUse1=4;
	/**
	 * 功能牌和技能使用2（等待出牌）
	 * **/
	final public static int CardUse2=5;
	/**
	 * 功能牌发动
	 * **/
	final public static int CardLaunch=6;
	/**
	 * 功能牌发动等待
	 * **/
	final public static int CardWait=7;
	/**
	 *技能发动
	 * **/
	final public static int SkillLaunch=8;
	/**
	 * 技能发动等待
	 * **/
	final public static int SkillWait=9;
	/**
	 *等待传递情报
	 * **/
	final public static int InfoWait=10;
	/**
	 * 传递情报中
	 * **/
	final public static int InfoSend=11;
	/**
	 * 情报到达
	 * **/
	final public static int InfoArrive=12;
	/**
	 * 情报接收
	 * **/
	final public static int InfoReceive=13;
	
	/**
	 * 回合结束
	 * **/
	final public static int StepEnd=14;
	/**
	 * 玩家死亡阶段
	 * **/
	final public static int Death=15;
	/**
	 * 死亡结算阶段
	 * **/
	final public static int DeathSettlement=16;
	/**
	 * 功能牌结算阶段
	 * **/
	final public static int CardSettlement=17;
	/**
	 * 功能牌结算阶段
	 * **/
	final public static int CardSettlementEnd=18;
	/**
	 * 试探中
	 * **/
	final public static int TestingSuccess=19;
	public static final int StealDragon = 20;
	public static final int Victory = 21;
	public static final int RecieveNowInfo = 22;
	public static final int AfterBurn = 23;
	public static final int BeforeBurn = 24;
	final public static int TestingFaild=25;
	/**
	 * 死亡后 
	 */
	public static final int AfterDead = 26;
	public static final int BeforeDead = 27;
	public static final int LockTarget = 28;
	public static final int AfterDeadTaskCheck = 29;
	/**
	 * 从牌库抽完牌后
	 */
	public static final int AfterDrawFromDeck = 30;
}
