package com.example.hackathon_app

import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification

class NotificationBlocker : NotificationListenerService() {

    override fun onNotificationPosted(sbn: StatusBarNotification) {
        if (!BlockedAppStore.isActive(this)) return

        val blockedApps = BlockedAppStore.get(this)
        if (blockedApps.contains(sbn.packageName)) {
            cancelNotification(sbn.key)
        }
    }
}
