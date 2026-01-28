package com.example.hackathon_app

import android.content.Context

object BlockedAppStore {

    private const val PREF = "focus_mode"
    private const val KEY_ACTIVE = "active"
    private const val KEY_APPS = "blocked_apps"

    fun isActive(context: Context): Boolean {
        return context
            .getSharedPreferences(PREF, Context.MODE_PRIVATE)
            .getBoolean(KEY_ACTIVE, false)
    }

    fun setActive(context: Context, active: Boolean) {
        context.getSharedPreferences(PREF, Context.MODE_PRIVATE)
            .edit()
            .putBoolean(KEY_ACTIVE, active)
            .apply()
    }

    fun get(context: Context): Set<String> {
        return context
            .getSharedPreferences(PREF, Context.MODE_PRIVATE)
            .getStringSet(KEY_APPS, emptySet()) ?: emptySet()
    }

    fun save(context: Context, apps: Set<String>) {
        context.getSharedPreferences(PREF, Context.MODE_PRIVATE)
            .edit()
            .putStringSet(KEY_APPS, apps)
            .apply()
    }


}

