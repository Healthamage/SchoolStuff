package com.nicolasbourre.gdx.basegamesetup;

import com.badlogic.gdx.graphics.g2d.Animation;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.g2d.TextureRegion;

import java.util.HashMap;

/**
 * Created by Christopher on 2016-11-14.
 */
public class GraphicComponent extends Component {

    public enum AnimationEnum{IDLE,MARCHER,COURIR}
    private HashMap<AnimationEnum, Animation> animations;
    private TextureRegion currentFrame;
    private Actor actor;
    private AnimationEnum currentAnimation;
    private SpriteBatch batch;
    GraphicComponent(Actor actor,SpriteBatch batch){
        this.batch = batch;
        animations = new HashMap<AnimationEnum, Animation>();
        this.actor = actor;
    }

    void addAnimation(AnimationEnum animeName, Animation animation){animations.put(animeName, animation);}
    void currentAnimation(AnimationEnum currentAnimation){this.currentAnimation = currentAnimation;}

    public void draw(float elapsedTime) {
        if(currentAnimation != null) {
            currentFrame = animations.get(currentAnimation).getKeyFrame(elapsedTime);
            if(actor.physicComponent.dir() == PhysicComponent.Direction.RIGHT)
                 batch.draw(currentFrame, actor.physicComponent.position.x, actor.physicComponent.position.y);
            else
                 batch.draw(currentFrame, actor.physicComponent.position.x + currentFrame.getRegionWidth(), actor.physicComponent.position.y, -currentFrame.getRegionWidth(), currentFrame.getRegionHeight());
        }
    }
}

