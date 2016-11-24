package com.nicolasbourre.gdx.basegamesetup;

/**
 * Created by Christopher on 2016-11-14.
 */
public class Courir extends ActorState {

    Actor actor;

    Courir(Actor actor) {
        this.actor = actor;
        actor.graphicComponent.currentAnimation(GraphicComponent.AnimationEnum.COURIR);

    }

    public void update(float deltaTime){
        if(actor.physicComponent.velocity.x < 10)
            actor.physicComponent.velocity.x++;
        if(actor.physicComponent.velocity.y > 0)
            actor.physicComponent.velocity.y--;
    }

    public String toString(){return "courir";}
    public void exitState(){

    }
}
