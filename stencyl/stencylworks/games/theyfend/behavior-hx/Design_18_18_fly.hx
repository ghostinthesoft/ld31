package scripts;

import com.stencyl.graphics.G;

import com.stencyl.behavior.Script;
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

import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.Utils;

import nme.ui.Mouse;
import nme.display.Graphics;
import nme.display.BlendMode;
import nme.display.BitmapData;
import nme.display.Bitmap;
import nme.events.Event;
import nme.events.KeyboardEvent;
import nme.events.TouchEvent;
import nme.net.URLLoader;

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
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_18_18_fly extends ActorScript
{          	
	
public var _flying:Bool;

public var _right:Bool;

public var _dx:Float;

public var _dy:Float;

public var _timeout:Float;

public var _tmp:Float;

public var _speed:Float;

public var _leftx:Float;

public var _lefty:Float;

public var _rightx:Float;

public var _righty:Float;
    
/* ========================= Custom Event ========================= */
public function _customEvent_fly_away():Void
{
        if(!(_flying))
{
            _flying = true;
propertyChanged("_flying", _flying);
            if(_right)
{
                actor.setAnimation("" + ("" + "flyl"));
                actor.moveTo(100, 10, 1, Quad.easeInOut);
                runLater(1000 * 1, function(timeTask:TimedTask):Void {
                            _flying = false;
propertyChanged("_flying", _flying);
                            _right = false;
propertyChanged("_right", _right);
}, actor);
}

            else
{
                actor.setAnimation("" + ("" + "flyr"));
                actor.moveTo(660, 60, 1, Quad.easeInOut);
                runLater(1000 * 1, function(timeTask:TimedTask):Void {
                            _flying = false;
propertyChanged("_flying", _flying);
                            _right = true;
propertyChanged("_right", _right);
}, actor);
}

}

}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("flying", "_flying");
_flying = false;
nameMap.set("right", "_right");
_right = true;
nameMap.set("dx", "_dx");
_dx = 0.0;
nameMap.set("dy", "_dy");
_dy = 0.0;
nameMap.set("timeout", "_timeout");
_timeout = 0;
nameMap.set("tmp", "_tmp");
_tmp = 0;
nameMap.set("speed", "_speed");
_speed = 0;
nameMap.set("leftx", "_leftx");
_leftx = 0;
nameMap.set("lefty", "_lefty");
_lefty = 0;
nameMap.set("rightx", "_rightx");
_rightx = 0;
nameMap.set("righty", "_righty");
_righty = 0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    
/* ========================= Type & Type ========================== */
addSceneCollisionListener(getActorType(24).ID, getActorType(13).ID, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        actor.shout("_customEvent_" + "fly_away");
}
});
    
/* =========================== On Actor =========================== */
addMouseOverActorListener(actor, function(mouseState:Int, list:Array<Dynamic>):Void {
if(wrapper.enabled && 3 == mouseState){
        actor.shout("_customEvent_" + "fly_away");
}
});
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(!(_flying))
{
            if((actor.getXCenter() < getValueForScene("main", "_lettera").getXCenter()))
{
                actor.setAnimation("" + ("" + "idler"));
}

            else
{
                actor.setAnimation("" + ("" + "idlel"));
}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}