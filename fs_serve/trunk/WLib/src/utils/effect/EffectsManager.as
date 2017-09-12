package utils.effect
{
	
	
	import flash.display.DisplayObject;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	
	
	public class EffectsManager{
		
		public function EffectsManager(){
			
		}
		
		/**
		 * 发光效果 
		 * */
		public static function Glow(mov:DisplayObject,
									color:uint = 0xFF0000, 
									alpha:Number = 1.0, 
									blurX:Number = 6.0, 
									blurY:Number = 6.0, 
									strength:Number = 2,
									quality:int = 1,
									inner:Boolean = false):BitmapFilter{

			var ei:EffectsInfo=new EffectsInfo
			var filter:BitmapFilter = ei.getGlowBitmapFilter(color,alpha,blurX,blurY,strength,quality,inner);
            var myFilters:Array = new Array();
            myFilters.push(filter);
            mov.filters = myFilters;
			return filter;
		}
		
		public static function clearGlow(mov:DisplayObject):void{
			mov.filters=mov.filters.slice(EffectsManager.filterPosition(mov,GlowFilter),0);
		}
		/**
		 * 投影效果 
		 * */
		public static function DropShadow(mov:DisplayObject,
												distance:Number,
												angle:Number,
												color:uint,
												alpha:Number,
												blurX:Number,
												blurY:Number,
												strength:Number,
												quality:int=3):void{
			var dsf:DropShadowFilter=new DropShadowFilter(distance,angle,color,alpha,blurX,blurY,strength,quality);
			mov.filters=[dsf];
		}
		/**
		 * 模糊效果 
		 * */
		public static function Blur(mov:DisplayObject,
									blurX:Number,
									blurY:Number,
									quality:int=3):void{
			var blur:BlurFilter=new BlurFilter(blurX,blurY,quality);
			mov.filters=[blur]
		}
		
		private static function filterPosition(displayObject:DisplayObject, filterClass:Class):int {
			for (var i:uint = 0; i < displayObject.filters.length; i++) {
				if (displayObject.filters[i] is filterClass) {
					return i;
				}
			}
			return -1;
		}

		
		public static function revert(mov:DisplayObject):void{
			mov.filters = null;
		}
		
		/**
		** 斜角效果
		**/
		public static function BeveFilter(mov:DisplayObject,
											distance:Number = 4,
											angleInDegrees:Number = 45,
											highlightColor:Number = 0xFFFFFF,
											highlightAlpha:Number = 1,
											shadowColor:Number    = 0x666666,
											shadowAlpha:Number    = 1,
             								blurX:Number          = 1,
             								blurY:Number          = 1,
             								strength:Number       = 10):void {
             									
           var quality:Number        = BitmapFilterQuality.HIGH;
            var type:String           = BitmapFilterType.INNER;
            var knockout:Boolean      = false;
           var ei:EffectsInfo = new EffectsInfo;
           var filter:BitmapFilter = ei.getBeveFilter(distance,
                                   				angleInDegrees,
                                   				highlightColor,
                                   				highlightAlpha,
                                   				shadowColor,
                                   				shadowAlpha,
                                   				blurX,
                                   				blurY,
                                   				strength);
           var myFilters:Array = new Array();
            myFilters.push(filter);
            mov.filters = myFilters;
            
        }

	}
}