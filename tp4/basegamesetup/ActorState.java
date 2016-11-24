package com.nicolasbourre.gdx.basegamesetup;

/**
 * Created by Christopher on 2016-11-14.
 */
public abstract class ActorState {

    protected GraphicComponent graphicComponent;
    protected PhysicComponent physicComponent;
    protected Actor actor;


    ActorState() {

    }
    public abstract void update(float deltaTime);


    public abstract String toString();
    public abstract void exitState();
}
