import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/models/products.dart';

import 'simple_product.dart';
import 'variable_product.dart';
import '../../services/color_size_choice.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<WooProduct>(context, listen: false);
    return product.type == 'variable'
        // ? ChangeNotifierProvider<VariableService>(
        //     create: (_) => VariableService(),
        //     child: VariableProduct(),
        //   )
        ? VariableProduct()
        : ChangeNotifierProvider<ChoiceService>(
            create: (_) => ChoiceService(),
            child: SimpleProduct(),
          );
  }
}
