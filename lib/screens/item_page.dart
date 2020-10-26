import 'package:babylandrajkot/components/get_upsells.dart';
import 'package:babylandrajkot/model/variation.dart';

import '../components/cart_icon_count.dart';
import '../model/cart_bloc.dart';
import '../model/product_model.dart';
import '../components/item_carousal.dart';
import 'package:babylandrajkot/service/woocommerce_bridge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';

class ItemPage extends StatefulWidget {
  final ProductModel item;

  ItemPage(
    this.item,
  );

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  int selectedQty = 1;
  var choiceSize = '';
  VariationModel partVar;

  final List<String> _dropDownValues = [];

  final List<int> _dropDownQuantity = [1, 2];

  final List<String> _dropDownColorsValues = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.item.attributes[0].options.length; i++) {
      _dropDownColorsValues
          .add(widget.item.attributes[0].options[i].toString());
    }
    for (int i = 0; i < widget.item.attributes[1].options.length; i++) {
      _dropDownValues.add(widget.item.attributes[1].options[i].toString());
    }
    choiceSize = _dropDownValues.first;
    widget.item.type == 'variable' ? fetchVariations(widget.item.id) : null;
    // widget.item.type == 'variable' ? varPrice(_dropDownValues.first) : null;
  }

  List<VariationModel> vars = [];

  fetchVariations(int id) async {
    var variableResponse =
        await wooCommerceAPI.getAsync("products/${widget.item.id}/variations");
    for (Map i in variableResponse) {
      vars.add(VariationModel.fromJson(i));
    }
    print(vars.length);
    if (!mounted) return;
    setState(() {
    varPrice(_dropDownValues.first);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _formkey1 = GlobalKey<FormState>();
    var choiceColor = '';
    var bloc = Provider.of<CartBloc>(context);
    // String salePrice =
    //     vars.length > 1 ? vars[0].salePrice : widget.item.salePrice;
    // String purchasePrice =
    //     vars.length > 1 ? vars[0].regularPrice : widget.item.regularPrice;
    // varPrice(choiceSize);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          CartIcon(bloc: bloc),
        ],
      ),
      backgroundColor: Colors.lightBlueAccent[50],
      body: ListView(
        children: <Widget>[
          widget.item.images.length == 3
              ? ItemCarousal(widget.item.images[0].src,
                  widget.item.images[1].src, widget.item.images[2].src)
              : ItemCarousal(
                  widget.item.images[0].src,
                  'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg',
                  'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
          Divider(),
          SizedBox(
            height: 5.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(widget.item.name, style: TextStyle(fontSize: 24)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: vars.length >1
                    ? varPrice(choiceSize)
                    : itemPrice(
                        widget.item.regularPrice, widget.item.salePrice),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          //Size Color and Qty Dropdown
          widget.item.inStock
              ? Form(
                  key: _formkey1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      //size dropdown
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.black),
                          ),
                          child: SizedBox(
                            width: 100,
                            child: DropdownButtonFormField(
                              validator: (val) =>
                                  val == null ? 'Please Select Size' : null,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              items: _dropDownValues
                                  .map((value) => DropdownMenuItem(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(value.toString()),
                                        ),
                                        value: value,
                                      ))
                                  .toList(),
                              onChanged: (String value) {
                                // choiceSize = value;
                                setState(() {
                                  choiceSize = value;

                                });
                              },
                              hint: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text('Sizes'),
                              ),
                              isExpanded: false,
                              value: choiceSize,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      //Color dropdown
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.black),
                          ),
                          child: SizedBox(
                            width: 100,
                            child: DropdownButtonFormField(
                              validator: (val) =>
                                  val == null ? 'Please Select Color' : null,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              items: _dropDownColorsValues
                                  .map((value) => DropdownMenuItem(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(value.toString()),
                                        ),
                                        value: value,
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                choiceColor = value;
                              },
                              hint: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text('Colors'),
                              ),
                              isExpanded: false,
                              value: null,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      //Quantity dropdown
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Text('Qty'),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.black),
                              ),
                              child: SizedBox(
                                width: 100,
                                child: DropdownButtonFormField(
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                  items: _dropDownQuantity
                                      .map((value) => DropdownMenuItem(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(value.toString()),
                                            ),
                                            value: value,
                                          ))
                                      .toList(),
                                  onChanged: (int value) {
                                    selectedQty = value;
                                  },
                                  isExpanded: false,
                                  value: _dropDownQuantity.first,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                    ],
                  ),
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 18),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: widget.item.inStock
                      ? MaterialButton(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Add to Cart',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.call_made,
                              )
                            ],
                          ),
                          onPressed: () {
                            if (_formkey1.currentState.validate())
                              bloc.addToCart(widget.item, choiceSize,
                                  choiceColor, selectedQty);
                          },
                          color: Colors.pink[100],
                        )
                      : Text(
                          'Currently Out of Stock !',
                          style: TextStyle(color: Colors.red),
                        ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ExpansionTile(
            title: Text('Product Details'),
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: Html(
                    data:
                        '''${parse(widget.item.description).documentElement.innerHtml}''',
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'Related Products',
              style: TextStyle(fontSize: 17),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          GetUpsells(widget.item),
          SizedBox(
            height: 85.0,
          )
        ],
      ),
    );
  }

  Widget itemPrice(String regular, String sale) {
    return sale == ''
        ? Text(
            '₹' + regular.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 22.0,
              color: Colors.black,
            ),
          )
        : Row(
            children: [
              Text(
                '₹' + sale.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 22.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '₹' + regular.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey[500],
                ),
              )
            ],
          );
  }

  Widget varPrice(String choice) {
      void doOne(int i){
        if (vars[i].attributes[0].option == choice) {
          partVar = vars[i];
        }
      }
      void doTwo(int i){
        vars[i].attributes.where((element) {
          print('element $element');
          if(element.option == choice){
            partVar = vars[i];
          }
          return element.option==choice;});
      }

    for (int i = 0; i < vars.length; i++) {
      switch(vars[i].attributes.length){
        case 1:
          doOne(i);
          break;
        case 2:
          doTwo(i);
          break;
      }
      //TODO: Fix IT
      // if (vars[i].attributes[0].option == choice) {
      //   partVar = vars[i];
      // }
    }
    if(partVar.salePrice==null){
      return CircularProgressIndicator();
    }
    return partVar.salePrice == ''
        ? Text(
            '₹' + partVar.regularPrice.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 22.0,
              color: Colors.black,
            ),
          )
        : Row(
            children: [
              Text(
                '₹' + partVar.salePrice.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 22.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '₹' + partVar.regularPrice.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey[500],
                ),
              )
            ],
          );
  }
}
