import 'package:babylandrajkot/components/cart_icon_count.dart';
import 'package:babylandrajkot/components/item_list_tile.dart';
import 'package:babylandrajkot/components/loading_component.dart';
import 'package:babylandrajkot/model/cart_bloc.dart';
import 'package:babylandrajkot/model/product_model.dart';
import 'package:babylandrajkot/screens/item_page.dart';
import 'package:babylandrajkot/service/auth.dart';
import 'package:babylandrajkot/service/woocommerce_bridge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  final int catId;
  final String catName;
  ProductList({this.catId,this.catName});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  var responseProducts;
  final List<ProductModel> _products = [

  ];

  bool _loading = false;
  ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _pageLoading = false;
  var message = "Loading..";
  Future<Null> getProductData(int page) async {
    if (!mounted) return;
    setState(() {
      page == 1 ? _loading = true : _loading = false;
    });
    responseProducts = await wooCommerceAPI.getAsync("products?category=${widget.catId}&page=$page");

    if (responseProducts.toString().length == 2) {
      print('There is nothing to show');
      if (!mounted) return;
      setState(() {
        message = "You have all the things that your baby needs 👶";
      });
      _pageLoading = false;
    } else {
      if (!mounted) return;
      setState(() {
        for (Map i in responseProducts) {
          _products.add(ProductModel.fromJson(i));
        }
        _currentPage++;
        _loading = false;
        _pageLoading = false;
//      products.add(json.decode(response));
      });
    }

  }


  @override
  void initState() {

    _loading = true;
    getProductData(_currentPage);
    _scrollController.addListener(() {
      if (!_pageLoading && _scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        print("current page is " + _currentPage.toString());
        getProductData(_currentPage);
        showInSnackBar(message);
        _pageLoading = true;
      }
    });
    super.initState();
  }


  showInSnackBar(String value) {
    _scaffoldKeyProductList.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }


  final _scaffoldKeyProductList = GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CartBloc>(context);
    return Scaffold(
      key: _scaffoldKeyProductList,
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.catName,style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),

          onPressed: () => Navigator.pop(context),
        ),
        
        actions: <Widget>[
          CartIcon(bloc: bloc,currentUser: AuthService().getCurrentUser),
        ],
      ),
      body: _loading==true?LoadingComponent():ListView.builder(
        padding: EdgeInsets.only(bottom: 85),
        controller: _scrollController,
        itemBuilder: (BuildContext context, index) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ItemPage(_products[index]),
              ),
            ),
            child: ItemListTile(products: _products,index: index,),
          );
        },
        itemCount: _products.length,
      ),
    );
  }
}


