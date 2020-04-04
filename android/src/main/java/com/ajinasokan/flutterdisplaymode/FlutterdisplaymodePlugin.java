package com.ajinasokan.flutterdisplaymode;

import android.app.Activity;
import android.content.Context;
import android.os.Build;
import android.util.Log;
import android.view.Display;
import android.view.Window;
import android.view.WindowManager;

import androidx.annotation.NonNull;

import java.util.ArrayList;
import java.util.HashMap;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterdisplaymodePlugin */
public class FlutterdisplaymodePlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  private Activity activity;

  void setActivity(Activity activity) {
    this.activity = activity;
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    final MethodChannel channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_displaymode");
    channel.setMethodCallHandler(this);
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_displaymode");
    FlutterdisplaymodePlugin instance = new FlutterdisplaymodePlugin();
    instance.setActivity(registrar.activity());
    channel.setMethodCallHandler(instance);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
      result.error("noapi", "API is supported only in Marshmallow and later", null);
      return;
    }

    if (activity == null) {
      result.error("noactivity", "Activity not attached to plugin. App is probably in background.", null);
      return;
    }

    if (call.method.equals("getSupportedModes")) {
      ArrayList<HashMap<String, Object>> ret = new ArrayList<>();
      WindowManager windowManager = (WindowManager) activity.getSystemService(Context.WINDOW_SERVICE);
      Display display = windowManager.getDefaultDisplay();
      Display.Mode[] modes = display.getSupportedModes();
      if (modes == null) {
        result.success(ret);
        return;
      }

      Window window = activity.getWindow();
      WindowManager.LayoutParams params = window.getAttributes();
      int selectedMode = params.preferredDisplayModeId;

      for (final Display.Mode mode: modes) {
        HashMap<String, Object> item = new HashMap<>();
        item.put("id", mode.getModeId());
        item.put("width", mode.getPhysicalWidth());
        item.put("height", mode.getPhysicalHeight());
        item.put("refreshRate", mode.getRefreshRate());
        item.put("selected", mode.getModeId() == selectedMode);
        ret.add(item);
      }
      result.success(ret);
    } else if (call.method.equals("setMode")) {
      int mode = (int)call.argument("mode");
      Window window = activity.getWindow();
      WindowManager.LayoutParams params = window.getAttributes();
      params.preferredDisplayModeId = mode;
      window.setAttributes(params);
      result.success(null);
    }  else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
  }

  @Override
  public void onAttachedToActivity(ActivityPluginBinding binding) {
    activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivity() {
    activity = null;
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    onDetachedFromActivity();
  }

  @Override
  public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {
    onAttachedToActivity(binding);
  }
}
