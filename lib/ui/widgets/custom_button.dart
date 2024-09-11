import 'package:flutter/material.dart';
import 'package:emembers/constants.dart';

class EmembersButton extends StatelessWidget {
  final double? width;
  final double? height;
  final onPressed;
  final String? title;
  final IconData? icon;
  final double iconSize;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  EmembersButton({
    Key? key,
    this.width,
    this.height,
    this.title,
    this.onPressed,
    this.icon,
    this.backgroundColor = AppColors.primaryColor,
    this.textColor = AppColors.white,
    this.borderColor = AppColors.notWhite,
    this.iconSize = 18.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    EdgeInsetsGeometry edgeInsets = EdgeInsets.all(0);
    if (width == null || height == null) {
      edgeInsets = EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0);
    }
    return Padding(
      padding: edgeInsets,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: width,
          height: height,
          padding: edgeInsets,
          decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
              boxShadow: [
                BoxShadow(
                    color: backgroundColor.withOpacity(0.3),
                    blurRadius: 4.0,
                    offset: Offset(0.0, 5.0)),
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildIcon(_theme),
                _buildTitle(_theme),
              ],
            ),
          ),
        ),
      ),
    );
    /*RaisedButton(
      onPressed: onPressed,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(
          AppSizes.buttonRadius
        )
      ),
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        child: Text(title,
          style: _theme.textTheme.button.copyWith(
            backgroundColor: _theme.textTheme.button.backgroundColor,
            color: _theme.textTheme.button.color
          )
        )
      )
    );*/
  }

  Widget _buildTitle(ThemeData _theme) {
    return Text(
      title!,
      style: _theme.textTheme.labelLarge!.copyWith(
        backgroundColor: _theme.textTheme.labelLarge!.backgroundColor,
        color: textColor,
      ),
    );
  }

  Widget _buildIcon(ThemeData theme) {
    if (icon != null) {
      return Padding(
        padding: const EdgeInsets.only(
          right: 8.0,
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: textColor,
        ),
      );
    }

    return SizedBox();
  }
}
