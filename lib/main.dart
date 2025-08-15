import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'app.dart';
import 'core/services/di/injector.dart';
import 'core/utils/app_providers.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  usePathUrlStrategy();
  await InjectorService.service.init();
  runApp(MultiBlocProvider(
    providers: BlocProviders.blocProviderForMyApp,
    child: const MyApp())
  );
}

// firebase init
// firebase deploy