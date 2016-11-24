package com.nicolasbourre.gdx.basegamesetup;

import com.badlogic.gdx.Input;

/**
 * Created by Christopher on 2016-11-14.
 */
public class InputComponent extends Component {

    private boolean activeKeys[];
    private Actor actor;

    InputComponent(boolean activeKeys[],Actor actor) {
        this.activeKeys = activeKeys;
        this.actor = actor;
    }

    void update(float deltaTime){


        if (activeKeys[Input.Keys.LEFT]) {
            actor.physicComponent.dir(PhysicComponent.Direction.LEFT);
            actor.addCommand(new MarcherCommand());
        }
        else if (activeKeys[Input.Keys.RIGHT]) {
            actor.physicComponent.dir(PhysicComponent.Direction.RIGHT);
            actor.addCommand(new MarcherCommand());
        }
        else{
            actor.addCommand(new IdleCommand());
        }

        if (activeKeys[Input.Keys.SHIFT_LEFT] && (activeKeys[Input.Keys.RIGHT] || activeKeys[Input.Keys.LEFT]))
            actor.addCommand(new CourirCommand());

        if (activeKeys[Input.Keys.SPACE])
            actor.addCommand(new SauterCommand());

    }
}
