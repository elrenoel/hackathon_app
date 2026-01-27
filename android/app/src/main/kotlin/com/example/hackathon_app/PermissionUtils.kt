package com.example.hackathon_app

import android.app.AppOpsManager
import android.content.Context
import android.provider.Settings
import android.accessibilityservice.AccessibilityServiceInfo
import android.view.accessibility.AccessibilityManager

object PermissionUtils {

    fun hasUsageAccess(context: Context): Boolean {
        val appOps = context.getSystemService(Context.APP_OPS_SERVICE) as AppOpsManager
        val mode = appOps.checkOpNoThrow(
            AppOpsManager.OPSTR_GET_USAGE_STATS,
            android.os.Process.myUid(),
            context.packageName
        )
        return mode == AppOpsManager.MODE_ALLOWED
    }

    fun hasAccessibility(context: Context): Boolean {
        val manager =
            context.getSystemService(Context.ACCESSIBILITY_SERVICE) as AccessibilityManager
        val services =
            manager.getEnabledAccessibilityServiceList(AccessibilityServiceInfo.FEEDBACK_ALL_MASK)
        return services.any {
            it.resolveInfo.serviceInfo.packageName == context.packageName
        }
    }

    fun hasNotificationAccess(context: Context): Boolean {
        val enabled = Settings.Secure.getString(
            context.contentResolver,
            "enabled_notification_listeners"
        )
        return enabled?.contains(context.packageName) == true
    }
}
