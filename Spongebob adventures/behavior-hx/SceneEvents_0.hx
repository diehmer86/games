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
import box2D.collision.shapes.B2Shape;

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



class SceneEvents_0 extends SceneScript
{
	public var _monsterdies:String;
	public var _monster:Actor;
	
	
	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("monster dies", "_monsterdies");
		nameMap.set("monster", "_monster");
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		createRecycledActor(getActorType(4), 40, 430, Script.FRONT);
		createRecycledActor(getActorType(6), 613, 30, Script.FRONT);
		createRecycledActor(getActorType(13), 496, 49, Script.FRONT);
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if((getLastCreatedActor().getScreenX() < 0))
				{
					getLastCreatedActor().setX(1);
				}
				else if((getLastCreatedActor().getScreenX() > (getScreenWidth() - (getLastCreatedActor().getWidth()))))
				{
					getLastCreatedActor().setX(((getScreenWidth() - (getLastCreatedActor().getWidth())) - 1));
				}
				if((getLastCreatedActor().getScreenY() < 0))
				{
					getLastCreatedActor().setY(1);
				}
				else if((getLastCreatedActor().getScreenY() > (getScreenWidth() - (getLastCreatedActor().getWidth()))))
				{
					getLastCreatedActor().setY(((getScreenWidth() - (getLastCreatedActor().getWidth())) - 1));
				}
			}
		});
		
		/* ======================== Actor of Type ========================= */
		addActorEntersRegionListener(getRegion(0), function(a:Actor, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(4),a.getType(),a.getGroup()))
			{
				switchScene(GameModel.get().scenes.get(1).getID(), null, createSlideUpTransition(.5));
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}