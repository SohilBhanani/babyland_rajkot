import 'package:woocommerce/woocommerce.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
  url: "https://babyland123.000webhostapp.com",
  consumerKey: "ck_8b3bbc8d84793131a04976e59aec5a34253834ea",
  consumerSecret: "cs_73f214ec3a64419286453f98ebf815561f3c2fff",

  // bluehost
  // url: "https://babylandrajkot.com",
  // consumerKey: "ck_1fb1c5b82fbfdb5d338bdabde8daf18a5034c7b0",
  // consumerSecret: "cs_b11515dcd110cfbf7f9fb240f319e0e6c2f142e7",
);

WooCommerce woo = WooCommerce(
  baseUrl: "https://babyland123.000webhostapp.com",
  consumerKey: "ck_8b3bbc8d84793131a04976e59aec5a34253834ea",
  consumerSecret: "cs_73f214ec3a64419286453f98ebf815561f3c2fff",

  // bluehost
  // baseUrl: "https://babylandrajkot.com",
  // consumerKey: "ck_1fb1c5b82fbfdb5d338bdabde8daf18a5034c7b0",
  // consumerSecret: "cs_b11515dcd110cfbf7f9fb240f319e0e6c2f142e7",
);
