import 'package:flutter/material.dart';
import 'package:stedom/routes/routes.dart';
import 'package:stedom/routes/router.dart' as router;
import 'package:stedom/utils/app_config.dart';
import 'package:stedom/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // app name
      title: AppConfig.appName,

      // app theme
      theme: AppTheme.lightTheme,

      // disable test banner
      debugShowCheckedModeBanner: false,

      //make flutter aware of app routes using router generator in router.dart file
      onGenerateRoute: router.generateRoute,

      initialRoute: walkThroughViewRoute,
    );
  }
}
