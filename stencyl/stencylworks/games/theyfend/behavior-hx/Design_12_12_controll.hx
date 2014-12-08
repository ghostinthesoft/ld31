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



class Design_12_12_controll extends ActorScript
{          	
	
public var _right:Bool;

public var _dir:Float;

public var _moving:Bool;

public var _tmp:Float;

public var _tmpx:Float;

public var _tmpy:Float;

public var _distp:Float;

public var _dista:Float;

public var _disty:Float;

public var _letter:Actor;

public var _active:Float;

public var _wearing:Float;

public var _dist:Float;

public var _distn:Float;
    
/* ========================= Custom Event ========================= */
public function _customEvent_input_start():Void
{
        if(!(_moving))
{
            stopSoundOnChannel(Std.int(0));
            playSoundOnChannel(getSound(43), Std.int(0));
            fadeInSoundOnChannel(Std.int(0),0.5);
            _moving = true;
propertyChanged("_moving", _moving);
            _tmp = asNumber((getMouseX() - actor.getX()));
propertyChanged("_tmp", _tmp);
            if((_tmp < 0))
{
                _right = false;
propertyChanged("_right", _right);
                _dir = asNumber(-1);
propertyChanged("_dir", _dir);
                actor.setAnimation("" + ("" + "movel"));
}

            else
{
                _right = true;
propertyChanged("_right", _right);
                _dir = asNumber(1);
propertyChanged("_dir", _dir);
                actor.setAnimation("" + ("" + "mover"));
}

}

}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("right", "_right");
_right = false;
nameMap.set("dir", "_dir");
_dir = 0.0;
nameMap.set("moving", "_moving");
_moving = false;
nameMap.set("tmp", "_tmp");
_tmp = 0.0;
nameMap.set("tmpx", "_tmpx");
_tmpx = 0.0;
nameMap.set("tmpy", "_tmpy");
_tmpy = 0.0;
nameMap.set("distp", "_distp");
_distp = 0.0;
nameMap.set("dista", "_dista");
_dista = 0.0;
nameMap.set("disty", "_disty");
_disty = 0.0;
nameMap.set("Actor", "actor");
nameMap.set("letter", "_letter");
nameMap.set("active", "_active");
_active = 0.0;
nameMap.set("wearing", "_wearing");
_wearing = 0.0;
nameMap.set("dist", "_dist");
_dist = 0.0;
nameMap.set("distn", "_distn");
_distn = 0.0;

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        actor.setFriction(0.01);
        actor.setAnimation("" + ("" + "idler"));
        _right = true;
propertyChanged("_right", _right);
        _dir = asNumber(1);
propertyChanged("_dir", _dir);
    
/* ============================ Click ============================= */
addMouseReleasedListener(function(list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_moving)
{
            fadeOutSoundOnChannel(Std.int(0),0.5);
}

        _moving = false;
propertyChanged("_moving", _moving);
        if((_wearing == 4))
{
            getValueForScene("main", "_lettery").setIgnoreGravity(!true);
}

        _wearing = asNumber(0);
propertyChanged("_wearing", _wearing);
        if(_right)
{
            actor.setAnimation("" + ("" + "idler"));
}

        else
{
            actor.setAnimation("" + ("" + "idlel"));
}

}
});
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_moving)
{
            actor.setXVelocity((10 * _dir));
            if((_wearing == 0))
{
                _dist = asNumber(99999);
propertyChanged("_dist", _dist);
                _distn = asNumber(0);
propertyChanged("_distn", _distn);
                _letter = getValueForScene("main", "_lettery");
propertyChanged("_letter", _letter);
                _disty = asNumber(Math.abs((_letter.getXCenter() - actor.getXCenter())));
propertyChanged("_disty", _disty);
                if((_disty < _dist))
{
                    _dist = asNumber(_disty);
propertyChanged("_dist", _dist);
                    _distn = asNumber(4);
propertyChanged("_distn", _distn);
}

                if((_dist > 4))
{
                    _distn = asNumber(0);
propertyChanged("_distn", _distn);
}

                if(!(_distn == 0))
{
                    _wearing = asNumber(_distn);
propertyChanged("_wearing", _wearing);
}

}

}

        if((_wearing == 1))
{
            _letter = getValueForScene("main", "_letterp");
propertyChanged("_letter", _letter);
            _letter.setX(actor.getX());
            _letter.setY((actor.getY() - 2));
            _letter.setIgnoreGravity(!false);
}

        else if((_wearing == 3))
{
            _letter = getValueForScene("main", "_lettera");
propertyChanged("_letter", _letter);
            _letter.setX(actor.getX());
            _letter.setY((actor.getY() - 2));
            _letter.setIgnoreGravity(!false);
}

        else if((_wearing == 4))
{
            _letter = getValueForScene("main", "_lettery");
propertyChanged("_letter", _letter);
            _letter.setX(actor.getX());
            _letter.setY((actor.getY() - 2));
            _letter.setIgnoreGravity(!false);
}

        if((actor.getX() < 0))
{
            actor.setX(0);
}

        if(((actor.getX() + (actor.getWidth())) > (getSceneWidth() - 16)))
{
            actor.setX(((getSceneWidth() - 16) - (actor.getWidth())));
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}