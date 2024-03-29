﻿package winter.Boss
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2FilterData;
	import flash.display.Sprite;
	import flash.events.Event;
	import winter.Chapter.*;
	import winter.Data.GameData;
	import flash.display.MovieClip;
	import flash.utils.getTimer;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
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
		
		private var curDir:String;
		private var curPositionNum:uint = 4;
		private var targetPositionNum:uint;
		private var fd:b2FilterData;
		private var now:uint = 0;
		private var tick:Timer;
		private var tick2:Timer;    //超时处理的tick，8s后到不了目的地重新选择selectAction
		private var idelLoft:b2Body;
		
		public function Boss7(chapter:ChapterBase) {
			super(chapter);
		    mc = new GameData.heroMcArray[2]() as MovieClip;
			addChild(mc);
			body = chapter.box2d.createBox(550, 40, 30,40, true,"boss7");
			body.SetUserData(mc);
			mc.gotoAndStop("stand");
			init();
			addEventListener(Event.ENTER_FRAME, onenterframe);
		}
		
		private function init() {
			curState = "walk";
			mc.gotoAndPlay("walk");
			curDir = "left";
			curPositionNum = 4;
			targetPositionNum = 3;
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
			
			if (isArrive() && now && getTimer() - now > 1000) {
				selectAction();
				now = 0;
			}
		}
		
		
		private function isArrive() {
			var f:Boolean = false;
			switch (targetPositionNum) {
				case 0:
				    if(mc.x<101&&mc.y<=145){
				        f = true;
						curDir = "right";
						mc.scaleX = -1;
					}
				    break;
				case 1:
				    if (mc.x < 101 && mc.y <= 275 && mc.y >= 273) {
						f = true;
						curDir = "right";
						mc.scaleX = -1;
					}
				    break;
				case 2:
				    if (mc.x < 101 && mc.y <= 405 && mc.y >= 404) {
						f = true;
						curDir = "right";
						mc.scaleX = -1;
					}
				    break;
			    case 3:
				    if (mc.x < 101 && mc.y >= 528) {
						f = true;
						curDir = "right";
						mc.scaleX = -1;
					}
				    break;
				case 4:
				    if (mc.x > 700 && mc.y >= 528) {
						f = true;
						curDir = "left";
						mc.scaleX = 1;
					}
				    break;
				case 5:
				    if (mc.x > 700 && mc.y <= 405 && mc.y >= 404) {
						f = true;
						curDir = "left";
						mc.scaleX = 1;
					}
				    break;
				case 6:
				    if (mc.x >700 && mc.y <= 275 && mc.y >= 273) {
						f = true;
						curDir = "left";
						mc.scaleX = 1;
					}
				    break;
				case 7:
				    if(mc.x>700&&mc.y<=145){
				        f = true;
						curDir = "left";
						mc.scaleX = 1;
					}
				    break;
			}
			if (f && now == 0) {
				curState = "stand";
				//attack的动画不要停止
				if (mc.currentLabel != "attack") {
				    mc.gotoAndStop("stand");	
				}
			    curPositionNum = targetPositionNum;
			    now = getTimer();
				//已经到达目的地，清楚超时处理的tick2
				if(tick2){
				    tick2.removeEventListener(TimerEvent.TIMER_COMPLETE, reSelectAction);
			        tick2 = null;
				}
			}
			return f;
		}
		private function selectAction() {
			var a_action:uint = actionArr[curPositionNum].length;
			var t:uint = Math.floor(a_action * Math.random());
			//trace(curPositionNum+'----'+t);
			//trace(actionArr[curPositionNum][t]);
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
			
			//up,down,attack,walk
			if (actionArr[curPositionNum][t] == "up") {
				body.SetAwake(true);
				body.SetLinearVelocity(new b2Vec2(body.GetLinearVelocity().x, -this.speedY));
				setFd();  //这里跳起的一瞬间需要更改maskBits
				curState = "up";
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
				fall();
				curState = "down";
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
			//容错处理，防止到不了目的地卡死现象，定时8s，超时后还没有到达目的地重新selectAction
			tick2 = new Timer(8000,1);
            tick2.addEventListener(TimerEvent.TIMER_COMPLETE, reSelectAction);
			tick2.start();
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
		
		private function fall() {
			var b:b2Body;
			for (var a = body.GetContactList(); a; a = a.next) {
				b = a.contact.GetFixtureB().GetBody();
				if (b.GetUserData() is String && b.GetUserData().indexOf("loft")!=-1) {
					this.idelLoft = b;
					this.idelLoft.SetActive(false);//休眠可以穿透物体
					this.idelLoft.SetAwake(false);
					tick = new Timer(500,1);
					//tick.addEventListener(TimerEvent.TIMER, timerHandler);
                    tick.addEventListener(TimerEvent.TIMER_COMPLETE, activeLoft);
					tick.start();
				}
			}
		}
		
		private function activeLoft(evt:TimerEvent) {
			//trace(this.idelLoft.GetUserData());
			this.idelLoft.SetActive(true);
			this.idelLoft.SetAwake(true);  //为什么总是有时抽风跳起之后碰loft???
			tick.removeEventListener(TimerEvent.TIMER_COMPLETE, activeLoft);
			tick = null;
		}
		
		private function reSelectAction(evt:TimerEvent) {
			selectAction();
			tick2.removeEventListener(TimerEvent.TIMER_COMPLETE, reSelectAction);
			tick2 = null;
		}
	}
	
}