package com.nicolasbourre.gdx.basegamesetup;

import com.badlogic.gdx.Input;
import com.badlogic.gdx.graphics.g2d.Animation;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.g2d.TextureRegion;
import com.badlogic.gdx.math.Vector2;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * Created by Christopher on 2016-11-14.
 */
public abstract class Actor {

    protected InputComponent inputComponent;
    protected GraphicComponent graphicComponent;
    protected PhysicComponent physicComponent;
    protected ActorState state;

    protected ArrayList<Command> commands;

    Actor(boolean activeKeys[], Vector2 position,SpriteBatch batch) {
        inputComponent = new InputComponent(activeKeys,this);
        physicComponent = new PhysicComponent(this,position);
        graphicComponent = new GraphicComponent(this,batch);
        state = new Idle(this);
        commands = new ArrayList<Command>();
    }

    void addCommand(Command c){
        commands.add(c);
    }

    abstract void update(float deltaTime);
    abstract void draw(float elapsedTime);

}
