import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:proshore_weather_app/model/response_weather.dart';
import 'package:proshore_weather_app/provider/home_provider.dart';
import 'package:proshore_weather_app/util/app_styles.dart';
import 'package:proshore_weather_app/widgets/custom_image_container.dart';
import 'package:proshore_weather_app/widgets/my_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeProvider? homeProvider;
  ResponseWeather? responseWeather;
  List<ListElement>? dailyWeather;
  ListElement? currentWeather;
  TextEditingController cityNameTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Search Bar Section
              const SizedBox(height: 30.0),
              buildSearchBar(),

              // Main Body Section
              Consumer<HomeProvider>(builder: (context, provider, child) {
                if ((provider.pageStatus == STATUS.success ||
                        provider.reload) &&
                    provider.selectedWeather != null) {
                  // Success
                  currentWeather = provider.selectedWeather;
                  homeProvider?.reload = false;
                  return buildBody();
                } else if (provider.pageStatus == STATUS.loading) {
                  return Container(
                    margin: EdgeInsets.only(top: 30.h),
                    child: CircularProgressIndicator(
                      color: Colors.amberAccent,
                    ),
                  );
                }
                return Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      Image.asset(
                        "assets/images/image_placeholder.png",
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        color: kPrimaryColor,
                      ),
                      Text(
                        "No weather data",
                        style: kTextFieldStyle,
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        // Today Weather Section

        const SizedBox(height: 10.0),
        buildWeatherSection(),

        // Daily Weather Section

        const SizedBox(height: 20.0),
        buildDailySection(),
      ],
    );
  }

  buildWeatherSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "${responseWeather?.city?.name}",
            style: kCityNameTextStyle,
          ),
          Text(
            DateFormat('MMM d yyyy')
                .format(currentWeather?.dtTxt ?? DateTime.now()),
            style: kTimeTextStyle,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    CustomImageContainer(
                        "https://openweathermap.org/img/wn/${currentWeather?.weather?.first.icon}.png"),
                    // Image.network(
                    //   "https://openweathermap.org/img/wn/${selectedWeather?.weather?.first.icon}.png",
                    //   fit: BoxFit.contain,
                    //   width: 48,
                    //   height: 48,
                    //   color: kPrimaryColor,
                    // ),
                    Text(
                      "${currentWeather?.weather?.first.main}",
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
                Container(
                  width: 2,
                  height: 20,
                  color: Colors.grey.withOpacity(0.5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${currentWeather?.main?.temp?.toStringAsFixed(1)}",
                      style: kTemperatureTextStyle,
                    ),
                    const Text(
                      "\u2103",
                      style: kTemperatureUnitTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.droplet,
                      color: kPrimaryColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Expanded(
                      child: Text(
                        "${currentWeather?.main?.humidity}",
                        style: kConditionTextStyle,
                      ),
                    ),
                  ],
                ),
                // child: Image.asset("assets/images/humidity.png"),
              ),
              Container(
                height: 60,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.wind,
                      color: kPrimaryColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${currentWeather?.wind?.speed} km/hr",
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Container(
                height: 60,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.eyeLowVision,
                      color: kPrimaryColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Expanded(
                      child: Text(
                        "${currentWeather?.visibility}m",
                        style: kConditionTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildEmptyBody() {
    return Center(
      child: Container(
        child: const Text("Sorry Please enter city name"),
      ),
    );
  }

  void fetchWeather(BuildContext context, String city) async {
    homeProvider?.getWeather(city).then((value) {
      if (value is ResponseWeather) {
        responseWeather = value;
        currentWeather = responseWeather?.list?.first;
        dailyWeather = homeProvider?.getDailyWeather(value.list!);
        homeProvider?.pageStatus = STATUS.success;
      } else {
        MySnackBar(context: context).show(value);
        homeProvider?.pageStatus = STATUS.error;
      }
    });
  }

  buildSearchBar() {
    return Container(
      width: double.infinity,
      height: 60,
      child: TextFormField(
        controller: cityNameTextController,
        textAlignVertical: TextAlignVertical.center,
        style: kTextFieldStyle,
        cursorColor: Colors.grey,
        keyboardType: TextInputType.streetAddress,
        onChanged: (value) {},
        // onFieldSubmitted: (value) {
        //   if (homeProvider?.validateCityName(
        //       context, value)) {
        //     fetchWeather(context, value);
        //   }
        // },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.lime.withOpacity(0.1),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(100)),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(100)),
          prefixIcon: const Icon(
            Icons.place,
            color: kPrimaryColor,
          ),
          // suffixIcon: IconButton(
          //   onPressed: () {
          //     if (homeProvider?.validateCityName(
          //         context, cityNameTextController.text)) {
          //       fetchWeather(context, cityNameTextController.text);
          //     }
          //   },
          //   icon: const Icon(
          //     Icons.search_rounded,
          //     color: kPrimaryColor,
          //   ),
          // ),
          suffixIcon: TextButton(
            onPressed: () {
              if (homeProvider?.validateCityName(
                  context, cityNameTextController.text)) {
                fetchWeather(context, cityNameTextController.text);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(100)),
              child: const Text(
                "Check",
                style: kButtonTextStyle,
              ),
            ),
          ),
          hintText: "Enter city name...",
          hintStyle: kTextFieldStyle,
        ),
      ),
    );
  }

  buildDailySection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: dailyWeather?.length,
        itemBuilder: (context, index) {

          return InkWell(
            onTap: () => loadSelectedDayWeather(dailyWeather![index]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.lime.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${homeProvider?.convertToWEEKDAY(dailyWeather![index].dt!)}",
                      style: kSmallTemperatureTextStyle,
                    ),
                    Text(
                      "${dailyWeather![index].weather?.first.main}",
                      style: kConditionTextStyle,
                    ),
                    RichText(
                      text: TextSpan(
                        style: kSmallTemperatureTextStyle,
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                "${dailyWeather![index].main?.tempMin?.ceil()}",
                          ),
                          TextSpan(
                            text: "-",
                          ),
                          TextSpan(
                            text:
                                "${dailyWeather![index].main?.tempMin?.ceil()}",
                          ),
                          TextSpan(
                            text:
                                "\u00B0", //  Fahrenheit: \u2109, Celcius: \u2103
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  loadSelectedDayWeather(ListElement listElement) {
    homeProvider?.selectedWeather = listElement;
    homeProvider?.reload = true;
  }
}
