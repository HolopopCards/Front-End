import 'package:global_configuration/global_configuration.dart';

class AppSettings {
  String getApiHost() => GlobalConfiguration().get("apiUrl");
}