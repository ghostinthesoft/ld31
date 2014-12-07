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



class Design_3_3_controlp extends ActorScript
{          	
	
public var _tmp:Float;

public var _jumping:Bool;

public var _right:Bool;

public var _dir:Float;

public var _falling:Bool;

public var _starty:Float;

public var _dist:Float;
    
/* ========================= Custom Event ========================= */
public function _customEvent_input_start():Void
{
        if(!((_jumping || _falling)))
{
            _jumping = true;
propertyChanged("_jumping", _jumping);
            _starty = asNumber(actor.getY());
propertyChanged("_starty", _starty);
            _tmp = asNumber((getMouseX() - actor.getX()));
propertyChanged("_tmp", _tmp);
            if((_tmp < 0))
{
                _right = false;
propertyChanged("_right", _right);
                _dir = asNumber(-1);
propertyChanged("_dir", _dir);
                actor.setAnimation("" + ("" + "upl"));
}

            else
{
                _right = true;
propertyChanged("_right", _right);
                _dir = asNumber(1);
propertyChanged("_dir", _dir);
                actor.setAnimation("" + ("" + "upr"));
}

            _tmp = asNumber((-90 + (15 * _dir)));
propertyChanged("_tmp", _tmp);
            runLater(1000 * 0.2, function(timeTask:TimedTask):Void {
                        actor.applyImpulseInDirection(_tmp, 30);
}, actor);
}

}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("tmp", "_tmp");
_tmp = 0.0;
nameMap.set("jumping", "_jumping");
_jumping = false;
nameMap.set("right", "_right");
_right = false;
nameMap.set("dir", "_dir");
_dir = 0.0;
nameMap.set("falling", "_falling");
_falling = false;
nameMap.set("starty", "_starty");
_starty = 0.0;
nameMap.set("dist", "_dist");
_dist = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        actor.setAnimation("" + ("" + "idler"));
        _right = true;
propertyChanged("_right", _right);
        _dir = asNumber(1);
propertyChanged("_dir", _dir);
        _falling = false;
propertyChanged("_falling", _falling);
        _jumping = false;
propertyChanged("_jumping", _jumping);
        _starty = asNumber(actor.getY());
propertyChanged("_starty", _starty);
    
/* ======================== Something Else ======================== */
addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_falling)
{
            _falling = false;
propertyChanged("_falling", _falling);
            if(_right)
{
                actor.setAnimation("" + ("" + "downr"));
}

            else
{
                actor.setAnimation("" + ("" + "downl"));
}

            _dist = asNumber(Math.abs((event.otherActor.getXCenter() - actor.getXCenter())));
propertyChanged("_dist", _dist);
}

        if((_dist < 10))
{
            if((event.otherActor == getValueForScene("main", "_mole1")))
{
                if((event.otherActor.getAnimation() == ("" + "up")))
{
                    event.otherActor.setAnimation("" + ("" + "down"));
                    runLater(1000 * 2, function(timeTask:TimedTask):Void {
                                getValueForScene("main", "_mole2").setAnimation("" + ("" + "up"));
}, actor);
}

}

            else if((event.otherActor == getValueForScene("main", "_mole2")))
{
                if((event.otherActor.getAnimation() == ("" + "up")))
{
                    event.otherActor.setAnimation("" + ("" + "down"));
                    runLater(1000 * 2, function(timeTask:TimedTask):Void {
                                getValueForScene("main", "_mole1").setAnimation("" + ("" + "up"));
}, actor);
}

}

}

}
});
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((_jumping && ((_starty - actor.getY()) > 30)))
{
            _jumping = false;
propertyChanged("_jumping", _jumping);
            _falling = true;
propertyChanged("_falling", _falling);
}

        if((actor.getX() < 0))
{
            actor.setX(0);
}

        if(((actor.getX() + (actor.getWidth())) > getSceneWidth()))
{
            actor.setX((getSceneWidth() - (actor.getWidth())));
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}