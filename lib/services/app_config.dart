class AppConfig {
  static final AppConfig _instance = AppConfig._internal();

  factory AppConfig() => _instance;

  AppConfig._internal();
  static String? accessToken;


  static bool get isAuthorized => (AppConfig.accessToken ?? '').isNotEmpty;
}