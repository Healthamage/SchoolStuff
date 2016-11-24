package com.nicolasbourre.gdx.basegamesetup;

/**
 * Created by Christopher on 2016-11-14.
 */
public class CourirCommand extends Command  {

    void execute(Actor actor){

        if(actor.state.toString().equals("idle") || actor.state.toString().equals("marcher") ){
            actor.state.exitState();
            actor.state = new Courir(actor);
        }
    }
}
