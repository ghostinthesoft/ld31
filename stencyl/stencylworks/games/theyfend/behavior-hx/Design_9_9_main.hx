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



class Design_9_9_main extends SceneScript
{          	
	
public var _tmpx:Float;

public var _tmpy:Float;

public var _letterp:Actor;

public var _lettery:Actor;

public var _active:Float;

public var _dist:Float;

public var _distp:Float;

public var _distn:Float;

public var _disty:Float;

public var _letterl:Actor;

public var _lettera:Actor;

public var _distl:Float;

public var _dista:Float;

public var _bird:Actor;

public var _mole2:Actor;

public var _mole1:Actor;

public var _grow:Bool;

public var _ready:Bool;

public var _elapsed:Float;

public var _scale:Float;

public var _part:Actor;

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("tmpx", "_tmpx");
_tmpx = 0.0;
nameMap.set("tmpy", "_tmpy");
_tmpy = 0.0;
nameMap.set("letterp", "_letterp");
nameMap.set("lettery", "_lettery");
nameMap.set("active", "_active");
_active = 0.0;
nameMap.set("dist", "_dist");
_dist = 0.0;
nameMap.set("distp", "_distp");
_distp = 0.0;
nameMap.set("distn", "_distn");
_distn = 0.0;
nameMap.set("disty", "_disty");
_disty = 0.0;
nameMap.set("letterl", "_letterl");
nameMap.set("lettera", "_lettera");
nameMap.set("distl", "_distl");
_distl = 0.0;
nameMap.set("dista", "_dista");
_dista = 0.0;
nameMap.set("bird", "_bird");
nameMap.set("mole2", "_mole2");
nameMap.set("mole1", "_mole1");
nameMap.set("grow", "_grow");
_grow = false;
nameMap.set("ready", "_ready");
_ready = false;
nameMap.set("elapsed", "_elapsed");
_elapsed = 0.0;
nameMap.set("scale", "_scale");
_scale = 1.0;
nameMap.set("part", "_part");

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        _active = asNumber(0);
propertyChanged("_active", _active);
        _tmpx = asNumber((0.5 * getSceneWidth()));
propertyChanged("_tmpx", _tmpx);
        _tmpy = asNumber((0.5 * getSceneHeight()));
propertyChanged("_tmpy", _tmpy);
        createRecycledActor(getActorType(24), 660, 60, Script.FRONT);
        _bird = getLastCreatedActor();
propertyChanged("_bird", _bird);
        createRecycledActor(getActorType(26), ((0.5 * getSceneWidth()) - 350), (getSceneHeight() - 85), Script.FRONT);
        _mole1 = getLastCreatedActor();
propertyChanged("_mole1", _mole1);
        createRecycledActor(getActorType(26), ((0.5 * getSceneWidth()) + 200), (getSceneHeight() - 85), Script.FRONT);
        _mole2 = getLastCreatedActor();
propertyChanged("_mole2", _mole2);
        createRecycledActor(getActorType(0), (_tmpx - (3 * 20)), _tmpy, Script.FRONT);
        _letterp = getLastCreatedActor();
propertyChanged("_letterp", _letterp);
        createRecycledActor(getActorType(19), (_tmpx + (1 * 20)), _tmpy, Script.FRONT);
        _lettera = getLastCreatedActor();
propertyChanged("_lettera", _lettera);
        createRecycledActor(getActorType(11), (_tmpx + (3 * 20)), _tmpy, Script.FRONT);
        _lettery = getLastCreatedActor();
propertyChanged("_lettery", _lettery);
        createRecycledActor(getActorType(17), (_tmpx - (1 * 20)), _tmpy, Script.FRONT);
        _letterl = getLastCreatedActor();
propertyChanged("_letterl", _letterl);
    
/* ============================ Click ============================= */
addMousePressedListener(function(list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(!(_ready))
{
            _tmpx = asNumber(Math.abs((getMouseX() - (0.5 * getSceneWidth()))));
propertyChanged("_tmpx", _tmpx);
            _tmpy = asNumber(Math.abs((getMouseY() - _letterp.getYCenter())));
propertyChanged("_tmpy", _tmpy);
            if(((_tmpx < 65) && (_tmpy < 15)))
{
                _ready = true;
propertyChanged("_ready", _ready);
                _letterp.setIgnoreGravity(!true);
                _letterl.setIgnoreGravity(!true);
                _lettera.setIgnoreGravity(!true);
                _lettery.setIgnoreGravity(!true);
                _letterp.setXVelocity(7);
                _letterp.setYVelocity(-15);
                _letterl.setXVelocity(-10);
                _letterl.setYVelocity(-20);
                _lettera.setXVelocity(5);
                _lettera.setYVelocity(-15);
                _lettery.setXVelocity(7);
                _lettery.setYVelocity(-20);
}

            return;
}

        _tmpx = asNumber((getMouseX() - _letterp.getXCenter()));
propertyChanged("_tmpx", _tmpx);
        _tmpy = asNumber((getMouseY() - _letterp.getYCenter()));
propertyChanged("_tmpy", _tmpy);
        _tmpx = asNumber((_tmpx * _tmpx));
propertyChanged("_tmpx", _tmpx);
        _tmpy = asNumber((_tmpy * _tmpy));
propertyChanged("_tmpy", _tmpy);
        _distp = asNumber((_tmpx + _tmpy));
propertyChanged("_distp", _distp);
        _tmpx = asNumber((getMouseX() - _letterl.getXCenter()));
propertyChanged("_tmpx", _tmpx);
        _tmpy = asNumber((getMouseY() - _letterl.getYCenter()));
propertyChanged("_tmpy", _tmpy);
        _tmpx = asNumber((_tmpx * _tmpx));
propertyChanged("_tmpx", _tmpx);
        _tmpy = asNumber((_tmpy * _tmpy));
propertyChanged("_tmpy", _tmpy);
        _distl = asNumber((_tmpx + _tmpy));
propertyChanged("_distl", _distl);
        _tmpx = asNumber((getMouseX() - _lettera.getXCenter()));
propertyChanged("_tmpx", _tmpx);
        _tmpy = asNumber((getMouseY() - _lettera.getYCenter()));
propertyChanged("_tmpy", _tmpy);
        _tmpx = asNumber((_tmpx * _tmpx));
propertyChanged("_tmpx", _tmpx);
        _tmpy = asNumber((_tmpy * _tmpy));
propertyChanged("_tmpy", _tmpy);
        _dista = asNumber((_tmpx + _tmpy));
propertyChanged("_dista", _dista);
        _tmpx = asNumber((getMouseX() - _lettery.getXCenter()));
propertyChanged("_tmpx", _tmpx);
        _tmpy = asNumber((getMouseY() - _lettery.getYCenter()));
propertyChanged("_tmpy", _tmpy);
        _tmpx = asNumber((_tmpx * _tmpx));
propertyChanged("_tmpx", _tmpx);
        _tmpy = asNumber((_tmpy * _tmpy));
propertyChanged("_tmpy", _tmpy);
        _disty = asNumber((_tmpx + _tmpy));
propertyChanged("_disty", _disty);
        _dist = asNumber(99999);
propertyChanged("_dist", _dist);
        _distn = asNumber(0);
propertyChanged("_distn", _distn);
        if((_distp < _dist))
{
            _dist = asNumber(_distp);
propertyChanged("_dist", _dist);
            _distn = asNumber(1);
propertyChanged("_distn", _distn);
}

        if((_distl < _dist))
{
            _dist = asNumber(_distl);
propertyChanged("_dist", _dist);
            _distn = asNumber(2);
propertyChanged("_distn", _distn);
}

        if((_dista < _dist))
{
            _dist = asNumber(_dista);
propertyChanged("_dist", _dist);
            _distn = asNumber(3);
propertyChanged("_distn", _distn);
}

        if((_disty < _dist))
{
            _dist = asNumber(_disty);
propertyChanged("_dist", _dist);
            _distn = asNumber(4);
propertyChanged("_distn", _distn);
}

        if((_dist > 200))
{
            _distn = asNumber(0);
propertyChanged("_distn", _distn);
}

        if(!(_distn == 0))
{
            _letterp.setFriction(0.1);
            _letterl.setFriction(0.1);
            _lettera.setFriction(0.1);
            _lettery.setFriction(0.1);
            _letterp.setBounciness(0);
            _letterl.setBounciness(0);
            _lettera.setBounciness(0);
            _lettery.setBounciness(0);
            _active = asNumber(_distn);
propertyChanged("_active", _active);
}

        else if((_active == 1))
{
            _letterp.say("controlp", "_customEvent_" + "input_start");
}

        else if((_active == 2))
{
            _letterl.say("controll", "_customEvent_" + "input_start");
}

        else if((_active == 3))
{
            _lettera.say("controla", "_customEvent_" + "input_start");
}

        else if((_active == 4))
{
            _lettery.say("controly", "_customEvent_" + "input_start");
}

}
});
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        _elapsed = asNumber((_elapsed + elapsedTime));
propertyChanged("_elapsed", _elapsed);
        while((_elapsed > 500))
{
            _elapsed = asNumber((_elapsed - 500));
propertyChanged("_elapsed", _elapsed);
            _grow = !(_grow);
propertyChanged("_grow", _grow);
}

        if(_grow)
{
            _scale = asNumber((0.9 + (0.2 * (_elapsed / 500))));
propertyChanged("_scale", _scale);
}

        else
{
            _scale = asNumber((1.1 - (0.2 * (_elapsed / 500))));
propertyChanged("_scale", _scale);
}

        if((_active == 1))
{
            _letterp.realScaleX=1;
}

        else
{
            _letterp.realScaleX=_scale;
}

        if((_active == 2))
{
            _letterl.realScaleX=1;
}

        else
{
            _letterl.realScaleX=_scale;
}

        if((_active == 3))
{
            _lettera.realScaleX=1;
}

        else
{
            _lettera.realScaleX=_scale;
}

        _part = _lettery.getValue("controly", "_top");
propertyChanged("_part", _part);
        if((_active == 4))
{
            _lettery.realScaleX=1;
            _part.realScaleX=1;
}

        else
{
            _lettery.realScaleX=_scale;
            _part.realScaleX=_scale;
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}