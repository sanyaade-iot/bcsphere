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

package org.bcsphere.components;

import java.io.InputStream;
import android.annotation.TargetApi;
import android.graphics.Bitmap;
import android.net.http.SslError;
import android.view.View;
import android.webkit.SslErrorHandler;
import android.webkit.WebView;

import org.apache.cordova.CordovaWebViewClient;
import org.apache.http.util.EncodingUtils;
import org.bcsphere.activity.BCPage;
import org.bcsphere.activity.MainActivity;
import org.bcsphere.activity.ManagerPopupWindow;
import org.bcsphere.activity.PageManager;

public class BCWebViewClient extends CordovaWebViewClient
{

	private MainActivity mMainActivity;

	public BCWebViewClient(MainActivity mainActivity)
	{
		super(mainActivity);
		mMainActivity = mainActivity;
	}

	public void onPageStarted(WebView view, String url, Bitmap favicon)
	{
		super.onPageStarted(view, url, favicon);

		if (PageManager.getCurrentPager() != null) {
			System.out.println(PageManager.getCurrentPager().url);
		}		

		BCPage page = PageManager.getPage(url);
		if (page != null) {
			if (page.mProgressBar != null && page.mProgressBar.getVisibility() == View.INVISIBLE) {
				page.mProgressBar.setProgress(0);
				page.mProgressBar.setVisibility(View.VISIBLE);
			}
		}
	}

	@Override
	public void onPageFinished(WebView view, String url)
	{
		super.onPageFinished(view, url);
		BCPage page = PageManager.getPage(url);
		if (page != null) {
			if (page.mProgressBar != null && page.mProgressBar.getVisibility() == View.VISIBLE) {
				page.mProgressBar.setProgress(0);
				page.mProgressBar.setVisibility(View.INVISIBLE);
			}
		}
		if (url.equals(ManagerPopupWindow.MANAGE)) {
			String jsWrapper = "eval(%s)";
			String perfix = "www";
			injectDeferredObject(readFileContent(perfix + "/cordova.js"), jsWrapper,view);
		}

		if(null != page && !page.isLoaded){
			String jsWrapper = "eval(%s)";
			String perfix = "www";
			injectDeferredObject(readFileContent(perfix + "/cordova.js"), jsWrapper,view);
			PageManager.getPage(url).isLoaded = true;
		}
	}	

	@Override
	@TargetApi(8)
	public void onReceivedSslError(WebView view, SslErrorHandler handler,
			SslError error) {
		super.onReceivedSslError(view, handler, error);
	}

	private String readFileContent(String path){ 
		String result="";  
		try{  
			InputStream in = this.mMainActivity.getResources().getAssets().open(path); 
			int length = in.available();                                    
			byte [] buffer = new byte[length];                              
			in.read(buffer);                                               
			result = EncodingUtils.getString(buffer, "UTF-8");            
		}  
		catch(Exception e){  
			e.printStackTrace();                                            
		}  
		return result;  
	}


	private void injectDeferredObject(String source,String jsWrapper,final WebView view) {
		String scriptToInject;
		if (jsWrapper != null) {
			org.json.JSONArray jsonEsc = new org.json.JSONArray();
			jsonEsc.put(source);
			String jsonRepr = jsonEsc.toString();
			String jsonSourceString = jsonRepr.substring(1, jsonRepr.length()-1);
			scriptToInject = String.format(jsWrapper, jsonSourceString);
		} else {
			scriptToInject = source;
		}
		final String finalScriptToInject = scriptToInject;
		cordova.getActivity().runOnUiThread(new Runnable() {
			@Override
			public void run() {
				view.loadUrl("javascript:" + finalScriptToInject);
			}
		});
	}

	@Override
	public boolean shouldOverrideUrlLoading(WebView view, String url) {
		view.loadUrl(url);
		return true;
	}	

	@Override
	public void onReceivedError(WebView view, int errorCode,
			String description, String failingUrl) {
		super.onReceivedError(view, errorCode, description, failingUrl);
	}

}
