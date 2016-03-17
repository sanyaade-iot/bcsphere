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
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import org.bcsphere.activity.R;
import android.annotation.SuppressLint;
import android.support.v4.app.FragmentTransaction;

@SuppressLint("Recycle")
public class PageManager {

	public static final String SCAN_URL = "file:///android_asset/www/apps/homepage/index.html";
	private MainActivity mActivity = null;
	public static HashMap<String, BCPage> pages = null;
	public static String currentUrl = null;
	public static String deleteUrl = "";
	private boolean isFirst = true;
	public PageManager(MainActivity activity) {
		mActivity = activity;
		pages = new HashMap<String, BCPage>();
	}

	public void createPage(String url, String deviceName, String deviceAddress, String deviceType,String appName){
		if (pages.containsKey(url)) {
			return;
		}
		pages.put(url, new BCPage(mActivity, url, deviceName, deviceAddress, deviceType, appName));
	}
	
	public void createPage(String url,String isTemporary){
		FragmentTransaction mTransaction = getTransaction(url);
		BCPage page = new BCPage(mActivity, url,isTemporary);
		mTransaction.add(R.id.viewContainer,page).commit();
		pages.put(url, page);
		currentUrl = url;
	}

	public void destroyPage(String url){
		if (!pages.containsKey(url)) {
			return;
		}
		if (getPage(url).isAdded()) {
			getTransaction(url).remove(getPage(url)).commit();
		}
		pages.remove(url);
	}

	public void showPage(String url){
		if (!pages.containsKey(url) ) {
			return;
		}
		if (getPage(url).isAdded()) {
			getTransaction(url).show(getPage(url)).commit();
		}else {
			getTransaction(url).add(R.id.viewContainer, getPage(url)).commit();
		}
		Iterator<Entry<String, BCPage>> iterator = pages.entrySet().iterator();
		while (iterator.hasNext()) {
			Map.Entry<String, BCPage> entry = (Entry<String, BCPage>) iterator.next();
			String mUrl = entry.getKey();
			if (!mUrl.equals(url)) {
				hidePage(mUrl);
			}
		}
		currentUrl = url;
	}

	public void hidePage(String url){
		if (!pages.containsKey(url) ) {
			return;
		}
		getTransaction(url).hide(getPage(url)).commit();
	}

	private FragmentTransaction getTransaction(String url){
		FragmentTransaction mTransaction = mActivity.getSupportFragmentManager().beginTransaction();
		if (url.equals(SCAN_URL)) {
			if (isFirst) {
				mTransaction.setCustomAnimations(R.anim.fold_in, R.anim.push_bottom_out);
				isFirst = false;
			}else {
				mTransaction.setCustomAnimations(R.anim.push_bottom_in, R.anim.push_bottom_out);
			}
		}else {
			mTransaction.setCustomAnimations(R.anim.fold_in, R.anim.fold_out);
		}
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

	public static BCPage getCurrentPager(){
		if (pages.get(currentUrl) != null) {
			return pages.get(currentUrl);
		}else {
			return null;
		}
	}
	
	public boolean contains(String url){
		if (pages.containsKey(url)) {
			return true;
		}else {
			return false;
		}
	}

	public static String getDeleteUrl() {
		return deleteUrl;
	}

	public static void setDeleteUrl(String deleteUrl) {
		PageManager.deleteUrl = deleteUrl;
	} 
	
	public  void Destroy(){
		Iterator<Entry<String, BCPage>> iterator = pages.entrySet().iterator();
		while (iterator.hasNext()) {
			Map.Entry<String, BCPage> entry = (Entry<String, BCPage>) iterator.next();
			String url = entry.getKey();
			pages.get(url).mWebView.handleDestroy();
		}
		
	}
	
	
}
