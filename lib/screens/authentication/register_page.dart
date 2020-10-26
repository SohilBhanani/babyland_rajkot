import 'package:babylandrajkot/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterPage extends StatefulWidget {
  final Function toggleView;

  RegisterPage({this.toggleView});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String contact = '';
  bool _loading = false;

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
                height: 120,
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
                      'https://image.flaticon.com/icons/svg/3135/3135322.svg',
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                'Babyland Registration',
                style: TextStyle(fontSize: 22),
              )),
              SizedBox(
                height: 10,
              ),
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
                      setState(() {
                        _loading = false;
                      });
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
                  inputFormatters: [new FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9@.]")),],
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });

                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        _loading = false;
                      });
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
                      setState(() {
                        _loading = false;
                      });
                      return 'Please enter some text';
                    }
                    if(value.length!=10){
                      setState(() {
                        _loading = false;
                      });
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
                      setState(() {
                        _loading = false;
                      });
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
                      setState(() {
                        _loading = false;
                      });
                      return 'Please enter some text';

                    }
                    if(password!=confirmPassword){
                      setState(() {
                        _loading = false;
                      });
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
                    setState(() {
                      _loading = true;
                    });
                    if(_formKey.currentState.validate())
                    if (password == confirmPassword) {
                      if (password.length < 6) {
                        //TODO: Show Snackbar
                      } else {
                        _auth
                            .registerWithEmailAndPassword(
                                name, email, contact, password)
                            .then(
                              (value) {
                                _showSnak(context, value.toString());

                            }
                            );
                      }
                    } else {
//                    _formKey.currentState.validate();
                    }
                  },
                  child: _loading?Container(height: 10,width: 10,child: CircularProgressIndicator(strokeWidth: 2,)):Text('Join'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        );
        }
      ),
    );
  }
  _showSnak(context, String value){
    print('This is the value:'+value);
    return value.startsWith('U') ?Scaffold.of(context)
        .showSnackBar(
      SnackBar(
        content: Text('Welcome To Babyland'),
        duration: Duration(
            milliseconds: 3200),
      ),
    ).closed.then((value){
      setState(() {
        _loading = false;
        Navigator.pop(context);
      });
    }) : Scaffold.of(context)
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
        Navigator.pop(context);
      });
    });
  }
}
