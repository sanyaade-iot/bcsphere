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

import java.util.HashMap;
import org.bcsphere.activity.R;
import android.annotation.SuppressLint;
import android.support.v4.app.FragmentTransaction;

@SuppressLint("Recycle")
public class PageManager {

	public static final String HOME_URL = "file:///android_asset/www/apps/homepage/index.html";
	private MainActivity mActivity = null;
	private static HashMap<String, BCPage> pages = null;
	private String currentUrl = null;
	public PageManager(MainActivity activity) {
		mActivity = activity;
		pages = new HashMap<String, BCPage>();

		FragmentTransaction mTransaction = activity.getSupportFragmentManager().beginTransaction();
		BCPage page = new BCPage(activity, HOME_URL);
		mTransaction.add(R.id.viewContainer,page).commit();
		pages.put(HOME_URL, page);
		currentUrl = HOME_URL;
	}

	public void createPage(String url, String deviceName, String deviceAddress, String deviceType){
		if (pages.containsKey(url)) {
			return;
		}
		pages.put(url, new BCPage(mActivity, url, deviceName, deviceAddress, deviceType));
	}

	public void destroyPage(String url){
		if (!pages.containsKey(url) || url.equals(HOME_URL)) {
			return;
		}

		showPage(HOME_URL);

		if (getPage(url).isAdded()) {
			getTransaction().remove(getPage(url)).commit();
		}
		pages.remove(url);
	}

	public void showPage(String url){
		if (!pages.containsKey(url) ) {
			return;
		}
		if (getPage(url).isAdded()) {
			getTransaction().show(getPage(url)).commit();
			hidePage(currentUrl);
		}else {
			getTransaction().add(R.id.viewContainer, getPage(url)).commit();
		}
		currentUrl = url;
	}

	public void hidePage(String url){
		if (!pages.containsKey(url) ) {
			return;
		}
		getTransaction().hide(getPage(currentUrl)).commit();
	}

	private FragmentTransaction getTransaction(){
		FragmentTransaction mTransaction = mActivity.getSupportFragmentManager().beginTransaction();
		mTransaction.setCustomAnimations(R.anim.push_right_in, R.anim.push_right_out);
		return mTransaction;
	}

	public static BCPage getPage(String url){
		String urlStr = null;
		if (!url.isEmpty()) {
			urlStr = url;
			if (url.contains("#")) {
				urlStr = url.substring(0, url.indexOf('#'));
			}
		}
		return pages.get(urlStr);
	}

	public boolean contains(String url){
		if (pages.containsKey(url)) {
			return true;
		}else {
			return false;
		}
	}
}
