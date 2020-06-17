import 'package:currency_alarm/ui/styles/style.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Icon leftIcon;
  final Icon rightIcon;
  final Function onPressed;
  final String rightTitle;
  final Function onSkip;

  CustomAppBar(
      {Key key,
      @required this.title,
      @required this.leftIcon,
      this.rightIcon,
      this.onPressed,
      this.rightTitle,
      this.onSkip})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  Widget build(BuildContext context) {
    if (widget.rightTitle == null && widget.onPressed!=null) {
      return AppBar(
        actions: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: widget.rightIcon != null
                              ? lightColor.withOpacity(0.1)
                              : bgColor,
                          offset: Offset(-6, -6),
                          spreadRadius: 0,
                          blurRadius: 6,
                        ),
                        BoxShadow(
                          color: widget.rightIcon != null
                              ? Colors.black26
                              : bgColor,
                          offset: Offset(6, 6),
                          spreadRadius: 0,
                          blurRadius: 6,
                        )
                      ]),
                  child: Center(
                      child: IconButton(
                          icon: widget.rightIcon != null
                              ? widget.rightIcon
                              : Icon(Icons.account_circle),
                          color:
                              widget.rightIcon != null ? Colors.white : bgColor,
                          onPressed: widget.onPressed)),
                ),
              ),
            ),
          )
        ],
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              widget.leftIcon,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${widget.title}", style: appBarTitleStyle),
              ),
            ],
          ),
        ),
      );
    } else if (widget.rightTitle != null && widget.onSkip != null) {
      return AppBar(
        actions: <Widget>[
          Container(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: widget.rightIcon != null
                            ? lightColor.withOpacity(0.1)
                            : bgColor,
                        offset: Offset(-6, -6),
                        spreadRadius: 0,
                        blurRadius: 6,
                      ),
                      BoxShadow(
                        color:
                            widget.rightIcon != null ? Colors.black26 : bgColor,
                        offset: Offset(6, 6),
                        spreadRadius: 0,
                        blurRadius: 6,
                      )
                    ]),
                child: Center(
                  child: FlatButton(
                      color: bgColor,
                      onPressed: widget.onSkip,
                      child: Center(
                        child: Text(
                          widget.rightTitle,
                          style: subTitleStyle,
                        ),
                      )),
                ),
              ),
            ),
          ))
        ],
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              widget.leftIcon,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${widget.title}", style: appBarTitleStyle),
              ),
            ],
          ),
        ),
      );
    }
  }
}
