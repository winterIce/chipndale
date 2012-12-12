package winter.Box2d
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2FilterData;
	import Box2D.Dynamics.b2World;
	import flash.events.Event;
	import flash.display.Sprite;
	
	public class Box2d extends Sprite
	{
		public var world:b2World;
		public var timeStep:Number;
		public var iterations:uint;
		public var pixelsPerMeter:Number = 30;
		private var fd:b2FilterData;
		
		public function Box2d(timeStep,iterations,pixelsPerMeter) {
			this.timeStep = timeStep;
			this.iterations = iterations;
			this.pixelsPerMeter = pixelsPerMeter;
		}
		
		public function createWorld() {
			var gravity:b2Vec2 = new b2Vec2(0.0,19.8);
			var doSleep:Boolean = true;
			this.world = new b2World(gravity,doSleep);
			this.world.SetWarmStarting(true);
			return world;
		}
		
		public function makeDebugDraw():void{
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			var debugSprite:Sprite = new Sprite();
			addChild(debugSprite);
			debugDraw.SetSprite(debugSprite);
			debugDraw.SetDrawScale(30.0);
			debugDraw.SetFillAlpha(0.5);
			debugDraw.SetLineThickness(1.0);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit);
			this.world.SetDebugDraw(debugDraw);
		}
		
		
		public function createBox(x:Number,y:Number,hx:Number,hy:Number,isDynamic:Boolean,userData:String){
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(x / pixelsPerMeter, y / pixelsPerMeter);
			if(isDynamic){
				bodyDef.type = b2Body.b2_dynamicBody;
			}
			var box:b2PolygonShape = new b2PolygonShape();
			box.SetAsBox(hx/pixelsPerMeter,hy/pixelsPerMeter);
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = box;
			var body:b2Body = this.world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			body.SetUserData(userData);
			fd = new b2FilterData();
			fd.categoryBits = 2;  //2,4,6
			body.GetFixtureList().SetFilterData(fd);
			
			return body;
		}
		
		public function onEnterframe(e:Event):void{
			this.world.Step(timeStep,iterations,iterations);
			this.world.ClearForces();
			this.world.DrawDebugData();
		}
		
	}
	
}