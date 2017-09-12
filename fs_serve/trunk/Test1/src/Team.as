package
{
	import flash.display.Sprite;
	import flash.geom.Point;

	public class Team
	{
		public var heros:Array;
		public var firstone:Hero;
		public var scene:Sprite;
		
		public function Team(sc:Sprite)
		{
			scene=sc;
			heros=[];
		}
		public function init():void{
			for (var i:int = 0; i < 4; i++) 
			{
				var hero:Hero=new Hero();
				scene.addChild(hero);
				add(hero);
//				hero.x=300;
//				hero.y=200;
			}
			firstone=heros[0];
			layer();
		}
		public function add(hero:Hero):void{
			heros.push(hero);
		}
		public var initPoint:Point=new Point(300,200);
		public function layer():void{
			for (var i:int = 0; i < 4; i++) 
			{
				heros[i].x=initPoint.x-103*i;
				heros[i].y=initPoint.y;
			}
			
		}
		
		public function setFirst(hero:Hero):void{
			firstone=hero;
		}
		private var running:Boolean=false;		
		public function run(isRight:Boolean):void
		{
			if(!running){
				for (var i:int = 0; i < 4; i++) 
				{
					heros[i].turnOver(isRight);
				}
				running=true;
			}
		}
		
		public function stopRun():void{
			if(running){
				for (var i:int = 0; i < 4; i++) 
				{
					heros[i].stopRun();
				}
				running=false;
			}
		}
	}
}