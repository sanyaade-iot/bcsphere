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

import org.bcsphere.components.BCWebView;
import org.bcsphere.components.BCWebViewClient;
import android.annotation.SuppressLint;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.View.OnLongClickListener;
import android.view.ViewGroup;
import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.widget.Button;
import android.widget.ProgressBar;
import android.widget.TextView;

@SuppressLint({ "ValidFragment", "SetJavaScriptEnabled", "NewApi", "HandlerLeak" })
public class BCPage extends Fragment implements OnClickListener{

	private View parentView = null ;
	private Button btnHomePage = null ,btnMore  = null;
	private MainActivity mActivity = null;
	public TextView textDeviceName = null;
	public ProgressBar mProgressBar = null;
	public BCWebView mWebView = null;
	public String url = null;
	public String deviceName = null;
	public String deviceAddress = null;
	public String deviceType = null;
	public boolean isLoaded = false;

	public BCPage(MainActivity activity ,String url) {
		this.url = url;
		mActivity = activity;

		initParentView(R.layout.child_controls_homepage);
		initWebView();
	}

	public BCPage(MainActivity activity ,String url, String deviceName, String deviceAddress, String deviceType) {
		mActivity  = activity;
		this.url = url;
		this.deviceName = deviceName;
		this.deviceAddress = deviceAddress;
		this.deviceType = deviceType;

		initParentView(R.layout.child_controls_application);
		initWebView();
		btnHomePage = (Button) parentView.findViewById(R.id.btnHomePage);
		btnMore = (Button) parentView.findViewById(R.id.btnMore);
		textDeviceName = (TextView) parentView.findViewById(R.id.textShowName);
		mProgressBar =  (ProgressBar) parentView.findViewById(R.id.progressBar);
		btnHomePage.setOnClickListener(this);
		btnMore.setOnClickListener(this);
		textDeviceName.setText(deviceName);
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
	public void onDestroy() {
		if (mWebView != null){
			mWebView = null;
		}
		super.onDestroy();
	}

	@Override
	public void onClick(View v) {
		switch (v.getId()) {
		case R.id.btnHomePage:
			Intent intent = new Intent("GO_HOMEPAGE");
			intent.putExtra("url", url );
			mActivity.sendBroadcast(intent);
			break;

		case R.id.btnMore:
			
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
}	
