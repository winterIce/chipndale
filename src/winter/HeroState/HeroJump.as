package winter.HeroState
{
	import winter.Hero.Chip;
	public class HeroJump extends HeroState 
	{
		public function HeroJump(chip:Chip) {
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
				chip.mc.gotoAndStop("jumplift");
			}
			else{
			    chip.mc.gotoAndPlay("jump");
			}
		}
	}
	
}