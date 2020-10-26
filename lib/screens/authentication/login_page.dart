import 'package:babylandrajkot/screens/authentication/register_page.dart';
import 'package:babylandrajkot/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;

  LoginPage({this.toggleView});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email='';
  String password='';
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Builder(
        builder: (BuildContext context){
        return Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(
                height: 180,
              ),
              Center(
                child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.white,
                    ),
                    child: SvgPicture.network(
                      'https://image.flaticon.com/icons/svg/3093/3093186.svg',
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                    'Babyland Login',
                    style: TextStyle(fontSize: 22),
                  )),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  inputFormatters: [new FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9@.]")),],

                  onChanged: (value){
                    setState(() {
                      email = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        _loading = false;
                      });
                      return 'Please enter your email';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(fontSize: 18),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value){
                    setState(() {
                      password = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        _loading = false;
                      });
                      return 'Please enter password';
                    }

                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontSize: 18),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlineButton(

                  color: Colors.white,
                  splashColor: Colors.orangeAccent,
                  onPressed: () {
                    if(_formKey.currentState.validate()){
                      setState(() {
                        _loading = true;
                      });
                    AuthService().signInWithEmailAndPassword(email, password).then((value) => _showSnak(context, value.toString()));
                    }
                  },
                  child: _loading?Container(height: 10,width: 10,child: CircularProgressIndicator(strokeWidth: 2,),):Text('Login'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),

                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('New to Babyland? '),
                  GestureDetector(
                    onTap: () {
                      print('Navigate to signup screen');
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterPage()));
                    },
                    child: Text(
                      'Click Here',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              )
            ],
          ),
        );
        },
      ),
    );
  }
  _showSnak(context, String value){
    return Scaffold.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
            value.substring(value.indexOf(']')+2)),
        duration: Duration(
            milliseconds: 3200),
      ),
    ).closed.then((value){
      setState(() {
        _loading = false;
      });
    });
  }
}
