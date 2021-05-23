library my_prj.globals;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
FirebaseAnalytics analytics_glob = FirebaseAnalytics();
FirebaseAnalyticsObserver observer_glob = FirebaseAnalyticsObserver(analytics: analytics_glob);
User user_glob;