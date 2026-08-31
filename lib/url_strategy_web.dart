import 'package:flutter_web_plugins/url_strategy.dart';

void configureUrlStrategy() {
  usePathUrlStrategy(); // Native built-in strategy to clear the '#'
}
