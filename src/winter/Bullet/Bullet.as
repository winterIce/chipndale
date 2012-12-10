package winter.Bullet
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2FilterData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import winter.Chapter.*;
	import winter.Box2d.Box2d;
	import winter.Data.GameData;
	
	public class Bullet extends Sprite 
	{
		private var speed:uint=15;
		private var _state:String;
		private var _dir:String;
		private var chapter:ChapterBase;
		private var mc:MovieClip;
		private var pixelsPerMeter;
		private var body:b2Body;
		private var fd:b2FilterData;
		
		public function Bullet(chapter:ChapterBase) {
			this.chapter = chapter;
			this.pixelsPerMeter = chapter.pixelsPerMeter;
			mc = new GameData.heroMcArray[1]() as MovieClip;
			addChild(mc);
			body = chapter.box2d.createBox(-20, -20, 20, 20, false,"bullet");
			body.SetUserData(mc);
			
			addEventListener(Event.ENTER_FRAME, onenterframe);
		}
		
		public function lift() {
			_state = "lift";
		}
		public function fire() {
			_state = "fire";
			body.SetType(b2Body.b2_dynamicBody);//一定要设为动态型
			fd = new b2FilterData();
			fd.maskBits = 4;
			fd.categoryBits = 6;
			body.GetFixtureList().SetFilterData(fd);//穿透静态物
			body.SetPosition(new b2Vec2(chapter.chip.body.GetPosition().x, chapter.chip.body.GetPosition().y - 1.5));
		}
		
		public function set dir(d:String) {
			_dir = d;
		}
		
		private function onenterframe(evt:Event) {
			if (_state == "lift") {
				mc.x = chapter.chip.body.GetPosition().x*pixelsPerMeter;
			    mc.y = chapter.chip.body.GetPosition().y*pixelsPerMeter-45;
			    mc.rotation = chapter.chip.body.GetAngle() * 180 / Math.PI;
			}
			else if (_state == "fire") {
				if (!(mc.x >= -40 && mc.x <= 800 + 40 && mc.y >= -40 && mc.y <= 600 + 40)) {
					this.removeEventListener(Event.ENTER_FRAME, onenterframe);
					chapter.world.DestroyBody(body);
					this.removeChild(mc);
					this.parent.removeChild(this);
					return ;
				}
				
				body.ApplyForce(new b2Vec2(0, -body.GetMass() * 19.8), body.GetWorldCenter());
				if(_dir=="right"){
			        body.SetLinearVelocity(new b2Vec2(speed, 0));
			    }
				else {
					body.SetLinearVelocity(new b2Vec2(-speed, 0));
				}
				mc.x = body.GetPosition().x*pixelsPerMeter;
			    mc.y = body.GetPosition().y*pixelsPerMeter;
			    mc.rotation = body.GetAngle() * 180 / Math.PI;
			}
		}
	}
	
}