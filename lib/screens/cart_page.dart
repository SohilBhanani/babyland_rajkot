import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';

import '../components/checkout_ui_cart.dart';
import '../model/cart_bloc.dart';
import '../service/auth.dart';
import '../service/payment_service.dart';

class CartPage extends StatefulWidget {
  final Function newUser;
  CartPage(this.newUser);
  @override
  _CartPageState createState() => _CartPageState();

}

var a;

class _CartPageState extends State<CartPage> {

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  String getUid(){
    AuthService().getCurrentUser().then((value) {
      if (!mounted) return;
      setState(() {
        a = value;
      });

    });
    return a;
  }
  @override
  Widget build(BuildContext context) {

  var bloc = Provider.of<CartBloc>(context);
  var cart = bloc.cart;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart',style: TextStyle(color: Colors.black,fontSize: 22),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body:cart.length == 0
          ? Center(
        child: Column(
          //TODO: extract Cart is empty
          children: <Widget>[
            SizedBox(height: 100,),
            Container(
              height: 200,
              width: 200,
              child: Image.asset('assets/empty_cart.png'),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Text('Looks like your cart is empty !',style: TextStyle(fontSize: 28,color: Colors.black26),),
                SizedBox(height: 10,),
                OutlineButton(onPressed: ()=>Navigator.pop(context),color: Colors.blue,child: Text('Shop Now'),)
              ],
            )
          ],
        ),
      ): Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
//                  onTap: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ItemPage())),
                  child: Container(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 120,
                                width: 100,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.network(cart[index].product.images[0].src,fit: BoxFit.cover,)),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(top:10.0),
                                          child: Text(
                                            cart[index].product.name,
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      IconButton(icon: Icon(Icons.clear,color: Colors.black,), onPressed: () {
                                        bloc.clearItem(index);
                                      },)

                                    ],
                                  ),
                                  Html(
                                    style: {
                                      "body": Style(
                                        fontSize: FontSize(18.0),
                                      ),
                                    },
                                    data:
                                    '''${parse(cart[index].product.shortDescription).documentElement.innerHtml}''',
                                  ),
                                  Text(cart[index].size+" / "+ cart[index].color),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
//                                        child: Text(
//                                          '₹ '+ cart[index].product.regularPrice.toString(),
//                                          style: TextStyle(
//                                            fontWeight: FontWeight.w400,
//                                            fontSize: 22.0,
//                                            color: Colors.black,
//                                          ),
//                                        ),
                                      child: cart[index].product.salePrice == ''
                                          ? Text(
                                        '₹ ' + cart[index].product.regularPrice.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 22.0,
                                          color: Colors.black,
                                        ),
                                      )
                                          : Row(
                                        children: [
                                          Text(
                                            '₹ ' + cart[index].product.salePrice.toString(),
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
                                            '₹ ' + cart[index].product.regularPrice.toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.0,
                                              decoration: TextDecoration.lineThrough,
                                              color: Colors.grey[500],
                                            ),
                                          )
                                        ],
                                      ),
                                      ),
                                      IconButton(icon: Icon(Icons.add,color: Colors.green,size: 28,), onPressed: () { bloc.addQty(index); },

                                      ),
                                      Text(cart[index].qty.toString(),style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                                      IconButton(icon: Icon(Icons.remove,color: Colors.red,size: 25,), onPressed: () { bloc.removeQty(index); },)

                                        ],
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                        color: Colors.orangeAccent[50],
                      ),
                    ),
                  ),
                );
              },
              itemCount: cart.length,
            ),
          ),
//          Text(getUid()),
          CheckoutSection(context:context, bloc:bloc,uid: getUid())
        ],
      ),
    );
  }
}
