/*
	Copyright 2013-2014, JUMA Technology

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

		http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
 */

package org.bcsphere.activity;

import org.apache.cordova.CordovaActivity;

import com.umeng.analytics.MobclickAgent;

import android.annotation.SuppressLint;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.animation.TranslateAnimation;

@SuppressLint("NewApi")
public class MainActivity extends CordovaActivity {

	private PageManager pageManager = null;
	public ManagerPopupWindow managerPopupWindow;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		MobclickAgent.openActivityDurationTrack(false);
		MobclickAgent.updateOnlineConfig(this);

		pageManager = new PageManager(MainActivity.this);
		managerPopupWindow = new ManagerPopupWindow(this);

	}

	@Override
	protected void onStart() {
		super.onStart();
		IntentFilter mFilter = new IntentFilter();
		mFilter.addAction("OPEN_APPLICATION");
		mFilter.addAction("OPEN_ALL_APPLICATION");
		registerReceiver(mReceiver, mFilter);
	}

	@Override
	public void onDestroy() {
		super.onDestroy();
		unregisterReceiver(mReceiver);
		managerPopupWindow.mWebView.handleDestroy();
		pageManager.Destroy();
	}

	@Override
	protected void onPause() {
		super.onPause();
		MobclickAgent.onPause(this);
	}

	public Context  getContext(){
		return MainActivity.this.getApplicationContext();
	}

	@Override
	protected void onResume() {
		super.onResume();
		MobclickAgent.onResume(this);
	}

	BroadcastReceiver mReceiver = new BroadcastReceiver() {

		@Override
		public void onReceive(Context context, Intent intent) {

			if (managerPopupWindow.isShowing()) {
				managerPopupWindow.dismiss();
				if (pageManager.getCurrentPager()!=null) {
					TranslateAnimation animation = new TranslateAnimation(0, 0, (float) (BCPage.getScreenHeight(MainActivity.this) * (430.0 / 1920.0)), 0 );
					animation.setDuration(200);
					animation.setFillAfter(true);
					pageManager.getCurrentPager().parentView.startAnimation(animation);
				}
			}

			if (intent.getAction().equals("OPEN_ALL_APPLICATION")) {
				String url = intent.getStringExtra("app_url");
				String deviceAddress = intent.getStringExtra("deviceAddress");
				String deviceType = intent.getStringExtra("deviceType");
				String deviceName =  intent.getStringExtra("deviceName");
				String appName =  intent.getStringExtra("appName");
				String imageURL =  intent.getStringExtra("imageURL");
				String isTemporary = intent.getStringExtra("isTemporary");

				pageManager.createPage(url, deviceName, deviceAddress, deviceType,appName);
				pageManager.showPage(url);

				Intent appInfoIntent = new Intent();
				appInfoIntent.setAction("appInfo");
				appInfoIntent.putExtra("app_url", url);
				appInfoIntent.putExtra("deviceAddress", deviceAddress);
				appInfoIntent.putExtra("deviceType", deviceType);
				appInfoIntent.putExtra("deviceName", deviceName);
				appInfoIntent.putExtra("appName", appName);
				appInfoIntent.putExtra("isTemporary", isTemporary);
				appInfoIntent.putExtra("imageURL", imageURL);
				sendBroadcast(appInfoIntent);
			}

			if (intent.getAction().equals("OPEN_APPLICATION")){
				String url = intent.getStringExtra("app_url");
				String deviceAddress = intent.getStringExtra("deviceAddress");
				String deviceType = intent.getStringExtra("deviceType");
				String deviceName =  intent.getStringExtra("deviceName");
				String appName =  intent.getStringExtra("appName");
				String imageURL =  intent.getStringExtra("imageURL");
				String isTemporary = intent.getStringExtra("isTemporary");
				String index = intent.getStringExtra("index");

				if(url.contains("bclog")){
					return;
				}

				if (!pageManager.contains(url) && url.length() >0 && !url.equals(PageManager.SCAN_URL)) {
					pageManager.createPage(url, deviceName, deviceAddress, deviceType,appName);
					pageManager.showPage(url);
					if (pageManager.contains(PageManager.SCAN_URL)) {
						pageManager.destroyPage(PageManager.SCAN_URL);
					}
				}else if(!pageManager.contains(url) && url.length() >0 && url.equals(PageManager.SCAN_URL)){//create scan page
					pageManager.createPage(url,isTemporary);

				}else if (pageManager.contains(url) && !pageManager.currentUrl.equals(url) && !url.equals(PageManager.SCAN_URL)) {
					pageManager.showPage(url);
					if (pageManager.contains(PageManager.SCAN_URL)) {
						pageManager.destroyPage(PageManager.SCAN_URL);
					}
				}

				if (!PageManager.getDeleteUrl().equals("")) {
					pageManager.destroyPage(PageManager.getDeleteUrl());
					PageManager.setDeleteUrl("");
				}

				Intent appInfoIntent = new Intent();
				appInfoIntent.setAction("appInfo");
				appInfoIntent.putExtra("app_url", url);
				appInfoIntent.putExtra("deviceAddress", deviceAddress);
				appInfoIntent.putExtra("deviceType", deviceType);
				appInfoIntent.putExtra("deviceName", deviceName);
				appInfoIntent.putExtra("appName", appName);
				appInfoIntent.putExtra("isTemporary", isTemporary);
				appInfoIntent.putExtra("imageURL", imageURL);
				appInfoIntent.putExtra("index", index);
				sendBroadcast(appInfoIntent);
			}
		}
	};

	public boolean onKeyDown(int keyCode, android.view.KeyEvent event) {
		if (keyCode == KeyEvent.KEYCODE_BACK) {
			Intent intent=new Intent(Intent.ACTION_MAIN);
			intent.addCategory(Intent.CATEGORY_HOME);
			startActivity(intent);
		}
		return true;
	};
}
