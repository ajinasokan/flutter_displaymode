package com.ajinasokan.flutterdisplaymode;

import android.app.Activity;
import android.content.Context;
import android.os.Build;
import android.view.Display;
import android.view.Window;
import android.view.WindowManager;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Objects;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * DisplayModePlugin
 */
public class DisplayModePlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
    private Activity activity;
    private static final String METHOD_GET_ACTIVE_MODE = "getActiveMode";
    private static final String METHOD_GET_SUPPORTED_MODES = "getSupportedModes";
    private static final String METHOD_GET_PREFERRED_MODE = "getPreferredMode";
    private static final String METHOD_SET_PREFERRED_MODE = "setPreferredMode";

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        final MethodChannel channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_display_mode");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
            result.error("noAPI", "API is supported only in Marshmallow and later", null);
            return;
        }

        if (activity == null) {
            result.error("noActivity", "Activity not attached to plugin. App is probably in background.", null);
            return;
        }

        switch (call.method) {
            case METHOD_GET_ACTIVE_MODE:
                getActiveMode(result);
                break;
            case METHOD_GET_SUPPORTED_MODES:
                getSupportedModes(result);
                break;
            case METHOD_GET_PREFERRED_MODE:
                getPreferredMode(result);
                break;
            case METHOD_SET_PREFERRED_MODE:
                setPreferredMode(call, result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }


    @RequiresApi(api = Build.VERSION_CODES.M)
    private void getActiveMode(@NonNull Result result) {
        final WindowManager windowManager = (WindowManager) activity.getSystemService(Context.WINDOW_SERVICE);
        final Display.Mode mode =  windowManager.getDefaultDisplay().getMode();
        final HashMap<String, Object> ret = new HashMap<>();
        ret.put("id", mode.getModeId());
        ret.put("width", mode.getPhysicalWidth());
        ret.put("height", mode.getPhysicalHeight());
        ret.put("refreshRate", mode.getRefreshRate());
        result.success(ret);
    }

    @RequiresApi(api = Build.VERSION_CODES.M)
    private ArrayList<HashMap<String, Object>> getSupportedModes() {
        final ArrayList<HashMap<String, Object>> ret = new ArrayList<>();
        final WindowManager windowManager = (WindowManager) activity.getSystemService(Context.WINDOW_SERVICE);
        final Display display = windowManager.getDefaultDisplay();
        final Display.Mode[] modes = display.getSupportedModes();

        for (final Display.Mode mode : modes) {
            final HashMap<String, Object> item = new HashMap<>();
            item.put("id", mode.getModeId());
            item.put("width", mode.getPhysicalWidth());
            item.put("height", mode.getPhysicalHeight());
            item.put("refreshRate", mode.getRefreshRate());
            ret.add(item);
        }
        return ret;
    }

    @RequiresApi(api = Build.VERSION_CODES.M)
    private void getSupportedModes(@NonNull Result result) {
        result.success(getSupportedModes());
    }

    @RequiresApi(api = Build.VERSION_CODES.M)
    private void getPreferredMode(@NonNull Result result) {
        final Window window = activity.getWindow();
        final WindowManager.LayoutParams params = window.getAttributes();

        final WindowManager windowManager = (WindowManager) activity.getSystemService(Context.WINDOW_SERVICE);
        final Display display = windowManager.getDefaultDisplay();
        final Display.Mode[] modes = display.getSupportedModes();

        // look for matching mode and return it
        for (final Display.Mode mode : modes) {
            if(params.preferredDisplayModeId == mode.getModeId()) {
                final HashMap<String, Object> item = new HashMap<>();
                item.put("id", mode.getModeId());
                item.put("width", mode.getPhysicalWidth());
                item.put("height", mode.getPhysicalHeight());
                item.put("refreshRate", mode.getRefreshRate());
                result.success(item);
                return;
            }
        }

        // no match found. return as automatic
        final HashMap<String, Object> ret = new HashMap<>();
        ret.put("id", 0);
        ret.put("width", 0);
        ret.put("height", 0);
        ret.put("refreshRate", 0.0);
        result.success(ret);
    }

    @RequiresApi(api = Build.VERSION_CODES.M)
    private void setPreferredMode(@NonNull MethodCall call, @NonNull Result result) {
        final int mode = (int) call.argument("mode");
        final Window window = activity.getWindow();
        final WindowManager.LayoutParams params = window.getAttributes();
        params.preferredDisplayModeId = mode;
        window.setAttributes(params);
        result.success(null);
    }

    private void setActivity(Activity activity) {
        this.activity = activity;
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
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        onAttachedToActivity(binding);
    }
}
