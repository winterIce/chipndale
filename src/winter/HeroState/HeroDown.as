package winter.HeroState
{
	import winter.Hero.Chip;
	import winter.Chapter.*;
	public class HeroDown extends HeroState 
	{
		public function HeroDown(chip:Chip) {
			super(chip);
		}
		override public function play() {
			if (this.dir == "left") {
				chip.mc.scaleX = -1;
			}
			else {
				chip.mc.scaleX = 1;
			}
			if(!this.lift){
			    chip.mc.gotoAndPlay("down");
			}
			else {
				chip.mc.gotoAndStop("downlift");
			}
		}
	}
	
}