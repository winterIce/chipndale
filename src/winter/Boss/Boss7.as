package winter.Boss
{
	import Box2D.Dynamics.b2FilterData;
	import flash.display.Sprite;
	import flash.events.Event;
	import winter.Chapter.*;
	import winter.Data.GameData;
	import flash.display.MovieClip;
	import flash.utils.getTimer;
	
	public class Boss7 extends Boss 
	{
		private var actionArr = [
		                        ["down", "attack"],
								["up", "down", "attack"],
								["up", "down", "attack"],
								["up", "walk", "attack"],
								["walk", "up", "attack"],
								["down", "up", "attack"],
								["down", "up", "attack"],
								["down","attack"]
		                        ];
		
		private var curState:String;
		private var curDir:String;
		private var curPositionNum:uint = 4;
		private var targetPositionNum:uint;
		private var fd:b2FilterData;
		private var now:uint=0;
		
		public function Boss7(chapter:ChapterBase) {
			super(chapter);
		    mc = new GameData.heroMcArray[2]() as MovieClip;
			addChild(mc);
			body = chapter.box2d.createBox(550, 40, 40, 53, true,"boss7");
			body.SetUserData(mc);
			mc.gotoAndStop("stand");
			addEventListener(Event.ENTER_FRAME, onenterframe);
		}
		
		public function onenterframe(evt:Event) {
			if (curState == "walk") {
				if (curDir == "left") {
				    body.SetAwake(true);
				    body.SetLinearVelocity(new b2Vec2(-this.speedX,body.GetLinearVelocity().y));
				}
				else {
					body.SetAwake(true);
				    body.SetLinearVelocity(new b2Vec2(this.speedX,body.GetLinearVelocity().y));
				}
			}
			mc.x = body.GetPosition().x * chapter.pixelsPerMeter;
			mc.y = body.GetPosition().y * chapter.pixelsPerMeter;
			setFd();
			
			if (isArrive() && now && getTimer() - now > 5000) {
				selectAction();
				now = 0;
			}
		}
		
		
		private function isArrive() {
			var f:Boolean = false;
			switch (targetPositionNum) {
				case 0:
				    if(mc.x<101&&mc.y<=132){
				        f = true;
						curDir = "right";
						mc.scaleX = -1;
						mc.gotoAndStop("stand");
					}
				    break;
				case 1:
				    if (mc.x < 101 && mc.y <= 262 && mc.y >= 260) {
						f = true;
						curDir = "right";
						mc.scaleX = -1;
						mc.gotoAndStop("stand");
					}
				    break;
				case 2:
				    if (mc.x < 101 && mc.y <= 392 && mc.y >= 391) {
						f = true;
						curDir = "right";
						mc.scaleX = -1;
						mc.gotoAndStop("stand");
					}
				    break;
			    case 3:
				    if (mc.x < 101 && mc.y >= 516) {
						f = true;
						curDir = "right";
						mc.scaleX = -1;
						mc.gotoAndStop("stand");
					}
				    break;
				case 4:
				    if (mc.x > 700 && mc.y >= 516) {
						f = true;
						curDir = "left";
						mc.scaleX = 1;
						mc.gotoAndStop("stand");
					}
				    break;
				case 5:
				    if (mc.x > 700 && mc.y <= 392 && mc.y >= 391) {
						f = true;
						curDir = "left";
						mc.scaleX = 1;
						mc.gotoAndStop("stand");
					}
				    break;
				case 6:
				    if (mc.x >700 && mc.y <= 262 && mc.y >= 260) {
						f = true;
						curDir = "left";
						mc.scaleX = 1;
						mc.gotoAndStop("stand");
					}
				    break;
				case 7:
				    if(mc.x>700&&mc.y<=132){
				        f = true;
						curDir = "left";
						mc.scaleX = 1;
						mc.gotoAndStop("stand");
					}
				    break;
			}
			if (f && now == 0) {
				curState = "stand";
			    curPositionNum = targetPositionNum;
			    now = getTimer();
			}
			return f;
		}
		private function selectAction() {
			var a_action:uint = actionArr[curPositionNum].length;
			var t:uint = Math.floor(a_action * Math.random());
			if (t == 0) {
				if (curPositionNum == 0) {
					targetPositionNum = curPositionNum + 1;
				}
				else if (curPositionNum == 7) {
					targetPositionNum = curPositionNum - 1;
				}
				else {
				    targetPositionNum = curPositionNum - 1;	
				}
			}
			else if (t == 1) {
				if (curPositionNum == 0) {
					targetPositionNum = curPositionNum;
				}
				else if (curPositionNum == 7) {
					targetPositionNum = curPositionNum;
				}
				else {
				    targetPositionNum = curPositionNum + 1;	
				}
			}
			else if (t == 2) {
				targetPositionNum = curPositionNum;
			}
			//jump,down,attack,walk
			if (actionArr[curPositionNum][t] == "jump") {
				body.SetAwake(true);
				body.SetLinearVelocity(new b2Vec2(body.GetLinearVelocity().x, -this.speedY));
				curState = "jump";
				if (curPositionNum <= 3) {
					curDir = "right";
			        mc.scaleX = -1;
				}
				else {
					curDir = "left";
					mc.scaleX = 1;
				}
				mc.gotoAndStop("stand");
			}
			else if (actionArr[curPositionNum][t] == "down") {
				//todo
			}
			else if (actionArr[curPositionNum][t] == "attack") {
				curState = "attack";
				if (curPositionNum <= 3) {
					curDir = "right";
					mc.scaleX = -1;
				}
				else {
					curDir = "left";
					mc.scaleX = 1;
				}
				mc.gotoAndPlay("attack");
			}
			else if (actionArr[curPositionNum][t] == "walk") {
				curState = "walk";
				if (curPositionNum < targetPositionNum) {
					mc.scaleX = -1;
					curDir = "right";
				}
				else if(curPositionNum>targetPositionNum){
					mc.scaleX = 1;
					curDir = "left";
				}
				mc.gotoAndPlay("walk");
			}
		}
		
		
		private function setFd() {
			if (body.GetLinearVelocity().y < 0) {
				fd = new b2FilterData();
				fd.maskBits = 1;
				body.GetFixtureList().SetFilterData(fd);
			}
			//下落过程接触物体
			else {
				fd = new b2FilterData();
				fd.maskBits = 2;
				body.GetFixtureList().SetFilterData(fd);
			}
		}
	}
	
}