package com.nicolasbourre.gdx.basegamesetup;

import com.badlogic.gdx.graphics.g2d.Animation;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.g2d.TextureAtlas;
import com.badlogic.gdx.math.Vector2;

/**
 * Created by Christopher on 2016-11-14.
 */
public class Mario extends Actor {



    Mario(boolean activeKeys[], Vector2 position,SpriteBatch batch){
        super(activeKeys, position, batch);
        initAnimations();
        graphicComponent.currentAnimation(GraphicComponent.AnimationEnum.IDLE);
    }

    void update(float deltaTime){
        inputComponent.update(deltaTime);
        for(Command c :commands)
            c.execute(this);
        commands.clear();

        state.update(deltaTime);
        physicComponent.update(deltaTime);
    }
    void draw(float elapsedTime){
        graphicComponent.draw(elapsedTime);
    }

    void initAnimations() {
        TextureAtlas atlas = new TextureAtlas("mario.txt");
        this.graphicComponent.addAnimation(GraphicComponent.AnimationEnum.MARCHER,new Animation(1 / 8f, atlas.findRegions("mario_big_running"),Animation.PlayMode.LOOP));
        this.graphicComponent.addAnimation(GraphicComponent.AnimationEnum.COURIR,new Animation(1 / 16f, atlas.findRegions("mario_big_running"),Animation.PlayMode.LOOP));
        this.graphicComponent.addAnimation(GraphicComponent.AnimationEnum.IDLE,new Animation(1 / 16f, atlas.findRegions("mario_standing"),Animation.PlayMode.LOOP));
    }
}
