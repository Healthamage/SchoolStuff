package com.nicolasbourre.gdx.basegamesetup;

/**
 * Created by Christopher on 2016-11-14.
 */
public class Idle extends ActorState {

    Actor actor;

    Idle(Actor actor) {
        this.actor = actor;
        actor.graphicComponent.currentAnimation(GraphicComponent.AnimationEnum.IDLE);

        actor.physicComponent.velocity.x = 0;
        actor.physicComponent.velocity.y = 0;
    }

    public void update(float deltaTime){


    }

    public String toString(){return "idle";}
    public void exitState(){

    }
}
