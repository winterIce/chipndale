package winter.Boss
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import winter.Chapter.*;
	import winter.Hero.Chip;
	import Box2D.Dynamics.b2Body;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2FilterData;
	
	
	public class Boss extends Sprite 
	{	
		protected var speedX:uint = 3;
		protected var speedY:uint = 15;
		public var mc:MovieClip;
		public var curState;
		public var body:b2Body;
		public var chapter:ChapterBase;
		private var moveV:b2Vec2;
		private var fd:b2FilterData;
		public var dir:String = "left";  //标记当前方向
		public var bullet:b2Body;
		
		
		public function Boss(chapter:ChapterBase) {
			this.chapter = chapter;
		}
		
	}
	
}