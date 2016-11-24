package com.nicolasbourre.gdx.basegamesetup;

/**
 * Created by Christopher on 2016-11-14.
 */
public class Sauter extends ActorState{

    Actor actor;

    Sauter(Actor actor) {

        this.actor = actor;
        actor.physicComponent.velocity.y = 2;

    }

    public void update(float deltaTime){
        if(actor.physicComponent.velocity.y > -2)
            actor.physicComponent.velocity.y -= 0.1;


        if (actor.physicComponent.velocity.y < 0  && actor.physicComponent.isFloorColliding()) {
            exitState();
            actor.physicComponent.position.y = 0 ;
        }
    }

    public String toString(){return "sauter";}
    public void exitState(){
        actor.state = new Idle(actor);

    }
}
