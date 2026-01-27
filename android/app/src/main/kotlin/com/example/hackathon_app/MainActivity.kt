package com.example.hackathon_app

import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.Canvas
import android.os.Bundle
import android.provider.Settings
import android.util.Base64
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream
import com.example.hackathon_app.FocusService

class MainActivity : FlutterActivity() {

    private val INSTALLED_APPS_CHANNEL = "installed_apps"
    private val FOCUS_CHANNEL = "focus_service"
    private val PERMISSION_CHANNEL = "permission_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // 🔹 Installed Apps
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            INSTALLED_APPS_CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "getInstalledApps") {
                Thread {
                    val apps = getInstalledApps()
                    runOnUiThread {
                        result.success(apps)
                    }
                }.start()
            } else {
                result.notImplemented()
            }
        }

        // 🔹 Focus Service
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            FOCUS_CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "startFocus" -> {
                    startService(
                        Intent(this, FocusService::class.java)
                    )
                    result.success(null)
                }
                "openSettings" -> {
                    startActivity(
                        Intent(Settings.ACTION_SETTINGS)
                    )
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }

        // 🔹 Permission Check
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            PERMISSION_CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "checkPermissions") {
                result.success(
                    mapOf(
                        "usage" to PermissionUtils.hasUsageAccess(this),
                        "accessibility" to PermissionUtils.hasAccessibility(this),
                        "notification" to PermissionUtils.hasNotificationAccess(this)
                    )
                )
            } else {
                result.notImplemented()
            }
        }

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "focus_service"
        ).setMethodCallHandler { call, result ->

            when (call.method) {

                "startFocus" -> {
                    val blocked = call.argument<List<String>>("blocked") ?: emptyList()
                    BlockedAppStore.save(this, blocked)
                    FocusSessionState.isActive = true
                    result.success(null)
                }

                "stopFocus" -> {
                    FocusSessionState.isActive = false
                    result.success(null)
                }

                else -> result.notImplemented()
            }
        }

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "permission_channel"
        ).setMethodCallHandler { call, result ->

            when (call.method) {

                "checkPermissions" -> {
                    result.success(
                        mapOf(
                            "usage" to PermissionUtils.hasUsageAccess(this),
                            "accessibility" to PermissionUtils.hasAccessibility(this),
                            "notification" to PermissionUtils.hasNotificationAccess(this)
                        )
                    )
                }

                "openUsageAccess" -> {
                    startActivity(
                        Intent(android.provider.Settings.ACTION_USAGE_ACCESS_SETTINGS)
                            .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    )
                    result.success(null)
                }

                "openAccessibility" -> {
                    startActivity(
                        Intent(android.provider.Settings.ACTION_ACCESSIBILITY_SETTINGS)
                            .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    )
                    result.success(null)
                }

                "openNotification" -> {
                    startActivity(
                        Intent(android.provider.Settings.ACTION_NOTIFICATION_LISTENER_SETTINGS)
                            .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    )
                    result.success(null)
                }

                else -> result.notImplemented()
            }
        }
    }

    // 🔹 Installed apps logic
    private fun getInstalledApps(): List<Map<String, Any>> {
        val pm: PackageManager = packageManager
        val apps = pm.getInstalledApplications(PackageManager.GET_META_DATA)

        val appList = mutableListOf<Map<String, Any>>()

        for (app in apps) {
            val launchIntent = pm.getLaunchIntentForPackage(app.packageName)
            if (launchIntent == null) continue

            try {
                val appName = pm.getApplicationLabel(app).toString()
                val icon = pm.getApplicationIcon(app)

                val stream = ByteArrayOutputStream()
                val bitmap = Bitmap.createBitmap(64, 64, Bitmap.Config.ARGB_8888)
                val canvas = Canvas(bitmap)

                icon.setBounds(0, 0, canvas.width, canvas.height)
                icon.draw(canvas)
                bitmap.compress(Bitmap.CompressFormat.PNG, 80, stream)

                appList.add(
                    mapOf(
                        "name" to appName,
                        "packageName" to app.packageName,
                        "icon" to Base64.encodeToString(
                            stream.toByteArray(),
                            Base64.NO_WRAP
                        )
                    )
                )
            } catch (_: Exception) {
            }
        }
        return appList
    }
}
