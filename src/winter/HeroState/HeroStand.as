package winter.HeroState
{
	import winter.Hero.Chip;
	public class HeroStand extends HeroState 
	{
		public function HeroStand(chip:Chip) {
			super(chip);
		}
		override public function play() {
			if (this.dir == "left") {
				chip.mc.scaleX = -1;
			}
			else {
				chip.mc.scaleX = 1;
			}
			if (this.lift) {
				chip.mc.gotoAndStop("standlift");
			}
			else{
		        chip.mc.gotoAndStop("stand");
			}
		}
	}
	
}