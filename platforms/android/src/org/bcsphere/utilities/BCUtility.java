package org.bcsphere.utilities;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.util.Log;

public class BCUtility extends CordovaPlugin{

	private CallbackContext AppManageCallback;
	private CallbackContext removeCallback;
	private Context mContext;
	
	@Override
	public void initialize(CordovaInterface cordova, CordovaWebView webView) {
		super.initialize(cordova, webView);
		mContext = cordova.getActivity().getApplicationContext();
	}
	
	@Override
	public boolean execute(String action, JSONArray args,CallbackContext callbackContext) throws JSONException {
		if (action.equals("redirectToApp")) {
			String url = args.getJSONObject(0).getString("url");
			String deviceAddress = args.getJSONObject(0).getString("deviceAddress");
			String deviceType = args.getJSONObject(0).getString("deviceType");
			String deviceName = args.getJSONObject(0).getString("deviceName");
			String appName = args.getJSONObject(0).getString("appName");
			String imageURL = args.getJSONObject(0).getString("imageURL");
			String isTemporary  =  args.getJSONObject(0).getString("isTemporary");
			String index =  args.getJSONObject(0).getString("index");
			Intent urlIntent = new Intent();
			urlIntent.setAction("OPEN_APPLICATION");
			urlIntent.putExtra("app_url", url);
			urlIntent.putExtra("deviceAddress", deviceAddress);
			urlIntent.putExtra("deviceType", deviceType);
			urlIntent.putExtra("deviceName", deviceName);
			urlIntent.putExtra("appName", appName);
			urlIntent.putExtra("imageURL", imageURL);
			urlIntent.putExtra("isTemporary", isTemporary);
			urlIntent.putExtra("index", index);
			mContext.sendBroadcast(urlIntent);
			callbackContext.success();
		}else if (action.equals("openApp")){
			//String appid = args.getJSONObject(0).getString("appid");
			//Intent appidIntent = new Intent();
			//appidIntent.setAction("APP_URL");
			//appidIntent.putExtra("appid", appid);
			//appidIntent.putExtra("app_url", appid_url.get(appid));
			//appidIntent.putExtra("deviceID", "null");
			//this.webView.getContext().sendBroadcast(appidIntent);
		}else if(action.equals("addApp")){
			Log.i("BCUtility", "addApp");
			AppManageCallback = callbackContext;
			IntentFilter mFilter = new IntentFilter();
			mFilter.addAction("appInfo");
			mContext.registerReceiver(mReceiver, mFilter);
		}else if (action.equals("removeApp")) {
			removeCallback = callbackContext;
			IntentFilter mFilter = new IntentFilter();
			mFilter.addAction("removeApp");
			mContext.registerReceiver(mReceiver, mFilter);
		}else if(action.equals("openApps")){
			Intent urlIntent = new Intent();
			for (int i = 0; i < args.length(); i++) {
				String url = args.getJSONObject(i).getString("url");
				String deviceAddress = args.getJSONObject(i).getString("deviceAddress");
				String deviceType = args.getJSONObject(i).getString("deviceType");
				String deviceName = args.getJSONObject(i).getString("deviceName");
				String appName = args.getJSONObject(i).getString("appName");
				String imageURL = args.getJSONObject(i).getString("imageURL");
				String isTemporary  =  args.getJSONObject(i).getString("isTemporary");
				urlIntent.setAction("OPEN_ALL_APPLICATION");
				urlIntent.putExtra("app_url", url);
				urlIntent.putExtra("deviceAddress", deviceAddress);
				urlIntent.putExtra("deviceType", deviceType);
				urlIntent.putExtra("deviceName", deviceName);
				urlIntent.putExtra("appName", appName);
				urlIntent.putExtra("imageURL", imageURL);
				urlIntent.putExtra("isTemporary", isTemporary);
				mContext.sendBroadcast(urlIntent);
			};
		}
		return true;
	}

	@Override
	public void onDestroy() {
		super.onDestroy();
		mContext.unregisterReceiver(mReceiver);
	}

	BroadcastReceiver mReceiver = new BroadcastReceiver() {

		@Override
		public void onReceive(Context arg0, Intent intent) {
			if (intent.getAction().equals("appInfo")) {
				String url = intent.getStringExtra("app_url");
				String deviceAddress = intent.getStringExtra("deviceAddress");
				String deviceType = intent.getStringExtra("deviceType");
				String deviceName =  intent.getStringExtra("deviceName");
				String appName =  intent.getStringExtra("appName");
				String imageURL =  intent.getStringExtra("imageURL");
				String isTemporary = intent.getStringExtra("isTemporary");
				String index = intent.getStringExtra("index");
				JSONObject obj = new JSONObject();
				try {
					obj.put("url", url);
					obj.put("deviceAddress", deviceAddress);
					obj.put("deviceType", deviceType);
					obj.put("deviceName", deviceName);
					obj.put("appName", appName);
					obj.put("imageURL", imageURL);
					obj.put("isTemporary", isTemporary);
					obj.put("index", index);
				} catch (JSONException e) {
					e.printStackTrace();
				}
				PluginResult pluginResult = new PluginResult(PluginResult.Status.OK , obj);
				pluginResult.setKeepCallback(true);
				if (AppManageCallback != null) {
					AppManageCallback.sendPluginResult(pluginResult);
				}
			}else if (intent.getAction().equals("removeApp")) {
				String removeAppURL = intent.getStringExtra("removeAppURL");
				JSONObject obj = new JSONObject();
				try {
					obj.put("removeAppURL", removeAppURL);
				} catch (JSONException e) {
					e.printStackTrace();
				}
				PluginResult pluginResult = new PluginResult(PluginResult.Status.OK , obj);
				pluginResult.setKeepCallback(true);
				if (removeCallback != null) {
					removeCallback.sendPluginResult(pluginResult);
				}
			}
		}
	};
}
