package winter.Chapter
{
	import flash.display.Sprite;
	import winter.Box2d.Box2d;
	import flash.events.Event;
	import Box2D.Dynamics.b2World;
	import winter.control.Control;
	import winter.Hero.Chip;
	import winter.Bullet.Bullet;
	
	public class ChapterBase extends Sprite
	{
		public var world:b2World;
		public var timeStep:Number;
		public var iterations:uint;
		public var pixelsPerMeter:Number = 30;
		public var box2d:Box2d;   //chapter的世界
		public var ctrl:Control;  //chapter的控制器
		public var chip:Chip;
		public var curBullet:Bullet;
		public function ChapterBase(ctrl:Control) {
		    this.ctrl  = ctrl;
			initBox2d();
			this.world = box2d.createWorld();
			box2d.makeDebugDraw();
			addEventListener(Event.ENTER_FRAME,box2d.onEnterframe);
		}
		
		public function initBox2d() {
			this.timeStep = 1.0 / 30.0;
			this.iterations = 10;
			this.pixelsPerMeter = 30;
			box2d = new Box2d(this.timeStep,this.iterations,this.pixelsPerMeter);
			addChild(box2d);
		}
		
		public function addBullet() {
			
		}
		
		public function fireBullet(d:String) {
			
		}
	}
	
}