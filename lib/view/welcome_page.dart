import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:proshore_weather_app/util/app_router.dart';
import 'package:proshore_weather_app/util/app_styles.dart';
import 'package:sizer/sizer.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              FaIcon(
                color: Colors.white,
                size: 100,
                FontAwesomeIcons.cloudSunRain,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Proshore Weather",
                style: kAppNameTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        context.pushReplacementNamed(AppRouteName.home);
      },
    );
  }
}
