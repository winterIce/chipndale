package winter.Data
{
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;

	public class GameData extends Sprite
	{
		public static const heroPath:String = "res/chip.swf";
		public static const bossPath:String = "res/boss.swf";
		public static const heroEleArray:Array = ["chipMc", "woodboxMc"];
		public static var heroMcArray:Array=new Array();
		/*
		public function GameData() {
			
		}
		*/
		public static function delDisplayContainer(container:DisplayObjectContainer):void 
		{								
			    var child:DisplayObject;
			   for (var i:int=container.numChildren-1; i>=0; i--) {
			        child=container.getChildAt(0);
			        if (container.getChildAt(0) is DisplayObjectContainer) {
			            delDisplayContainer(DisplayObjectContainer(child));
			        }
					container.removeChildAt(0);
			    }
		}
	}
	
}