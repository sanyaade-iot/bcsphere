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

package org.bcsphere.bclog;

import java.io.BufferedReader;
import java.io.InputStreamReader;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.PluginResult;
import org.bcsphere.bluetooth.tools.Tools;
import org.json.JSONObject;

public class DebugRunnable implements Runnable {

	private CallbackContext	 mCallback = null;
	private static boolean onOrOff = false; 
	private String[] filterLog = {"logcat","BtGatt.GattService:v *:S","BtGatt.btif:v *:S","bt-l2cap:v *:S",
			"BtGatt.ContextMap:v *:S","bt-btm:v *:S","BluetoothConnextionReceiver:v *:S",
			"BluetoothAdapter:v *:S","bt-hci:v *:S"	,"BluetoothAdapterProperties:v *:S",
			"BluetoothDiscoveryReceiver:v *:S","BluttoothAdapterService(1113544512):v *:S",
			"BluetoothGatt:v *:S","BluetoothManagerService:v *:S","LocalBluetoothProfileManager:v *:S",
			"BluetoothA2dp:v *:S","A2dpProfile:v *:S","BluetoothHeadset:v *:S","HeadsetProfile:v *:S",
			"BluetoothInputDevice:v *:S","HidProfile:v *:S","BluetoothPan:v *:S","PanProfile:v *:S",
			"BluetoothMap:v *:S","MapProfile:v *:S","BluetoothPbap:v *:S","PbapServerProfile:v *:S",
			"bt-smp:v *:S"	,"BluetoothEventManager:v *:S","BtGatt.BluetoothGatt:v *:S",
			"BluetoothGattCallback:v *:S","BluetoothGattCharacteristic:v *:S","BluetoothGattDescriptor:v *:S",
			"BluetoothGattServer:v *:S","BluetoothGattServerCallback:v *:S","BluetoothGattService:v *:S",
			"BluetoothGattServiceCallback:v *:S","BluetoothManager:v *:S","BluetoothServerSocket:v *:S",
			"BluetoothSocket:v *:S","BluetoothG43plus:v *:S","BluetoothSam42:v *:S","BluetoothSerialService:v *:S",
			"BCBluetooth:v *:S"};
	
	public DebugRunnable(CallbackContext callback) {
		mCallback = callback;
		onOrOff = true;
	}
	
	@Override
	public void run() {
		Process mLogcatProc = null;
		BufferedReader reader = null;
		try {
			mLogcatProc = Runtime.getRuntime().exec(filterLog);
			reader = new BufferedReader(new InputStreamReader(mLogcatProc.getInputStream()));
			String line;
		while (onOrOff) {
			line = reader.readLine();
			if (line != null) {
				JSONObject obj = new JSONObject();
				Tools.addProperty(obj, Tools.DATE, line);
				PluginResult pluginResult = new PluginResult(PluginResult.Status.OK);
				pluginResult.setKeepCallback(true);
				mCallback.sendPluginResult(pluginResult);
			}
		}	
		} catch (Exception e) {
			e.printStackTrace();
		}
		mCallback = null;
	}

	public static void stop() {
		DebugRunnable.onOrOff = false;;
	}
	
	
}
