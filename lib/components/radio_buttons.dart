import 'package:babyland_optimised/services/color_size_choice.dart';
import 'package:babyland_optimised/shared/colors.dart';
import 'package:babyland_optimised/shared/ui_helpers.dart';
import 'package:direct_select/direct_select.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCustomRadio extends StatefulWidget {
  final List<String> attr;
  final bool isColor;

  MyCustomRadio({
    this.attr,
    this.isColor = false,
  });

  @override
  _MyCustomRadioState createState() => _MyCustomRadioState();
}

class _MyCustomRadioState extends State<MyCustomRadio> {
  int _currentindex = 0;

  List<Widget> _buildAttr() {
    return widget.attr
        .map((val) => MySelectionItem(
              title: val,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    widget.isColor
        ? Provider.of<ChoiceService>(context).color = widget.attr[_currentindex]
        : Provider.of<ChoiceService>(context).size = widget.attr[_currentindex];
    return widget.attr.length == 1
        ? Card(
            child: Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.attr[_currentindex],
                      style: myTextTheme(context).button,
                    ),
                    Text('(only)')
                  ],
                ))),
          )
        : DirectSelect(
            backgroundColor: kPrim,
            selectedIndex: _currentindex,
            mode: DirectSelectMode.tap,
            child: MySelectionItem(
              isForList: false,
              title: widget.attr[_currentindex],
            ),
            items: _buildAttr(),
            onSelectedItemChanged: (index) {
              setState(() {
                _currentindex = index;
                widget.isColor
                    ? Provider.of<ChoiceService>(context, listen: false)
                        .setColor(widget.attr[_currentindex])
                    : Provider.of<ChoiceService>(context, listen: false)
                        .setSize(widget.attr[_currentindex]);
              });
            },
            itemExtent: 45,
          );
  }
}

class MySelectionItem extends StatelessWidget {
  final String title;
  final bool isForList;

  const MySelectionItem({Key key, this.title, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: isForList
          ? Padding(
              child: _buildItem(context),
              padding: EdgeInsets.all(10.0),
            )
          : Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Stack(
                children: <Widget>[
                  _buildItem(context),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ),
    );
  }

  _buildItem(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Text(title,
          style: isForList
              ? myTextTheme(context).button.apply(color: Colors.white)
              : myTextTheme(context).button),
    );
  }
}
