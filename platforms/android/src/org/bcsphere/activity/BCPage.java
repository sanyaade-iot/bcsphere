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

import org.bcsphere.bluetooth.tools.Tools;
import org.bcsphere.components.BCWebView;
import org.bcsphere.components.BCWebViewClient;

import com.umeng.analytics.MobclickAgent;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.provider.Settings;
import android.support.v4.app.Fragment;
import android.util.DisplayMetrics;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.View.OnLongClickListener;
import android.view.ViewGroup;
import android.view.animation.TranslateAnimation;
import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.widget.Button;
import android.widget.ProgressBar;
import android.widget.RelativeLayout;
import android.widget.TextView;

@SuppressLint({ "ValidFragment", "SetJavaScriptEnabled", "NewApi", "HandlerLeak" })
public class BCPage extends Fragment implements OnClickListener{

	public View parentView = null ;
	public Button btnManager = null ,btnMenu  = null,btnBack = null;
	private MainActivity mActivity = null;
	private MenuPopupWindow menuPopupWindow = null;
	public TextView textAppName = null;
	private TextView hintOpenBluetooth = null;
	private TextView hintOpenNetwork = null;
	public ProgressBar mProgressBar = null;
	public BCWebView mWebView = null;
	public String url = null;
	public String deviceName = null;
	public String deviceAddress = null;
	public String deviceType = null;
	public String appName = null;
	public boolean isLoaded = false;
	private RelativeLayout linHint = null;
	public Button closePage = null;
	private View view;
	
	public BCPage(MainActivity activity ,String url ,String isTemporary) {
		this.url = url;
		mActivity = activity;
		initParentView(R.layout.child_controls_homepage);
		initWebView();
		closePage = (Button) parentView.findViewById(R.id.btnClose);
		linHint = (RelativeLayout) parentView.findViewById(R.id.layoutLint);
		hintOpenBluetooth  =  (TextView) parentView.findViewById(R.id.hintOpenBluetooth);
		hintOpenNetwork = (TextView) parentView.findViewById(R.id.hintOpenNetwork);
		if (isTemporary.equals("true")) {
			closePage.setVisibility(View.VISIBLE);
		}
		closePage.setOnClickListener(this);
		hintOpenBluetooth.setOnClickListener(this);
		hintOpenNetwork.setOnClickListener(this);
	}

	public BCPage(MainActivity activity ,String url, String deviceName, String deviceAddress, String deviceType , String appName) {
		mActivity  = activity;
		this.url = url;
		this.deviceName = deviceName;
		this.deviceAddress = deviceAddress;
		this.deviceType = deviceType;
		this.appName = appName;

		initParentView(R.layout.child_controls_application);
		initWebView();
		btnManager = (Button) parentView.findViewById(R.id.btnManager);
		btnMenu = (Button) parentView.findViewById(R.id.btnMenu);
		btnBack = (Button) parentView.findViewById(R.id.btnBack);
		textAppName = (TextView) parentView.findViewById(R.id.textAppName);
		mProgressBar =  (ProgressBar) parentView.findViewById(R.id.progressBar);
		linHint = (RelativeLayout) parentView.findViewById(R.id.layoutLint);
		hintOpenBluetooth  =  (TextView) parentView.findViewById(R.id.hintOpenBluetooth);
		hintOpenNetwork = (TextView) parentView.findViewById(R.id.hintOpenNetwork);
		view = parentView.findViewById(R.id.view);
		btnManager.setOnClickListener(this);
		btnMenu.setOnClickListener(this);
		btnBack.setOnClickListener(this);
		hintOpenBluetooth.setOnClickListener(this);
		hintOpenNetwork.setOnClickListener(this);
		textAppName.setText(appName);
	}

	private void initParentView(int controlId){
		LayoutInflater inflater = LayoutInflater.from(mActivity);
		parentView = inflater.inflate(controlId, null);
	}

	private void initWebView(){
		mWebView= (BCWebView) parentView.findViewById(R.id.webChildControls);
		mWebView.getSettings().setJavaScriptEnabled(true);
		mWebView.setWebChromeClient(new BCWebChromeClient());
		mWebView.setWebViewClient(new BCWebViewClient(mActivity));
		mWebView.page = this;
		mWebView.setOnLongClickListener(new OnLongClickListener() {

			@Override
			public boolean onLongClick(View arg0) {
				return true;
			}
		});
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		return parentView;
	}

	@Override
	public void onActivityCreated(Bundle savedInstanceState) {
		super.onActivityCreated(savedInstanceState);
		mWebView.loadUrl(url);
	}

	@Override
	public void onStart() {
		super.onStart();
		
		IntentFilter intentFilter = new IntentFilter();
		intentFilter.addAction(BluetoothAdapter.ACTION_STATE_CHANGED);
		intentFilter.addAction(ConnectivityManager.CONNECTIVITY_ACTION);
		mActivity.registerReceiver(mReceiver, intentFilter);
	}

	@Override
	public void onResume() {
		super.onResume();
		MobclickAgent.onPageStart("MainScreen");
		new Thread(detectionRunnable).start();
	}

	@Override
	public void onPause() {
		super.onPause();
		MobclickAgent.onPageEnd("MainScreen");
	}
	
	@Override
	public void onDestroy() {
		super.onDestroy();
		mActivity.unregisterReceiver(mReceiver);
	}
	
