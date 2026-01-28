package com.example.hackathon_app

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.AccessibilityServiceInfo
import android.content.Intent
import android.view.accessibility.AccessibilityEvent
import com.example.hackathon_app.BlockActivity
import android.app.NotificationManager
import androidx.core.app.NotificationCompat
import com.example.hackathon_app.BlockedAppStore

class AppBlockerService : AccessibilityService() {

    private var lastBlockedPackage: String? = null

    override fun onServiceConnected() {
        val info = AccessibilityServiceInfo().apply {
            eventTypes =
                AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED or
                AccessibilityEvent.TYPE_WINDOW_CONTENT_CHANGED
            feedbackType = AccessibilityServiceInfo.FEEDBACK_GENERIC
            flags = AccessibilityServiceInfo.FLAG_REPORT_VIEW_IDS
        }
        serviceInfo = info
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (event == null) return

        android.util.Log.d("FOCUS", "Event from: ${event.packageName}")

        if (!BlockedAppStore.isActive(this)) return

        val packageName = event.packageName?.toString() ?: return
        val blockedApps = BlockedAppStore.get(this)

        if (blockedApps.contains(packageName)) {

            sendBlockedNotification(packageName)

            val intent = Intent(this, BlockActivity::class.java)
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            startActivity(intent)
        }
    }

    override fun onInterrupt() {}

    private fun sendBlockedNotification(pkg: String) {
        val manager = getSystemService(NotificationManager::class.java)

        val notification = NotificationCompat.Builder(this, FocusService.CHANNEL_ID)
            .setSmallIcon(android.R.drawable.ic_lock_idle_alarm)
            .setContentTitle("Focus Mode Active")
            .setContentText("You can’t open this app during focus time")
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setAutoCancel(true)
            .build()

        manager.notify(pkg.hashCode(), notification)
    }

}

