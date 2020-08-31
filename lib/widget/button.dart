import 'package:flutter/material.dart';
import 'package:trikcuan_app/utilities/app_consts.dart';
import 'package:trikcuan_app/widget/loading.dart';

class RaisedButtonPrimary extends StatelessWidget {
  const RaisedButtonPrimary({
    Key key,
    this.text,
    this.onPressed,
    this.padding,
    this.fontSize,
    this.icon,
    this.radius,
    this.isLoading = false
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final double padding;
  final double fontSize;
  final double radius;
  final IconData icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return RaisedButtonCustom(
      onPressed: onPressed,
      padding: padding,
      fontSize: fontSize,
      icon: icon,
      text: text,
      color: AppColor.primary,
      radius: radius,
      isLoading: isLoading
    );
  }
}

class RaisedButtonAccent extends StatelessWidget {
  const RaisedButtonAccent({
    Key key,
    this.text,
    this.onPressed,
    this.padding,
    this.fontSize,
    this.icon,
    this.isLoading = false
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final double padding;
  final double fontSize;
  final IconData icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return RaisedButtonCustom(
      onPressed: onPressed,
      padding: padding,
      fontSize: fontSize,
      icon: icon,
      text: text,
      color: AppColor.accent,
      isLoading: isLoading
    );
  }
}

class RaisedButtonDarkYellow extends StatelessWidget {
  const RaisedButtonDarkYellow({
    Key key,
    this.text,
    this.onPressed,
    this.padding,
    this.fontSize,
    this.icon,
    this.isLoading = false
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final double padding;
  final double fontSize;
  final IconData icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return RaisedButtonCustom(
      onPressed: onPressed,
      padding: padding,
      fontSize: fontSize,
      icon: icon,
      text: text,
      color: AppColor.darkYellow,
      isLoading: isLoading
    );
  }
}

class OutlineButtonPrimary extends StatelessWidget {
  const OutlineButtonPrimary({
    Key key,
    this.text,
    this.onPressed,
    this.padding,
    this.fontSize,
    this.icon,
    this.radius,
    this.isLoading = false
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final double padding;
  final double fontSize;
  final double radius;
  final IconData icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return RaisedButtonCustom(
      onPressed: onPressed,
      padding: padding,
      fontSize: fontSize,
      icon: icon,
      text: text,
      color: Colors.transparent,
      textColor: AppColor.primary,
      borderColor: AppColor.primary,
      radius: radius,
      isLoading: isLoading,
    );
  }
}

class RaisedButtonCustom extends StatelessWidget {
  const RaisedButtonCustom({
    Key key,
    this.text,
    this.onPressed,
    this.padding,
    this.fontSize,
    this.color,
    this.borderColor,
    this.textColor = Colors.white,
    this.icon,
    this.elevation = 0,
    this.radius,
    this.isLoading = false
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final double padding;
  final double fontSize;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final IconData icon;
  final double elevation;
  final double radius;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 8),
        side: BorderSide(color: borderColor ?? Colors.transparent, width: 1),
      ),
      disabledElevation: 0,
      padding: EdgeInsets.all(padding ?? 12),
      disabledColor: AppColor.disabledButton,
      disabledTextColor: Colors.white,
      color: color ?? AppColor.accent,
      textColor: Colors.white,
      elevation: elevation,
      hoverElevation: elevation,
      focusElevation: elevation,
      highlightElevation: elevation,
      child: isLoading ? LoadingForButton(
        height: fontSize != null ? fontSize + 4 : 16, 
        width: fontSize != null ? fontSize + 4 : 16,
      ) : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          icon != null ? Container(
            margin: EdgeInsets.only(right: text != null ? 8 : 0),
            child: Icon(icon, color: textColor, size: fontSize != null ? fontSize + 4 : 16),
          ) : Container(height: 0),
          Text(
            text ?? "", 
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: fontSize ?? 16,
              color: textColor
            )
          ),
        ],
      ),
    );
  }
}