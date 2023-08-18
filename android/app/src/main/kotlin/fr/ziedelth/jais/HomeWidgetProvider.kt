package fr.ziedelth.jais

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.graphics.BitmapFactory
import android.net.Uri
import android.view.View
import android.widget.RemoteViews

import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

class HomeWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.home_widget_layout).apply {
                // Open App on Widget Click
                val pendingIntent = HomeWidgetLaunchIntent.getActivity(
                    context,
                    MainActivity::class.java)
                setOnClickPendingIntent(R.id.home_widget_container, pendingIntent)

                // Show Images saved with `renderFlutterWidget`
                val image1 = widgetData.getString("image0", null)

                if (image1 != null) {
                    setImageViewBitmap(R.id.widget_img1, BitmapFactory.decodeFile(image1))
                    setViewVisibility(R.id.widget_img1, View.VISIBLE)
                } else {
                    setViewVisibility(R.id.widget_img1, View.GONE)
                }

                val image2 = widgetData.getString("image1", null)

                if (image2 != null) {
                    setImageViewBitmap(R.id.widget_img2, BitmapFactory.decodeFile(image2))
                    setViewVisibility(R.id.widget_img2, View.VISIBLE)
                } else {
                    setViewVisibility(R.id.widget_img2, View.GONE)
                }

                val image3 = widgetData.getString("image2", null)

                if (image3 != null) {
                    setImageViewBitmap(R.id.widget_img3, BitmapFactory.decodeFile(image3))
                    setViewVisibility(R.id.widget_img3, View.VISIBLE)
                } else {
                    setViewVisibility(R.id.widget_img3, View.GONE)
                }

                val image4 = widgetData.getString("image3", null)

                if (image4 != null) {
                    setImageViewBitmap(R.id.widget_img4, BitmapFactory.decodeFile(image4))
                    setViewVisibility(R.id.widget_img4, View.VISIBLE)
                } else {
                    setViewVisibility(R.id.widget_img4, View.GONE)
                }

                // Nothing in your watchlist yet
                if (image1 != null || image2 != null || image3 != null || image4 != null) {
                    setViewVisibility(R.id.widget_nothing, View.GONE)
                } else {
                    setViewVisibility(R.id.widget_nothing, View.VISIBLE)
                    setTextViewText(R.id.widget_nothing, "Nothing in your watchlist yet")
                }
            }

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}