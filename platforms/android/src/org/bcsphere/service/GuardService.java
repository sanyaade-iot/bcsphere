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
package org.bcsphere.service;

import java.util.List;
import android.app.ActivityManager;
import android.app.ActivityManager.RunningServiceInfo;
import android.app.Service;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Binder;
import android.os.IBinder;

public class GuardService extends Service {
	private final IBinder myIBinder = new GuardBinder();

	public class GuardBinder extends Binder{
		public GuardBinder() {
		}
	}

	@Override
	public IBinder onBind(Intent arg0) {
		return myIBinder;
	}

	@Override
	public void onCreate() {
		super.onCreate();
		IntentFilter intentFilter = new IntentFilter(Intent.ACTION_TIME_TICK);
		registerReceiver(receiver, intentFilter);
	}

	@Override
	public void onDestroy() {
		super.onDestroy();
		unregisterReceiver(receiver);
	}

	@Override
	public int onStartCommand(Intent intent, int flags, int startId) {
		return START_STICKY;
	}

	private final BroadcastReceiver receiver = new BroadcastReceiver() {

		@Override
		public void onReceive(Context context, Intent intent) {
			if (!isServiceRunning(context, "org.bcsphere.service.BCService")) {
				context.startService(new Intent(context,BCService.class));
			}
		}
	};

	public  static boolean isServiceRunning(Context context,String className){
		boolean isServiceRunning = false;
		ActivityManager am = ((ActivityManager)context.getSystemService(Context.ACTIVITY_SERVICE));
		List<RunningServiceInfo> list = am.getRunningServices(200);
		for(RunningServiceInfo info : list){
			if (info.service.getClassName().equals(className)) {
				isServiceRunning = true;
			}
		}
		return isServiceRunning;
	}
}
