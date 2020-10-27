import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';
import '../../shared/ui_helpers.dart';

class RegisterScreen extends StatefulWidget {
  final Function toggleView;

  RegisterScreen({this.toggleView});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String contact = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return Form(
          key: _formKey,
          child: ListView(
            children: [
              verticalSpace(120),
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: roundedCorner(12),
                    color: Colors.white,
                  ),
                ),
              ),
              verticalSpace(20),
              const Center(
                  child: Text(
                'Babyland Registration',
                style: TextStyle(fontSize: 22),
              )),
              verticalSpace(20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(fontSize: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
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
                      return 'Please enter some text';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(fontSize: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      contact = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (value.length != 10) {
                      return 'Invalid Number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixText: '+91',
                    labelText: "Whatsapp Number",
                    labelStyle: TextStyle(fontSize: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
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
                      return 'Cannot be Empty';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Minimum 6 Characters',
                      labelStyle: TextStyle(fontSize: 18),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      confirmPassword = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (password != confirmPassword) {
                      return 'Passwords do not Match';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Confirm Password',
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
                    if (_formKey.currentState.validate()) if (password ==
                        confirmPassword) {
                      if (password.length < 6) {
                      } else {
                        Provider.of<AuthService>(context, listen: false)
                            .signUp(name, email, contact, password)
                            .then((value) {
                          Fluttertoast.showToast(
                              msg: value == null
                                  ? 'Registration Successful'
                                  : value.toString().substring(
                                      value.toString().indexOf(']') + 2),
                              backgroundColor:
                                  value == null ? Colors.green : Colors.red,
                              toastLength: Toast.LENGTH_LONG);
                          value == null ? Navigator.pop(context) : null;
                        });
                      }
                    } else {}
                  },
                  child: Provider.of<AuthService>(context).loading
                      ? Container(
                          height: 10,
                          width: 10,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ))
                      : Text('Join'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
