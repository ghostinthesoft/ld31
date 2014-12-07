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



class Design_23_23_panel extends ActorScript
{          	
	
public var _originalx:Float;

public var _originaly:Float;

public var _opened:Bool;

public var _tmp:Float;

public var _opening:Bool;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("originalx", "_originalx");
_originalx = 0;
nameMap.set("originaly", "_originaly");
_originaly = 0;
nameMap.set("opened", "_opened");
_opened = true;
nameMap.set("tmp", "_tmp");
_tmp = 0;
nameMap.set("opening", "_opening");
_opening = true;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        actor.makeAlwaysSimulate();
        _originalx = asNumber(actor.getX());
propertyChanged("_originalx", _originalx);
        _originaly = asNumber(actor.getY());
propertyChanged("_originaly", _originaly);
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_opened)
{
            if(!(_opening))
{
                _opening = true;
propertyChanged("_opening", _opening);
                actor.moveTo(_originalx, _originaly, 1, Expo.easeOut);
}

}

        else
{
            if(_opening)
{
                _opening = false;
propertyChanged("_opening", _opening);
                if((_originalx == 0))
{
                    actor.moveTo(-212, _originaly, 1, Expo.easeOut);
}

                else if((_originaly == 0))
{
                    actor.moveTo(_originalx, -164, 1, Expo.easeOut);
}

                else
{
                    actor.moveTo(788, _originaly, 1, Expo.easeOut);
}

}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}