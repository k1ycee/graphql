import 'package:flutter/material.dart';

class AuthButton extends StatefulWidget {
  final Color buttonColor;
  final Widget name;
  final double height;
  final double width;
  final Function tap;
  final bool busy;
  final LinearGradient gradient;

  const AuthButton(
      {Key key,
      this.buttonColor,
      @required this.name,
      @required this.tap,
      this.height,
      this.width,
      this.busy = false,
      this.gradient})
      : super(key: key);
  @override
  _AuthButtonState createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.tap,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.buttonColor,
            gradient: widget.gradient,
            boxShadow: [
              BoxShadow(
                blurRadius: 5.0,
                color: Color(0x20000000),
                spreadRadius: 0.0,
                offset: Offset(3.5, 5.0),
              ),
            ]),
        child: Center(
            child: widget.busy
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  )
                : widget.name),
      ),
    );
  }
}
