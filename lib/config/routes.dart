import 'package:flutter/material.dart';
//import '/core/arguments/base_argument.dart';

import '../features/weather/presentation/pages/weather_page.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case WeatherPage.route:
      return MaterialPageRoute(builder: (context) => const WeatherPage());
    /* case HomeMain.route:
      return MaterialPageRoute(builder: (context) => const HomeMain()); */
  }
  return null;
}
