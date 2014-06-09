package org.bcsphere.utilities;


import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;

import android.content.Intent;


public class BCUtility extends CordovaPlugin{

	@Override
	public boolean execute(String action, JSONArray args,CallbackContext callbackContext) throws JSONException {
		if (action.equals("redirectToApp")) {
			String url = args.getJSONObject(0).getString("url");
			String deviceAddress = args.getJSONObject(0).getString("deviceAddress");
			String type = args.getJSONObject(0).getString("deviceType");
			String deviceName = args.getJSONObject(0).getString("deviceName");
			Intent urlIntent = new Intent();
			urlIntent.setAction("GO_ PAGE");
			urlIntent.putExtra("app_url", url);
			urlIntent.putExtra("deviceAddress", deviceAddress);
			urlIntent.putExtra("deviceType", type);
			urlIntent.putExtra("deviceName", deviceName);
			this.webView.getContext().sendBroadcast(urlIntent);
			callbackContext.success();
		}else if (action.equals("openApp")){
			//String appid = args.getJSONObject(0).getString("appid");
			//Intent appidIntent = new Intent();
			//appidIntent.setAction("APP_URL");
			//appidIntent.putExtra("appid", appid);
			//appidIntent.putExtra("app_url", appid_url.get(appid));
			//appidIntent.putExtra("deviceID", "null");
			//this.webView.getContext().sendBroadcast(appidIntent);
		} 
		
		return true;
	}
	
}
