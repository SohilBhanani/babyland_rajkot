import 'package:woocommerce/woocommerce.dart';
import 'config.dart';

List ConfigAPI = liveAPI;
WooCommerce woo = WooCommerce(

  //Enter your API Configurations HERE
  baseUrl: ConfigAPI[0],
  consumerKey: ConfigAPI[1],
  consumerSecret: ConfigAPI[2]
);
