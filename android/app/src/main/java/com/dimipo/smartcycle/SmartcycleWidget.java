package com.dimipo.smartcycle;

import android.app.PendingIntent;
import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.widget.RemoteViews;
import android.widget.Toast;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import io.flutter.plugin.common.MethodChannel;

import static android.appwidget.AppWidgetManager.ACTION_APPWIDGET_UPDATE;

public class SmartcycleWidget extends AppWidgetProvider {

    static String CLICK_ACTION = "CLICKED";
    private static final String CHANNEL = "smartcycle.flutter.dev/widget";


    @Override
    public void onReceive(Context context, Intent intent) {
        super.onReceive(context, intent);

        if (intent.getAction().equals(CLICK_ACTION)) {
            System.out.println("Ddd");
            Toast.makeText(context, "클릭 인식", Toast.LENGTH_LONG).show();

            //startActivity(new Intent(getApplicationContext(), Dialog_onWidget.class));

//            AppWidgetManager manager = AppWidgetManager.getInstance(context);
//            this.onUpdate(context, manager, manager.getAppWidgetIds(new ComponentName(context, getClass())));
//            new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
//                    (call, result) -> {
//                        // Note: this method is invoked on the main thread.
//                        // TODO
//
//                    });

        }
    }

}
