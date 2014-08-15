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

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.View.OnTouchListener;
import android.view.ViewGroup;
import android.view.ViewGroup.LayoutParams;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.BaseAdapter;
import android.widget.ListView;
import android.widget.PopupWindow;
import android.widget.TextView;

@SuppressLint("ViewConstructor")
public class MenuPopupWindow extends PopupWindow implements OnItemClickListener,OnTouchListener{

	private View  menuView;
	private ListView mListView;
	private String[] menus = null;
	private LayoutInflater inflater;
	private Activity mActivity;

	public MenuPopupWindow(Activity activity) {
		menus = new String[]{activity.getString(R.string.remove)};
		mActivity = activity;
		inflater = (LayoutInflater) activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		menuView = inflater.inflate(R.layout.popupwindow_menu, null);
		mListView = (ListView) menuView.findViewById(R.id.listMenu);
		mListView.setOnItemClickListener(this);
		mListView.setAdapter(new listViewAdapter());
		
		this.setContentView(menuView);
		this.setWidth(LayoutParams.WRAP_CONTENT);
		this.setHeight(LayoutParams.WRAP_CONTENT);
		this.setFocusable(true);
		this.setAnimationStyle(R.style.Amplification_In_Shrink_Out_Anim_Style);
		menuView.setOnTouchListener(this);
	}

	private class listViewAdapter extends BaseAdapter{
		
		@Override
		public int getCount() {
			return menus.length;
		}

		@Override
		public Object getItem(int arg0) {
			return arg0;
		}

		@Override
		public long getItemId(int arg0) {
			return arg0;
		}

		@Override
		public View getView(int arg0, View arg1, ViewGroup arg2) {
			arg1 = inflater.inflate(R.layout.list_menu_item, null);
			TextView menuItem = (TextView) arg1.findViewById(R.id.textMenuItem);
			if (arg0 == menus.length-1) {
				View viewLine = arg1.findViewById(R.id.viewLine);
				viewLine.setVisibility(View.INVISIBLE);
			}
			menuItem.setText(menus[arg0]);
			return arg1;
		}
		
	}

	@Override
	public void onItemClick(AdapterView<?> arg0, View arg1, int arg2, long arg3) {
		if (this.isShowing()) {
			this.dismiss();
		}
			final CustomDialog dialog = new CustomDialog(mActivity, R.style.CustomDialog, CustomDialog.DIALOG_TYPE_NO_TITLE);
			dialog.setMessage(mActivity.getResources().getString(R.string.remove_application_hint_head)+PageManager.getCurrentPager().appName+mActivity.getResources().getString(R.string.remove_application_hint_tail));
			dialog.setPositiveButton(mActivity.getResources().getString(R.string.delete), new OnClickListener() {
				
				@Override
				public void onClick(View arg0) {
					Intent intent = new Intent();
					intent.setAction("removeApp");
					intent.putExtra("removeAppURL", PageManager.getCurrentPager().url);
					mActivity.sendBroadcast(intent);
					PageManager.setDeleteUrl(PageManager.getCurrentPager().url);
					dialog.dismiss();
				}
			});
			dialog.setNegativeButton(mActivity.getResources().getString(R.string.cancel), new OnClickListener() {
				
				@Override
				public void onClick(View arg0) {
					dialog.dismiss();
				}
			});
			dialog.show();
	}

	@Override
	public boolean onTouch(View arg0, MotionEvent arg1) {
		if (this.isShowing()) {
			this.dismiss();
		}
		return true;
	}
}
