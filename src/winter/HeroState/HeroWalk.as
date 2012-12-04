package winter.HeroState
{
	
	import winter.Hero.Chip;
	public class HeroWalk extends HeroState 
	{
		public function HeroWalk(chip:Chip) {
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
				chip.mc.gotoAndPlay("walklift");
			}
			else{
			    chip.mc.gotoAndPlay("walk");
			}
		}
	}
}