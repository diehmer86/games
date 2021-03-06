package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;
import com.stencyl.models.Joystick;

import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;

import motion.Actuate;
import motion.easing.Back;
import motion.easing.Cubic;
import motion.easing.Elastic;
import motion.easing.Expo;
import motion.easing.Linear;
import motion.easing.Quad;
import motion.easing.Quart;
import motion.easing.Quint;
import motion.easing.Sine;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class ActorEvents_4 extends ActorScript
{
	public var _currentdirection:String;
	public var _DIRECTIONOFMONSTER:String;
	public var _directionofmonster:String;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("current direction", "_currentdirection");
		_currentdirection = "";
		nameMap.set("DIRECTION OF MONSTER", "_DIRECTIONOFMONSTER");
		_DIRECTIONOFMONSTER = "";
		nameMap.set("direction of monster", "_directionofmonster");
		
	}
	
	override public function init()
	{
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if(isKeyDown("left"))
				{
					actor.setXVelocity(-20);
					actor.setAnimation("" + "walking left");
					_currentdirection = "left";
					propertyChanged("_currentdirection", _currentdirection);
				}
				else if(isKeyDown("right"))
				{
					actor.setXVelocity(20);
					actor.setAnimation("" + "walking right");
					_currentdirection = "right";
					propertyChanged("_currentdirection", _currentdirection);
				}
				else
				{
					actor.setXVelocity(0);
					if((_currentdirection == "left"))
					{
						actor.setAnimation("" + "idle left");
					}
					else if((_currentdirection == "right"))
					{
						actor.setAnimation("" + "idle right");
					}
				}
				if(isKeyDown("up"))
				{
					actor.setYVelocity(-20);
					actor.setAnimation("" + "walking up");
					_currentdirection = "up";
					propertyChanged("_currentdirection", _currentdirection);
				}
				else if(isKeyDown("down"))
				{
					actor.setYVelocity(20);
					actor.setAnimation("" + "walking down");
					_currentdirection = "down";
					propertyChanged("_currentdirection", _currentdirection);
				}
				else
				{
					actor.setYVelocity(0);
					if((_currentdirection == "up"))
					{
						actor.setAnimation("" + "idle up");
					}
					else if((_currentdirection == "down"))
					{
						actor.setAnimation("" + "idle down");
					}
				}
			}
		});
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if((actor.getScreenX() < 0))
				{
					actor.setX(1);
				}
				else if((actor.getScreenX() > (getScreenWidth() - (actor.getWidth()))))
				{
					actor.setX(((getScreenWidth() - (actor.getWidth())) - 1));
				}
			}
		});
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if((actor.getScreenY() < 0))
				{
					actor.setY(1);
				}
				else if((actor.getScreenY() > (getScreenHeight() - (actor.getHeight()))))
				{
					actor.setY(((getScreenHeight() - (actor.getHeight())) - 1));
				}
			}
		});
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				Engine.engine.setGameAttribute("spongebob x", actor.getX());
				Engine.engine.setGameAttribute("spongebob y", actor.getY());
			}
		});
		
		/* =========================== Keyboard =========================== */
		addKeyStateListener("action1", function(pressed:Bool, released:Bool, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && pressed)
			{
				createRecycledActor(getActorType(0), actor.getX(), actor.getY(), Script.FRONT);
				if((actor.getAnimation() == "walking right"))
				{
					getLastCreatedActor().applyImpulseInDirection(0, 100);
				}
				if((actor.getAnimation() == "walking left"))
				{
					getLastCreatedActor().applyImpulseInDirection(180, 100);
				}
				if((actor.getAnimation() == "walking up"))
				{
					getLastCreatedActor().applyImpulseInDirection(270, 100);
				}
				if((actor.getAnimation() == "walking down"))
				{
					getLastCreatedActor().applyImpulseInDirection(90, 100);
				}
				if((actor.getAnimation() == "idle left"))
				{
					getLastCreatedActor().applyImpulseInDirection(180, 100);
				}
				if((actor.getAnimation() == "idle up"))
				{
					getLastCreatedActor().applyImpulseInDirection(90, 100);
				}
				if((actor.getAnimation() == "idle down"))
				{
					getLastCreatedActor().applyImpulseInDirection(90, 100);
				}
				if((actor.getAnimation() == "idle right"))
				{
					getLastCreatedActor().applyImpulseInDirection(0, 100);
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}