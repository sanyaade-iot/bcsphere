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
import org.bcsphere.service.BCService;
import org.bcsphere.service.GuardService;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;

public class MainActivity extends CordovaActivity {

	private PageManager pageManager = null;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		if (GuardService.isServiceRunning(MainActivity.this, "org.bcsphere.service.BCService")) {
			startService(new Intent(MainActivity.this,BCService.class));
		}
		if (GuardService.isServiceRunning(MainActivity.this, "org.bcsphere.service.GuardService")) 	{
			startService(new Intent(MainActivity.this,GuardService.class));
		}

		pageManager = new PageManager(MainActivity.this);
	}

	@Override
	protected void onStart() {
		super.onStart();
		IntentFilter mFilter = new IntentFilter();
		mFilter.addAction("GO_HOMEPAGE");
		mFilter.addAction("GO_ PAGE");
		registerReceiver(mReceiver, mFilter);
	}
	
	@Override
	public void onDestroy() {
		super.onDestroy();
		unregisterReceiver(mReceiver);
	}

	BroadcastReceiver mReceiver = new BroadcastReceiver() {

		@Override
		public void onReceive(Context context, Intent intent) {
			if (intent.getAction().equals("GO_HOMEPAGE")) {
				String url = intent.getStringExtra("url");
				pageManager.destroyPage(url);
			}

			if (intent.getAction().equals("GO_ PAGE")) 	{
				String url = intent.getStringExtra("app_url");
				String deviceAddress = intent.getStringExtra("deviceAddress");
				String deviceType = intent.getStringExtra("deviceType");
				String deviceName =  intent.getStringExtra("deviceName");

				if (!pageManager.contains(url) && url.length() > 0) {
					pageManager.createPage(url, deviceName, deviceAddress, deviceType);
					pageManager.showPage(url);
				}else if(pageManager.contains(url)){
					pageManager.showPage(url);
				}
			}
		}
	};
}
