import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InAppReviewManager {
  static final InAppReviewManager _singleton = InAppReviewManager._internal();

  factory InAppReviewManager() {
    return _singleton;
  }

  InAppReviewManager._internal();

  static const String _prefKeyInstallDate =
      "advanced_in_app_review_install_date";
  static const String _prefKeyLaunchTimes =
      "advanced_in_app_review_launch_times";
  static const String _prefKeyRemindInterval =
      "advanced_in_app_remind_interval";

  int minLaunchTimes = 2;
  int minDaysAfterInstall = 2;
  int minDaysBeforeRemind = 1;
  int minSecondsBeforeShowDialog = 1;

  Future<void> monitor() async {
    if (await _isFirstLaunch() == true) {
      _setInstallDate();
    }
  }

  Future<void> applicationWasLaunched() async {
    _setLaunchTimes(await _getLaunchTimes() + 1);
  }

  Future<bool> showRateDialogIfMeetsConditions() async {
    final bool isMeetsConditions = await _shouldShowRateDialog();
    if (isMeetsConditions) {
      Future.delayed(Duration(seconds: minSecondsBeforeShowDialog), () {
        _showDialog();
      });
    }
    return isMeetsConditions;
  }

  // Dialog

  Future<void> _showDialog() async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
    _setRemindTimestamp();
  }

  // Checkers

  Future<bool> _shouldShowRateDialog() async {
    return await _isOverLaunchTimes() &&
        await _isOverInstallDate() &&
        await _isOverRemindDate();
  }

  Future<bool> _isOverLaunchTimes() async {
    final bool overLaunchTimes = await _getLaunchTimes() >= minLaunchTimes;
    return overLaunchTimes;
  }

  Future<bool> _isOverInstallDate() async {
    final bool overInstallDate =
        await _isOverDate(await _getInstallTimestamp(), minDaysAfterInstall);
    return overInstallDate;
  }

  Future<bool> _isOverRemindDate() async {
    final bool overRemindDate =
        await _isOverDate(await _getRemindTimestamp(), minDaysBeforeRemind);
    return overRemindDate;
  }

  // Helpers

  Future<bool> _isOverDate(int targetDate, int threshold) async {
    return DateTime.now().millisecondsSinceEpoch - targetDate >=
        threshold * 24 * 60 * 60 * 1000;
  }

  // Shared Preference Values

  Future<bool> _isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final int? installDate = prefs.getInt(_prefKeyInstallDate);
    return installDate == null;
  }

  Future<int> _getInstallTimestamp() async {
    final prefs = await SharedPreferences.getInstance();
    final int? installTimestamp = prefs.getInt(_prefKeyInstallDate);
    if (installTimestamp != null) {
      return installTimestamp;
    }
    return 0;
  }

  Future<void> _setInstallDate() async {
    final prefs = await SharedPreferences.getInstance();
    final int timestamp = DateTime.now().millisecondsSinceEpoch;
    prefs.setInt(_prefKeyInstallDate, timestamp);
  }

  Future<int> _getLaunchTimes() async {
    final prefs = await SharedPreferences.getInstance();
    final int? launchTimes = prefs.getInt(_prefKeyLaunchTimes);
    if (launchTimes != null) {
      return launchTimes;
    }
    return 0;
  }

  static Future<void> _setLaunchTimes(int launchTimes) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_prefKeyLaunchTimes, launchTimes);
  }

  Future<int> _getRemindTimestamp() async {
    final prefs = await SharedPreferences.getInstance();
    final int? remindIntervalTime = prefs.getInt(_prefKeyRemindInterval);
    if (remindIntervalTime != null) {
      return remindIntervalTime;
    }
    return 0;
  }

  Future<void> _setRemindTimestamp() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_prefKeyRemindInterval);
    prefs.setInt(_prefKeyRemindInterval, DateTime.now().millisecondsSinceEpoch);
  }
}
