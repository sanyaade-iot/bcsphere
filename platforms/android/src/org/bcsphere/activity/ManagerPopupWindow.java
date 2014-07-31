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
import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.OnLongClickListener;
import android.view.View.OnTouchListener;
import android.view.ViewGroup.LayoutParams;
import android.view.animation.TranslateAnimation;
import android.widget.PopupWindow;

@SuppressLint({ "SetJavaScriptEnabled", "NewApi" })
public class ManagerPopupWindow extends PopupWindow implements OnTouchListener{
	
	public  View managerView;
	private LayoutInflater inflater;
	public BCWebView mWebView = null;
	private Activity mActivity;
	public static String HOME_PAGE = "file:///android_asset/www/apps/homepage/appManage.html";
	
	public ManagerPopupWindow(MainActivity activity) {
		mActivity = activity;
		inflater = (LayoutInflater) activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		managerView = inflater.inflate(R.layout.popupwindow_manager, null);
		mWebView = (BCWebView) managerView.findViewById(R.id.webViewManager);
		mWebView.getSettings().setJavaScriptEnabled(true);
		mWebView.setWebViewClient(new BCWebViewClient(activity));
		mWebView.loadUrl(HOME_PAGE);
		mWebView.setOnLongClickListener(new OnLongClickListener() {
			
			@Override
			public boolean onLongClick(View arg0) {
				return true;
			}
		});
		
		this.setContentView(managerView);
		this.setWidth(LayoutParams.MATCH_PARENT);
		this.setHeight(LayoutParams.WRAP_CONTENT);
		this.setFocusable(true);
		this.setAnimationStyle(R.style.ManagerPopupWindow_Anim_Style);
		managerView.setOnTouchListener(this);
	}

	@Override
	public boolean onTouch(View arg0, MotionEvent arg1) {
		if (this.isShowing()) {
			this.dismiss();
			TranslateAnimation animation = new TranslateAnimation(0, 0, (float) (BCPage.getScreenHeight(mActivity) * (430.0 / 1920.0)), 0 );
			animation.setDuration(200);
			animation.setFillAfter(true);
			PageManager.getCurrentPager().parentView.startAnimation(animation);
		}
		return true;
	}
}
