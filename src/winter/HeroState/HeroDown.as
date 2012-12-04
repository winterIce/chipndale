package winter.HeroState
{
	import winter.Hero.Chip;
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
			chip.mc.gotoAndPlay("down");
			//lift时下蹲呢?
		}
	}
	
}