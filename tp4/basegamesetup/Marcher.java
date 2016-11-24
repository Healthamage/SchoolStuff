package com.nicolasbourre.gdx.basegamesetup;

/**
 * Created by Christopher on 2016-11-14.
 */
public class Marcher extends ActorState{

    Actor actor;
    Marcher(Actor actor) {

        this.actor = actor;
        actor.physicComponent.speedFactor = 1f;
        actor.graphicComponent.currentAnimation(GraphicComponent.AnimationEnum.MARCHER);
        if(actor.physicComponent.velocity.x > 3)
            actor.physicComponent.velocity.x = 3;

    }

    public void update(float deltaTime){
        if(actor.physicComponent.velocity.x < 3)
            actor.physicComponent.velocity.x++;
        if(actor.physicComponent.velocity.y > 0)
            actor.physicComponent.velocity.y--;


    }

    public String toString(){return "marcher";}
    public void exitState(){}
}
