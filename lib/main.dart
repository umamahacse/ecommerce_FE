import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend_ecommerce/route/multi_provider_list.dart';
import 'package:frontend_ecommerce/route/router_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

AndroidOptions getAndroidOptions() => const AndroidOptions(
  encryptedSharedPreferences: true,
);
const options = IOSOptions(accessibility: KeychainAccessibility.first_unlock);

void main() async{
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        // these are variable
        // for each firebase project
          apiKey: "AIzaSyAcDLmpJ4r6EwmYvySXJVfZC31mm1v7r3o",
          authDomain: "fe-ecommerce-8a9c4.firebaseapp.com",
          projectId: "fe-ecommerce-8a9c4",
          storageBucket: "fe-ecommerce-8a9c4.appspot.com",
          messagingSenderId: "181031022020",
          appId: "1:181031022020:web:f8d53b2727de697ec10891",
          measurementId: "G-3XTMSF334X")
  );
  runApp(MultiProvider(
    providers: providersList,
    child: const App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MaterialApp.router(
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: "Sans"),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        });
  }
}
