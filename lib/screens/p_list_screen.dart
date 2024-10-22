import 'package:babylandrajkot/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/models/products.dart';

import '../components/p_tile.dart';
import '../services/scrolling_service.dart';
import '../services/variable_service.dart';
import '../shared/ui_helpers.dart';
import 'cart_screen.dart';
import 'product/product_screen.dart';

class PListScreen extends StatefulWidget {
  final String categoryName;
  final String categoryId;

  PListScreen({this.categoryId, this.categoryName});

  @override
  _PListScreenState createState() => _PListScreenState();
}

class _PListScreenState extends State<PListScreen> {
  final _scrollController = ScrollController();
  ScrollingService products;

  @override
  void initState() {
    super.initState();
    products = ScrollingService(widget.categoryId);
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        products.loadMore();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // FireUser user = Provider.of<FireUser>(context);

    return Scaffold(

      appBar: AppBar(
        title: Text(widget.categoryName.replaceAll('&amp;', '&')),

    //   actions: [
    //   IconButton(
    //   icon: Icon(Icons.shopping_basket),
    //   onPressed: () =>
    //       myNavigation(context, CartScreen(uid: user.uid)),
    // )
    // ],
      ),
      body: StreamBuilder(
        stream: products.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return RefreshIndicator(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: snapshot.data.length + 1,
                itemBuilder: (BuildContext context, index) {
                  if (index < snapshot.data.length) {
                    return GestureDetector(
                        onTap: () => myNavigation(
                            context,
                            MultiProvider(
                              providers: [
                                Provider<WooProduct>.value(
                                    value: snapshot.data[index]),
                                ChangeNotifierProvider<VariableService>.value(
                                  value: VariableService(),
                                )
                              ],
                              child: ProductScreen(),
                            )
                            // Provider<WooProduct>.value(
                            //     value: product,
                            //     child: ProductScreen()

                            // ),
                            ),
                        child: PTile(products: snapshot.data[index]));
                  } else if (products.hasMore) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.all(32),
                      child: Text('Uh Oh! No More Products to show 😴'),
                    );
                  }
                },
              ),
              onRefresh: products.refresh,
            );
          }
        },
      ),
    );
  }
}
