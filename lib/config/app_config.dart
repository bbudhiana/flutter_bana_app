class ConfigEnvironment {
  static Map<String, dynamic>? _config;
  static Environment? environment;
  static const String apiKey = 'cc95d932d5a45d33a9527d5019475f2c';
  //static const String apiKey = 'GvWH6TSUeCZH7TDHbgBeu30XEDEay7T0CjUWBQW2a0mE5c0XzGJ5kRX9M9Z1GzEj';

  static void setEnvironment(Environment env) {
    environment = env;

    switch (env) {
      case Environment.trial:
        _config = _Config.trialConstant;
        break;
      case Environment.dev:
        _config = _Config.developmentConstant;
        break;
      case Environment.production:
        _config = _Config.productionConstant;
        break;
    }
  }

  static get url => _config![_Config.url];
  static get authURL => _config![_Config.authURL];
  static get buildFlavorType => _config![_Config.buildFlavorType];

  static String currentWeatherByName(String city) =>
      _config![_Config.url] + '/weather?q=$city&appid=$apiKey';
  static String weatherIcon(String iconCode) =>
      'http://openweathermap.org/img/wn/$iconCode@2x.png';

  static get loginTrial => _config![_Config.authURL];

  static String baseurl(String url) => _config![_Config.url] + url;
}

class _Config {
  static const url = "URL";
  static const authURL = "AUTH_URL";
  static const buildFlavorType = "BUILD_FLAVOR_TYPE";

  static Map<String, dynamic> trialConstant = {
    url: "https://api.openweathermap.org/data/2.5",
    authURL: "https://reqres.in/api/login",
    buildFlavorType: BuildFlavorType.trial,
  };

  static Map<String, dynamic> developmentConstant = {
    url: "https://devbe.bahaso.com/api",
    authURL: "https://devbe.bahaso.com/api",
    buildFlavorType: BuildFlavorType.dev
  };

  static Map<String, dynamic> productionConstant = {
    url: "https://bahaso.com/api",
    authURL: "https://bahaso.com/api",
    buildFlavorType: BuildFlavorType.production
  };
}

enum BuildFlavorType { trial, dev, production }

enum Environment { trial, dev, production }
