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

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.widget.Button;
import android.widget.TextView;

public class CustomDialog extends Dialog{

	private Button btnNegative,btnPositive;
	private TextView textTitle,textMessage;
	public static final int DIALOG_TYPE_NO_TITLE = 0;
	public static final int DIALOG_TYPE_HAVE_TITLE = 1;
	private int dialogType = -1;
	private String title,message,negativeText,positiveText;
	private android.view.View.OnClickListener negativeListener,positiveListener;
	
	public CustomDialog(Context context, int theme, int type) {
		super(context, theme);
		dialogType = type; 
	}

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		if (dialogType == DIALOG_TYPE_NO_TITLE) {
			this.setContentView(R.layout.custom_dialog_no_title);
		}else {
			this.setContentView(R.layout.custom_dialog_have_title);
			textTitle = (TextView) findViewById(R.id.textTitle);
		}
		
		initView();
		initInfo();
		
	}
	
	private void initView(){
		textMessage = (TextView) findViewById(R.id.textMessage);
		btnNegative = (Button) findViewById(R.id.btnNegative);
		btnPositive = (Button) findViewById(R.id.btnPositive);
	}
	
	private void initInfo(){
		if (textTitle != null) {
			textTitle.setText(title);
		}
		textMessage.setText(message);
		btnPositive.setText(positiveText);
		btnNegative.setText(negativeText);
		if (negativeListener != null) {
			btnNegative.setOnClickListener(negativeListener);
		}
		if (positiveListener != null) {
			btnPositive.setOnClickListener(positiveListener);
		}
	}
	
	public void setTitle(String text){
		title = "";
		if (text != null) {
			title = text;
		}
	}
	
	public void setMessage(String text){
		message  = "";
		if (text != null) {
			message = text;
		}
	}
	
	public void setPositiveButton(String text , android.view.View.OnClickListener listener){
		positiveText  = "";
		if (text != null) {
			positiveText = text;
		}
		if (listener != null) {
			positiveListener = listener;
		}
	}
	
	public void setNegativeButton(String text ,android.view.View.OnClickListener listener){
		negativeText = "";
		if (text != null) {
			negativeText = text;
		}
		if (listener != null) {
			negativeListener = listener;
		}
	}
	
	public void dismiss(){
		super.dismiss();
	}
	
	public void show(){
		super.show();
	}
}