	@Override
	public void onClick(View v) {
		switch (v.getId()) {
		case R.id.btnManager:
			mActivity.managerPopupWindow.showAsDropDown(view , 0, 0);
			TranslateAnimation animation = new TranslateAnimation(0, 0, 0, (float) (getScreenHeight(mActivity) * (430.0 / 1920.0)));
			animation.setDuration(200);
			animation.setFillAfter(true);
			parentView.startAnimation(animation);
			break;

		case R.id.btnMenu:
			if (menuPopupWindow == null) {
				menuPopupWindow = new MenuPopupWindow(mActivity);
			}
			if (menuPopupWindow.isShowing()) {
				menuPopupWindow.dismiss();
				return;
			}
			menuPopupWindow.showAsDropDown(btnMenu,0,20);
			break;
		case R.id.btnBack:
			mWebView.goBack();
			break;
		case R.id.btnClose:
			Intent intent = new Intent();
			intent.setAction("removeApp");
			intent.putExtra("removeAppURL", PageManager.getCurrentPager().url);
			mActivity.sendBroadcast(intent);
			PageManager.setDeleteUrl(PageManager.getCurrentPager().url);
			break;
		case R.id.hintOpenBluetooth:
			startActivity(new Intent(Settings.ACTION_BLUETOOTH_SETTINGS));
			break;
		case R.id.hintOpenNetwork:
			startActivity(new Intent(Settings.ACTION_SETTINGS));
			break;
		}
	}



	Handler mHandler = new Handler(){

		@Override
		public void handleMessage(Message msg) {
			super.handleMessage(msg);
			if (mProgressBar != null) {
				mProgressBar.setProgress(msg.arg1);
			}
		}
	};

	private class BCWebChromeClient extends WebChromeClient{
		@Override
		public void onProgressChanged(WebView view, int newProgress) {
			super.onProgressChanged(view, newProgress);
			Message msg =new Message();
			msg.arg1 = newProgress;
			mHandler.sendMessage(msg);
		}
	}

	BroadcastReceiver mReceiver = new BroadcastReceiver() {
		
		@Override
		public void onReceive(Context context, Intent intent) {
			if (intent.getAction().equals(BluetoothAdapter.ACTION_STATE_CHANGED)) {
				if (intent.getIntExtra(BluetoothAdapter.EXTRA_PREVIOUS_STATE, -1) == 11) {
					if (hintOpenBluetooth.getVisibility() == View.VISIBLE) {
						hintOpenBluetooth.setVisibility(View.GONE);
					}
					if (hintOpenNetwork.getVisibility() == View.GONE && linHint.getVisibility() == View.VISIBLE) {
						linHint.setVisibility(View.GONE);
					}
				}
				if (intent.getIntExtra(BluetoothAdapter.EXTRA_PREVIOUS_STATE, -1) == 13) {
					if (linHint.getVisibility() == View.GONE) {
						linHint.setVisibility(View.VISIBLE);
					}
					if (hintOpenBluetooth.getVisibility() == View.GONE) {
						hintOpenBluetooth.setVisibility(View.VISIBLE);
					}
				}
			}
			
			if (intent.getAction().equals(ConnectivityManager.CONNECTIVITY_ACTION)) {
				if (isNetworkConnected(mActivity.getApplicationContext())) {
					if (hintOpenNetwork.getVisibility() == View.VISIBLE) {
						hintOpenNetwork.setVisibility(View.GONE);
					}
					if (hintOpenBluetooth.getVisibility() == View.GONE && linHint.getVisibility() == View.VISIBLE) {
						linHint.setVisibility(View.GONE);
					}
				}else {
					if (linHint.getVisibility() == View.GONE) {
						linHint.setVisibility(View.VISIBLE);
					}
					if (hintOpenNetwork.getVisibility() == View.GONE) {
						hintOpenNetwork.setVisibility(View.VISIBLE);
					}
				}
			}
		}
	};
	
	Runnable detectionRunnable = new Runnable() {
		
		@Override
		public void run() {
			try {
				Thread.sleep(3000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			Message msg = new Message();
			msg.arg1 = 1;
			mHandler2.sendMessage(msg);
		}
	};
	
	Handler mHandler2 = new Handler(){
		public void handleMessage(Message msg) {
			super.handleMessage(msg);
			if (msg.arg1 == 1) {
				detectionBluetoothState();
				detectionNetworkState();
			}
		};
	};
	
	private void detectionBluetoothState(){
		if (!Tools.getBluetoothState()) {
			if (linHint.getVisibility() == View.GONE) {
				linHint.setVisibility(View.VISIBLE);
			}
			if (hintOpenBluetooth.getVisibility() == View.GONE) {
				hintOpenBluetooth.setVisibility(View.VISIBLE);
			}
		}
	}
	
	private void detectionNetworkState(){
		if (!isNetworkConnected(mActivity.getApplicationContext())) {
			if (linHint.getVisibility() == View.GONE) {
				linHint.setVisibility(View.VISIBLE);
			}
			if (hintOpenNetwork.getVisibility() == View.GONE) {
				hintOpenNetwork.setVisibility(View.VISIBLE);
			}
		}
	}
	
	public static int dipToPx(Context context , float dipValue){
		float proportion = context.getResources().getDisplayMetrics().density;
		int pxValue = (int) (proportion * dipValue + 0.5f);
		return pxValue;
	}
	
	public static int getScreenHeight(Activity activity){
		DisplayMetrics displayMetrics = new DisplayMetrics();
		activity.getWindowManager().getDefaultDisplay().getMetrics(displayMetrics);
		return displayMetrics.heightPixels;
	}
	
	public static boolean isNetworkConnected(Context context){
		ConnectivityManager  manager = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
		if (manager != null) {
			NetworkInfo networkInfo = manager.getActiveNetworkInfo();
			if (networkInfo != null && networkInfo.isConnected()) {
				if (networkInfo.getState() == NetworkInfo.State.CONNECTED) {
					return true;
				}
			}
		}
		return false;
	}
}	
