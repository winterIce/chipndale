package winter.Chapter
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Common.Math.b2Vec2;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import winter.control.Control;
	import winter.Hero.Chip;
	import winter.Data.GameData;
	import flash.events.Event;
	
	public class Chapter7 extends ChapterBase
	{
		private var chip:Chip;
		private var bulletArr:Array;
		private var ground:b2Body;
		private var loftArr:Array;
		public function Chapter7(ctrl:Control) {
			super(ctrl);
			createBg();
			renderBg();
			chip = new Chip(this);
			addChild(chip);
			addEventListener(Event.ENTER_FRAME, onenterframe);
			/*
			new Boss();
			*/
		}
		
		public function createBg() {
			ground = box2d.createBox(400, 585, 400, 15, false, "ground");
			loftArr = new Array();
			loftArr.push(box2d.createBox(100, 450, 100, 5, false, "ground"));
			loftArr.push(box2d.createBox(100, 320, 100, 5, false, "ground"));
			loftArr.push(box2d.createBox(100, 190, 100, 5, false, "ground"));
			loftArr.push(box2d.createBox(700, 450, 100, 5, false, "ground"));
			loftArr.push(box2d.createBox(700, 320, 100, 5, false, "ground"));
			loftArr.push(box2d.createBox(700, 190, 100, 5, false, "ground"));
			loftArr.push(box2d.createBox(0, 285, 5, 285, false, "ground"));
			loftArr.push(box2d.createBox(800, 285, 5, 285, false, "ground"));
			bulletArr = new Array();
			bulletArr.push(box2d.createBox(300, 550, 20, 20, false, "woodbox"));
			bulletArr.push(box2d.createBox(500, 550, 20, 20, false, "woodbox"));
			bulletArr.push(box2d.createBox(100, 425, 20, 20, false, "woodbox"));
			bulletArr.push(box2d.createBox(100, 295, 20, 20, false, "woodbox"));
			bulletArr.push(box2d.createBox(100, 165, 20, 20, false, "woodbox"));
			bulletArr.push(box2d.createBox(700, 425, 20, 20, false, "woodbox"));
			bulletArr.push(box2d.createBox(700, 295, 20, 20, false, "woodbox"));
			bulletArr.push(box2d.createBox(700, 165, 20, 20, false, "woodbox"));
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
		
		public function onenterframe(evt:Event) {
			if (chip.bulletState=="lift") {
				chip.bullet.GetUserData().x = chip.body.GetPosition().x*pixelsPerMeter;
			    chip.bullet.GetUserData().y = chip.body.GetPosition().y*pixelsPerMeter-45;
			    chip.bullet.GetUserData().rotation = chip.body.GetAngle() * 180 / Math.PI;
			}
			else if (chip.bulletState == "fire") {
				if (!(chip.bullet.GetPosition().x * pixelsPerMeter >= 0-40 && chip.bullet.GetPosition().x * pixelsPerMeter <= 800+40 && chip.bullet.GetPosition().y * pixelsPerMeter >= 0-40 && chip.bullet.GetPosition().y * pixelsPerMeter <= 600+40)) {
					//removeChild(chip.bullet.GetUserData());//一定要抽象出子弹类啊
					world.DestroyBody(chip.bullet);
					return ;
				}
				
				chip.bullet.ApplyForce(new b2Vec2(0, -chip.bullet.GetMass() * 19.8), chip.bullet.GetWorldCenter());
				if(chip.bulletDir=="right"){
			        chip.bullet.SetLinearVelocity(new b2Vec2(15, 0));
			    }
				else {
					chip.bullet.SetLinearVelocity(new b2Vec2(-15, 0));
				}
				chip.bullet.GetUserData().x = chip.bullet.GetPosition().x*pixelsPerMeter;
			    chip.bullet.GetUserData().y = chip.bullet.GetPosition().y*pixelsPerMeter;
			    chip.bullet.GetUserData().rotation = chip.bullet.GetAngle() * 180 / Math.PI;
			}
			
			
		}
		
	}
	
}