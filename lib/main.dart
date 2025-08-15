import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Set up error handling for Flutter framework errors
  FlutterError.onError = (FlutterErrorDetails errorDetails) {
    // Pass all uncaught Flutter framework errors to Crashlytics
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  
  // Handle errors from the underlying platform/plugin
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true; // Prevents the error from being shown to the user
  };
  
  // Pass all uncaught asynchronous errors to Crashlytics
  runZonedGuarded<Future<void>>(
    () async {
      // Enable Crashlytics in production only
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(kReleaseMode);
      
      // Set user identifier (if user is logged in)
      // await FirebaseCrashlytics.instance.setUserIdentifier('user_id_here');
      
      // Set custom key
      await FirebaseCrashlytics.instance.setCustomKey('app_version', '1.0.0');
      
      // Use path URL strategy for web
      usePathUrlStrategy();
      
      // Run the app
      runApp(const MyApp());
    },
    (error, stackTrace) {
      // Handle any errors that occur during app startup
      FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
    },
  );
}

// firebase init
// firebase deploy