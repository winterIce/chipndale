package  winter.HeroState
{
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import winter.Hero.Chip;
	
	public class HeroState extends Sprite 
	{
		public var lift:Boolean = false;  
		public var dir:String = "right";    //left,right
		public var transition:uint = 0;//1---noLift->lift ; 2---lift->noLift
		public var startTime:uint = 0;
		public var chip:Chip;
		
		public function HeroState(chip:Chip) {
			this.chip = chip;
		}
		
		public function play() {
			
		}
	}
	
}