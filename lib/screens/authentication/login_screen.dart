import 'package:babyland_optimised/screens/authentication/register_screen.dart';
import 'package:babyland_optimised/services/auth_service.dart';
import 'package:babyland_optimised/shared/colors.dart';
import 'package:babyland_optimised/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            verticalSpace(180),
            verticalSpaceSmall,
            Center(
                child: Text(
              'Babyland Login',
              style: Theme.of(context).textTheme.headline3,
            )),
            verticalSpaceSmall,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                inputFormatters: [
                  new FilteringTextInputFormatter.allow(
                      RegExp("[a-zA-Z0-9@.]")),
                ],
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your email';
                  }

                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .apply(color: kPrim),
                    border:
                        OutlineInputBorder(borderRadius: roundedCorner(12))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter password';
                  }

                  return null;
                },
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .apply(color: kPrim),
                    border:
                        OutlineInputBorder(borderRadius: roundedCorner(12))),
              ),
            ),
            verticalSpaceSmall,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                color: kPrim,
                splashColor: Colors.orangeAccent,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Provider.of<AuthService>(context, listen: false)
                        .signIn(email, password)
                        .then((value) {
                      Fluttertoast.showToast(
                          msg: value == null
                              ? 'Login Successful'
                              : value
                                  .toString()
                                  .substring(value.toString().indexOf(']') + 2),
                          backgroundColor:
                              value == null ? Colors.green : Colors.red,
                          toastLength: Toast.LENGTH_LONG);
                    });
                  }
                },
                child: Provider.of<AuthService>(context).loading == true
                    ? Container(
                        height: 10,
                        width: 10,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'LOGIN',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .apply(color: Colors.white),
                      ),
                shape: roundedCornerShape(8),
              ),
            ),
            verticalSpaceSmall,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'New to Babyland? ',
                  style: myTextTheme(context).bodyText1,
                ),
                GestureDetector(
                  onTap: () {
                    print('Navigate to signup screen');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                  },
                  child: Text(
                    'Click Here',
                    style: myTextTheme(context).bodyText1.apply(color: kSec),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
