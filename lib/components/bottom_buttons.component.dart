import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/utils/app_colors.dart';

class BottomButtonsComponent extends StatefulWidget {
  const BottomButtonsComponent({
    required this.cancelAction,
    required this.confirmAction,
    this.confirmText,
    this.cancelText,
    this.disabled = false,
    this.confirmIcon,
    this.cancelIcon,
    this.iconSize,
    this.cancelColor,
    this.confirmColor,
    this.confirmButtonColor,
  });

  final Function()? confirmAction, cancelAction;
  final String? confirmText, cancelText;
  final IconData? confirmIcon, cancelIcon;
  final bool disabled;
  final double? iconSize;
  final Color? cancelColor, confirmColor, confirmButtonColor;

  @override
  _BottomButtonsComponentState createState() => _BottomButtonsComponentState();
}

class _BottomButtonsComponentState extends State<BottomButtonsComponent> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Expanded>[
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: HexColor('#FFFFFF'),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (widget.cancelIcon != null)
                      Icon(
                        widget.cancelIcon,
                        color: Colors.white,
                        size: 18.0,
                      ),
                    Text(
                      widget.cancelText?.toUpperCase() ?? 'CANCELAR',
                      style: TextStyle(
                        color: widget.cancelColor ?? HexColor('#6A6F86'),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                onPressed: widget.cancelAction,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: widget.disabled
                        ? Colors.grey
                        : widget.confirmButtonColor ?? AppColors.primaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      if (widget.confirmIcon != null)
                        Icon(
                          widget.confirmIcon,
                          color: widget.confirmColor ?? Colors.white,
                          size: widget.iconSize ?? 18.0,
                        ),
                      if (widget.confirmIcon != null) const SizedBox(width: 5.0),
                      Text(
                        widget.confirmText?.toUpperCase() ?? 'AVANÇAR',
                        style: TextStyle(
                          color: widget.confirmColor ?? HexColor('#FFFFFF'),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  onPressed: widget.disabled ? () {} : widget.confirmAction,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
