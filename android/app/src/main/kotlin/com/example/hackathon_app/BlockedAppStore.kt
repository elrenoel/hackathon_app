package com.example.hackathon_app

import android.content.Context

object BlockedAppStore {

    private const val PREF = "blocked_apps"
    private const val KEY = "apps"

    fun save(context: Context, apps: List<String>) {
        context
            .getSharedPreferences(PREF, Context.MODE_PRIVATE)
            .edit()
            .putStringSet(KEY, apps.toSet())
            .apply()
    }

    fun get(context: Context): Set<String> {
        return context
            .getSharedPreferences(PREF, Context.MODE_PRIVATE)
            .getStringSet(KEY, emptySet()) ?: emptySet()
    }
}
