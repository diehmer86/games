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



class ActorEvents_6 extends ActorScript
{
	public var _currentdirection:String;
	public var _spongebobY:Float;
	public var _spongebobX:Float;
	public var _kill:Actor;
	public var _spongebob:Actor;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("current direction", "_currentdirection");
		_currentdirection = "";
		nameMap.set("spongebob Y", "_spongebobY");
		_spongebobY = 0.0;
		nameMap.set("spongebob X", "_spongebobX");
		_spongebobX = 0.0;
		nameMap.set("kill", "_kill");
		nameMap.set("spongebob", "_spongebob");
		
	}
	
	override public function init()
	{
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				actor.applyImpulse((Engine.engine.getGameAttribute("spongebob x") - actor.getX()), (Engine.engine.getGameAttribute("spongebob y") - actor.getY()), .2);
			}
		});
		
		/* ========================= Type & Type ========================== */
		addSceneCollisionListener(getActorType(6).ID, getActorType(4).ID, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				recycleActor(event.otherActor);
			}
		});
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(0), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				recycleActor(actor);
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
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}