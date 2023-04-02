import 'package:flutter/material.dart';
import 'package:proshore_weather_app/network/api_service.dart';
import 'package:proshore_weather_app/util/app_providers.dart';
import 'package:proshore_weather_app/util/app_router.dart';
import 'package:proshore_weather_app/view/home_page.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MultiProvider(
    providers: appProviders,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: const HomePage(),
    // );

    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          title: "Weather App",
          routerConfig: AppRouter().router,
          theme: ThemeData(
            primarySwatch: Colors.yellow,
          ),
          themeMode: ThemeMode.light,
        );
      },
    );
  }
}
