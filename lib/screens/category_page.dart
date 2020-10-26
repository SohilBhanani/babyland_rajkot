import 'package:babylandrajkot/components/category_card.dart';
import 'package:babylandrajkot/components/loading_component.dart';
import 'package:babylandrajkot/model/category_model_api.dart';
import 'package:babylandrajkot/screens/cart_page.dart';
import 'package:babylandrajkot/screens/product_list.dart';
import 'package:babylandrajkot/screens/subcategory_page.dart';
import 'package:babylandrajkot/service/woocommerce_bridge.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  var message = "Loading..";
  int currentPage = 1;
  ScrollController _scrollController = ScrollController();

  List<CategoryModel> _categories = List<CategoryModel>();
  Future<Null> getCategoryData(int page) async {
    if (!mounted) return;
    setState(() {
      page == 1 ? _loading = true : _loading = false;
    });

    responseData =
        await wooCommerceAPI.getAsync("products/categories?page=$page");
    responseData1 = await woo.getProductCategories(page: page,perPage: 20);
    print(responseData1);
    if (responseData.toString().length == 2) {
      print('There is nothing to show');
      if (!mounted) return;
      setState(() {
        message = "You have all the things that your baby needs 👶";
      });
      _pageLoading = false;
    } else {
      if (!mounted) return;
      setState(() {
        for (Map i in responseData) {
          _categories.add(CategoryModel.fromJson(i));
        }
        currentPage++;
        _loading = false;
        _pageLoading = false;
      });
    }
    _onlycategories =
        _categories.where((category) => category.parent == 0).toList();
//    _onlysubcategories = _categories.where((category) => category.parent != 0).toList();
//    }
  }

  var responseData;
  var responseData1;
  bool _loading = false;
  bool _pageLoading = false;
  List<CategoryModel> _onlycategories;
  List<CategoryModel> _particularsubcategories;

  @override
  void initState() {
    super.initState();

    _loading = true;
    getCategoryData(currentPage);
    _scrollController.addListener(() {
      if (!_pageLoading && _scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        print("current page is " + currentPage.toString());
        getCategoryData(currentPage);
        showInSnackBar(message);
        _pageLoading = true;
      }
    });
  }

  showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
    responseData.clear();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _scaffoldKey,
        body: _loading
            ? LoadingComponent()
            : RefreshIndicator(
                onRefresh: () {
//                   setState(
//                     () {
//                       currentPage = 1;
//                       responseData = null;
//                       message = "Loading..";
// //                      _categories.clear();
//                     },
//                   );
                  return getCategoryData(currentPage);
                },
                child: GridView.builder(
                  controller: _scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount:
                  null == _onlycategories ? 0 : _onlycategories.length,
                  itemBuilder: (BuildContext context, int index) {
                    CategoryModel category = _onlycategories[index];
                      return GestureDetector(
                        onTap: () {
                          print(category.id);
                          _particularsubcategories = _categories
                              .where(
                                  (category1) => category1.parent == category.id)
                              .toList();

//                          print(_getSubCat(category.id));
                          print(_particularsubcategories.length.toString());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                if (_particularsubcategories.length == 0) {
                                  return ProductList(catId: category.id);
                                } else {
                                  return SubcategoryList(category.id,category.name);
                                }
                              },
                            ),
                          );
                        },
//                        child: CategoryCard(category: category),
                      );

                  },

                ),
              ));
  }
}


