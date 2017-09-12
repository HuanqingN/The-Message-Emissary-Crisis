package util
{
	import flash.display.Shape;
	
	import core.mng.Player;
	
	import views.ACard;

	/**
	 * 
	 *图形类工具包
	 * 
	 */	
	public class GUtil
	{
		private static var levelTable:Array;
		public static function getLevelByExp(exp:Number):String{
			if(!levelTable)initLevelTable();
			
			for (var j:int = 1; j <=100; j++) 
			{
				if(exp<levelTable[j])return (j-1).toString();
			}
			
			return "100";
		}
		private static function initLevelTable():void{
			
				levelTable=[];
				for (var i:int = 1; i <= 100; i++) 
				{
					if(i<=20)
						levelTable[i]=2.5*Math.pow(i,2)-2.5*i;
					else
						levelTable[i]=Math.floor( Math.pow(2.5*Math.pow(i,2)-2.5*i,1.05)-Math.pow(i,2))
				}
		}
		public static function getArrow(dist:Number):Shape{
			var mc:Shape=new Shape();
			mc.graphics.beginFill(0xff0000,1);
			mc.graphics.moveTo(0,0);
			mc.graphics.lineTo(2,0);
			mc.graphics.lineTo(0,-dist);
			mc.graphics.lineTo(-2,0);
			mc.graphics.lineTo(0,0);
			mc.graphics.endFill();
			return mc;
		}
		public static function getHead():Shape{
			var head:Shape=new Shape();
			head.graphics.beginFill(0xff0000,1);
			head.graphics.moveTo(0,0);
			head.graphics.lineTo(5,0);
			head.graphics.lineTo(0,-10);
			head.graphics.lineTo(-5,0);
			head.graphics.lineTo(0,0);
			head.graphics.endFill();
			return head;
		}
		
		private static var sound1:int=0;
		private static var sound4:int=0;
		private static var sound6:int=0;
		private static var sound10:int=0;
		private static var sound13:int=0;
		public static function clearSoundState():void{
			sound1=sound4=sound6=sound10=sound13=0;
		}
		public static function playCardSound(card:ACard, other:Player):void
		{
			if(other.rid==38){
				App.audio.play("assets/sounds/card/dog1.mp3");
				return;
			}
			var index:int=card.id;
			if(index>=13 &&　index<=18)index=13;
			if(index==99)index=13;
			var frontstr:String="assets/sounds/card/"+index+"/";
			switch(index)
			{
				case 1:  
					App.audio.play(frontstr+other.sex+""+sound1+".mp3");
					if(++sound1>1)sound1=1;
					break;
				case 4:  
					App.audio.play(frontstr+other.sex+""+sound4+".mp3");
					if(++sound4>1)sound4=1;
					break;
				case 6:  
					App.audio.play(frontstr+other.sex+""+sound6+".mp3");
					if(++sound6>1)sound6=1;
					break;
				case 10:  
					App.audio.play(frontstr+other.sex+""+sound10+".mp3");
					if(++sound10>1)sound10=1;
					break;
				case 13:  
					App.audio.play(frontstr+other.sex+""+sound13+".mp3");
					if(++sound13>1)sound13=1;
					break;
				 default:{
					 App.audio.play(frontstr+other.sex+".mp3");					 
				 }
			}	
		}
		
		public static function getLevelExp(lv:int):String
		{
			if(!levelTable)initLevelTable();
			return levelTable[lv].toString();
		}
	}
}