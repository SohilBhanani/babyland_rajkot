import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/database_service.dart';
import '../shared/colors.dart';
import '../shared/ui_helpers.dart';


class MyBottomSheet extends StatefulWidget {
  final BuildContext ctx;
  final String uid;
  MyBottomSheet({this.ctx, this.uid});
  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  final _addressController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 300,
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                verticalSpaceSmall,
                TextFormField(
                    // inputFormatters: [new FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9@.-]")),],
                    validator: (value) => value.isEmpty || value.length < 5
                        ? 'Please Enter Proper Address'
                        : null,
                    controller: _addressController,
                    maxLines: null,
                    decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.black),
                        labelText: 'Enter/Update Address',
                        hintMaxLines: 2,
                        border: OutlineInputBorder())),
                FlatButton(
                  shape: roundedCornerShape(10),
                  onPressed: () {
                    if (_formkey.currentState.validate())
                      Provider.of<DbService>(context, listen: false)
                          .updateUserAddress(
                              widget.uid, _addressController.text);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Save',
                    style:
                        myTextTheme(context).button.apply(color: Colors.white),
                  ),
                  color: kPrim,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
