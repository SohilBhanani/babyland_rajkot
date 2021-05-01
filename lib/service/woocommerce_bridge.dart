import 'package:woocommerce/woocommerce.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

import '../config.dart';
List configAPI = liveAPI;
WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
  url: configAPI[0],
  consumerKey: configAPI[1],
  consumerSecret: configAPI[2], 

);

WooCommerce woo = WooCommerce(
    baseUrl: configAPI[0],
    consumerKey: configAPI[1],
    consumerSecret: configAPI[2]
);
