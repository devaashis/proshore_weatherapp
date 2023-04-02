import 'package:flutter/material.dart';
import 'package:proshore_weather_app/util/app_styles.dart';

class CustomImageContainer extends StatelessWidget {
  final String image;

  const CustomImageContainer(this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      width: 48,
      height: 48,
      fit: BoxFit.cover,
      color: kPrimaryColor,
      image: NetworkImage(image),

      errorBuilder: (context, url, error) {
        return Image.asset(
          "assets/images/image_placeholder.png",
          width: 48,
          height: 48,
          fit: BoxFit.cover,
          color: kPrimaryColor,
        );
      },
      // loadingBuilder: (context, url, error) {
      //   if (error == null) return url;
      //   return Image.asset(
      //     "assets/images/image_placeholder.png",
      //     fit: BoxFit.cover,
      //   );
      // },
    );
  }
}
