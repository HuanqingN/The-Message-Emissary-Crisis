package utils.effect
{
	import flash.filters.BevelFilter;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	
	public class EffectsInfo
	{
		private static var dsf:DropShadowFilter;
		public static function getDropShadowFilter():BitmapFilter {
			if(!dsf){
//				 var color:Number = 0x000000;
				 var color:Number = 0xffffff;
	            var angle:Number = 45;
	            var alpha:Number = .8;
	            var blurX:Number = 1;
	            var blurY:Number = 1;
	            var distance:Number = 1;
	            var strength:Number = 1;
	            var inner:Boolean = false;
	            var knockout:Boolean = false;
	            var quality:Number = BitmapFilterQuality.HIGH;
           		 dsf= new DropShadowFilter(distance,
                                        angle,
                                        color,
                                        alpha,
                                        blurX,
                                        blurY,
                                        strength,
                                        quality,
                                        inner,
                                        knockout);
			}
			return dsf;
           
        }

		public function getGlowBitmapFilter(color:uint = 0xFF0000, 
											alpha:Number = 1.0, 
											blurX:Number = 6.0, 
											blurY:Number = 6.0, 
											strength:Number = 2, 
											quality:int = 1, 
											inner:Boolean = false, 
											knockout:Boolean = false):BitmapFilter {
//            var color:Number = 0x33CCFF;
//            var alpha:Number = 0.8;
//            var blurX:Number = 35;
//            var blurY:Number = 35;
//            var strength:Number = 2;
//            var inner:Boolean = false;
//            var knockout:Boolean = false;
//            var quality:Number = BitmapFilterQuality.HIGH;

            return new GlowFilter(color,alpha,blurX, blurY,strength,quality,inner, knockout);
        }
        
        /**
		** 斜角效果
		**/
		public  function getBeveFilter(distance:Number = 4,
											angleInDegrees:Number = 45,
											highlightColor:Number = 0xFFFFFF,
											highlightAlpha:Number = 1,
											shadowColor:Number    = 0x666666,
											shadowAlpha:Number    = 1,
             								blurX:Number          = 1,
             								blurY:Number          = 1,
             								strength:Number       = 10
            	 							):BitmapFilter {
			 var quality:Number        = BitmapFilterQuality.HIGH;
            var type:String           = BitmapFilterType.INNER;
            var knockout:Boolean      = false;
            return new BevelFilter(distance,
                                   angleInDegrees,
                                   highlightColor,
                                   highlightAlpha,
                                   shadowColor,
                                   shadowAlpha,
                                   blurX,
                                   blurY,
                                   strength,
                                   quality,
                                   type,
                                   knockout);
        }
	}
}