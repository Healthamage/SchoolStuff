package com.nicolasbourre.gdx.basegamesetup;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.Input;
import com.badlogic.gdx.graphics.Texture;
import com.badlogic.gdx.graphics.g2d.Animation;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.g2d.TextureAtlas;
import com.badlogic.gdx.graphics.g2d.TextureRegion;
import com.badlogic.gdx.math.Vector2;

import java.util.HashMap;

/**
 * Created by nbourre on 2016-11-11.
 */

public class Homer extends Actor{


    Homer(boolean activeKeys[], Vector2 position,SpriteBatch batch){
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
        TextureAtlas atlasWalking = new TextureAtlas("homer_walking.txt");
        this.graphicComponent.addAnimation(GraphicComponent.AnimationEnum.MARCHER, new Animation(1 / 8f, atlasWalking.getRegions(),Animation.PlayMode.LOOP));

        TextureAtlas atlasRunning = new TextureAtlas("homer_running.txt");
        this.graphicComponent.addAnimation(GraphicComponent.AnimationEnum.COURIR, new Animation(1 / 8f, atlasRunning.getRegions(),Animation.PlayMode.LOOP));

        TextureAtlas atlasStanding = new TextureAtlas("homer_standing.txt");
        this.graphicComponent.addAnimation(GraphicComponent.AnimationEnum.IDLE, new Animation(1 / 8f, atlasStanding.getRegions(),Animation.PlayMode.LOOP));

    }

}
