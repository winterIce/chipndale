package winter.Chapter
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Common.Math.b2Vec2;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import winter.Bullet.Bullet;
	import winter.control.Control;
	import winter.Data.GameData;
	import flash.events.Event;
	import winter.Bullet.Bullet;
	import winter.Hero.Chip;
	import winter.Boss.Boss7;
	
	public class Chapter7 extends ChapterBase
	{
		private var bulletArr:Array;
		private var ground:b2Body;
		public var loftArr:Array;
		public function Chapter7(ctrl:Control) {
			super(ctrl);
			createBg();
			renderBg();
			chip = new Chip(this);
			addChild(chip);
			addEventListener(Event.ENTER_FRAME, onenterframe);
			boss = new Boss7(this);
			addChild(boss);
		}
		
		public function createBg() {
			ground = box2d.createBox(400, 585, 400, 15, false, "ground");
			loftArr = new Array();
			loftArr.push(box2d.createBox(100, 450, 100, 5, false, "loft0"));
			loftArr.push(box2d.createBox(100, 320, 100, 5, false, "loft1"));
			loftArr.push(box2d.createBox(100, 190, 100, 5, false, "loft2"));
			loftArr.push(box2d.createBox(700, 450, 100, 5, false, "loft3"));
			loftArr.push(box2d.createBox(700, 320, 100, 5, false, "loft4"));
			loftArr.push(box2d.createBox(700, 190, 100, 5, false, "loft5"));
			loftArr.push(box2d.createBox(0, 285, 5, 285, false, "wall"));
			loftArr.push(box2d.createBox(800, 285, 5, 285, false, "wall"));
			
			bulletArr = new Array();
			
			//bulletArr.push(box2d.createBox(300, 550, 20, 20, false, "woodbox"));
			//bulletArr.push(box2d.createBox(500, 550, 20, 20, false, "woodbox"));
			bulletArr.push(box2d.createBox(160, 425, 20, 20, false, "woodbox"));
			bulletArr.push(box2d.createBox(160, 295, 20, 20, false, "woodbox"));
			bulletArr.push(box2d.createBox(160, 165, 20, 20, false, "woodbox"));
			bulletArr.push(box2d.createBox(640, 425, 20, 20, false, "woodbox"));
			bulletArr.push(box2d.createBox(640, 295, 20, 20, false, "woodbox"));
			bulletArr.push(box2d.createBox(640, 165, 20, 20, false, "woodbox"));
		}
		
		private function renderBg() {
			for (var i:uint = 0; i < bulletArr.length; i++ ) {
				bulletArr[i].SetUserData(new GameData.heroMcArray[1]() as MovieClip);
				addChild(bulletArr[i].GetUserData());
				bulletArr[i].GetUserData().x = bulletArr[i].GetPosition().x*pixelsPerMeter;
			    bulletArr[i].GetUserData().y = bulletArr[i].GetPosition().y*pixelsPerMeter;
			    bulletArr[i].GetUserData().rotation = bulletArr[i].GetAngle() * 180 / Math.PI;
			}
		}
		
		override public function addBullet() {
			for (var i = 0; i < bulletArr.length; i++ ) {
				if (chip.bullet == bulletArr[i]) {
				    world.DestroyBody(bulletArr[i]);
					removeChild(bulletArr[i].GetUserData());
					bulletArr.splice(i, 1);
				}
			}
			curBullet = new Bullet(this);
			addChild(curBullet);
			curBullet.lift();
		}
		
		override public function fireBullet(d:String) {
			curBullet.dir = d;
			curBullet.fire();
		}
		
		public function onenterframe(evt:Event) {
			
		}
		
	}
	
}