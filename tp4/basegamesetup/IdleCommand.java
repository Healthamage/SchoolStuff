package com.nicolasbourre.gdx.basegamesetup;

/**
 * Created by Christopher on 2016-11-14.
 */
public class IdleCommand extends Command {

    void execute(Actor actor){

        if(!actor.state.toString().equals("sauter")){
            actor.state.exitState();
            actor.state = new Idle(actor);
        }
    }
}
