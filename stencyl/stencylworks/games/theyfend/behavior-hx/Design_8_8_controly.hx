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



class Design_8_8_controly extends ActorScript
{          	
	
public var _top:Actor;

public var _tmp:Float;

public var _offsety:Float;

public var _pressed:Bool;

public var _mid:Actor;
    
/* ========================= Custom Event ========================= */
public function _customEvent_input_start():Void
{
        playSoundOnChannel(getSound(45), Std.int(0));
        _pressed = true;
propertyChanged("_pressed", _pressed);
}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("top", "_top");
nameMap.set("tmp", "_tmp");
_tmp = 0.0;
nameMap.set("offsety", "_offsety");
_offsety = 0.0;
nameMap.set("pressed", "_pressed");
_pressed = false;
nameMap.set("mid", "_mid");
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        actor.setFriction(0.01);
        createRecycledActor(getActorType(13), -100, -100, Script.FRONT);
        _top = getLastCreatedActor();
propertyChanged("_top", _top);
        createRecycledActor(getActorType(15), -100, -100, Script.FRONT);
        _mid = getLastCreatedActor();
propertyChanged("_mid", _mid);
        _pressed = false;
propertyChanged("_pressed", _pressed);
        _offsety = asNumber(0);
propertyChanged("_offsety", _offsety);
    
/* ============================ Click ============================= */
addMouseReleasedListener(function(list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_pressed)
{
            stopSoundOnChannel(Std.int(0));
}

        _pressed = false;
propertyChanged("_pressed", _pressed);
}
});
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_pressed)
{
            if((_offsety < 350))
{
                _offsety = asNumber((_offsety + (elapsedTime * 0.15)));
propertyChanged("_offsety", _offsety);
}

}

        else
{
            _offsety = asNumber((_offsety - (elapsedTime * 0.25)));
propertyChanged("_offsety", _offsety);
            if((_offsety < 0))
{
                _offsety = asNumber(0);
propertyChanged("_offsety", _offsety);
}

}

        _top.setX(actor.getX());
        _top.setY(((actor.getYCenter() - 12) - _offsety));
        _mid.setX(actor.getX());
        _tmp = asNumber((_offsety + 0));
propertyChanged("_tmp", _tmp);
        _mid.setY((actor.getYCenter() - (12 + (0.5 * _tmp))));
        _tmp = asNumber((_tmp / 24));
propertyChanged("_tmp", _tmp);
        _mid.realScaleY = _tmp;
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}