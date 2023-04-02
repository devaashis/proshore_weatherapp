import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:proshore_weather_app/provider/home_provider.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider<HomeProvider>(
    create: (context) => HomeProvider(),
  ),
];
