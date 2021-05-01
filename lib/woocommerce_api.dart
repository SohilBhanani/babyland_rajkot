import 'package:woocommerce/woocommerce.dart';
import 'config.dart';

List configAPI = liveAPI;
WooCommerce woo = WooCommerce(
  //Enter your API Configurations HERE
  baseUrl: configAPI[0],
  consumerKey: configAPI[1],
  consumerSecret: configAPI[2]
);
