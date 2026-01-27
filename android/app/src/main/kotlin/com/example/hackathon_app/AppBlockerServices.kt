package com.example.hackathon_app

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.AccessibilityServiceInfo
import android.content.Intent
import android.view.accessibility.AccessibilityEvent
import com.example.hackathon_app.BlockActivity

class AppBlockerService : AccessibilityService() {

    override fun onServiceConnected() {
        val info = AccessibilityServiceInfo().apply {
            eventTypes = AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED
            feedbackType = AccessibilityServiceInfo.FEEDBACK_GENERIC
            flags = AccessibilityServiceInfo.FLAG_REPORT_VIEW_IDS
        }
        serviceInfo = info
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (event == null) return
        if (!FocusSessionState.isActive) return

        val packageName = event.packageName?.toString() ?: return
        val blockedApps = BlockedAppStore.get(this)

        if (blockedApps.contains(packageName)) {
            val intent = Intent(this, BlockActivity::class.java)
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            intent.putExtra("blocked_package", packageName)
            startActivity(intent)
        }
    }

    override fun onInterrupt() {}
}
