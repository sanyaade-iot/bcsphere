package org.bcsphere.bclog;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;

public class BCLog extends CordovaPlugin{

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        
        if(action.equals("trace")){
            new Thread(new DebugRunnable(callbackContext)).start();
        }
        
        return true;
    }

}
