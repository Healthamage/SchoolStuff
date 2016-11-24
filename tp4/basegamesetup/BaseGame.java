package com.nicolasbourre.gdx.basegamesetup;

import com.badlogic.gdx.ApplicationAdapter;
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.InputProcessor;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.g2d.Animation;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.g2d.TextureAtlas;
import com.badlogic.gdx.graphics.g2d.TextureRegion;
import com.badlogic.gdx.math.Vector2;

import java.util.ArrayList;

public class BaseGame extends ApplicationAdapter implements InputProcessor {

    SpriteBatch batch;
    static final int NB_KEYS = 256;
    boolean activeKeys[] = new boolean[NB_KEYS];

    float deltaTime;
    float elapsedTime = 0;

    ArrayList<Actor> actors = new ArrayList<Actor>();

    @Override
    public void create() {
        batch = new SpriteBatch();
        initActiveKeys();

       actors.add(new Mario(activeKeys,new Vector2(250, 0),batch));
       // actors.add(new Homer(activeKeys,new Vector2(250, 0),batch));

        Gdx.input.setInputProcessor(this);
    }

    @Override
    public void render() {
        deltaTime = Gdx.graphics.getDeltaTime();
        elapsedTime += deltaTime;

        update(deltaTime);
        draw(elapsedTime);

    }

    private void update(float deltaTime) {
        for(Actor a : actors)
            a.update(deltaTime);
    }

    private void draw(float elapsedTime) {
        Gdx.gl.glClearColor(1, 0, 0, 1);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);


        batch.begin();
        for(Actor a : actors)
            a.draw(elapsedTime);
        batch.end();
    }

    @Override
    public void dispose() {
        batch.dispose();

    }

    @Override
    public boolean keyDown(int keycode) {
        activeKeys[keycode] = true;
        Gdx.app.log(this.getClass().getSimpleName(), "Key down --> " + keycode);
        return false;
    }

    @Override
    public boolean keyUp(int keycode) {
        activeKeys[keycode] = false;
        Gdx.app.log(this.getClass().getSimpleName(), "Key up --> " + keycode);
        return false;
    }

    @Override
    public boolean keyTyped(char character) {
        return false;
    }

    @Override
    public boolean touchDown(int screenX, int screenY, int pointer, int button) {
        return false;
    }

    @Override
    public boolean touchUp(int screenX, int screenY, int pointer, int button) {
        return false;
    }

    @Override
    public boolean touchDragged(int screenX, int screenY, int pointer) {
        return false;
    }

    @Override
    public boolean mouseMoved(int screenX, int screenY) {
        return false;
    }

    @Override
    public boolean scrolled(int amount) {
        return false;
    }

    void initActiveKeys() {
        for (int i = 0; i < activeKeys.length; i++) {
            activeKeys[i] = false;
        }
    }

}