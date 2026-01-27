package com.example.hackathon_app

import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification
import com.example.hackathon_app.FocusSessionState
import com.example.hackathon_app.BlockedAppStore

class NotificationBlocker : NotificationListenerService() {

    override fun onNotificationPosted(sbn: StatusBarNotification) {
        // kalau focus session tidak aktif → biarkan
        if (!FocusSessionState.isActive) return

        val blockedApps = BlockedAppStore.get(this)
        val packageName = sbn.packageName

        if (blockedApps.contains(packageName)) {
            // hapus notifikasi
            cancelNotification(sbn.key)
        }
    }
}

