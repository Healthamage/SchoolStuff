package com.nicolasbourre.gdx.basegamesetup;

import com.badlogic.gdx.math.Vector2;

/**
 * Created by Christopher on 2016-11-14.
 */
public class PhysicComponent extends Component {

    enum Direction{LEFT,RIGHT}

    private Actor actor;
    protected Vector2 velocity;
    protected Vector2 position;
    protected float speedFactor;
    private Direction dir;

    PhysicComponent(Actor actor, Vector2 position){
        this.position = position;
        this.actor = actor;
        this.velocity = new Vector2(0,0);
    }

    public void update(float deltaTime){

        if(dir == Direction.LEFT)
            position.add(velocity.x * -1 , velocity.y);
        else
            position.add(velocity.x  , velocity.y);
    }
    boolean isFloorColliding(){
        if(position.y < 0)
            return true;
        return false;
    }

    public Direction dir(){return dir;}
    public void dir(Direction dir){this.dir = dir;}
}
