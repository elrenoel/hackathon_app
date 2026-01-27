package com.example.hackathon_app

import android.app.Activity
import android.os.Bundle
import android.widget.TextView

class BlockActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val textView = TextView(this).apply {
            text = "🚫 Focus Mode Active\nApp is blocked"
            textSize = 22f
            textAlignment = TextView.TEXT_ALIGNMENT_CENTER
        }

        setContentView(textView)
    }

    override fun onBackPressed() {
        // disable back button
    }
}
