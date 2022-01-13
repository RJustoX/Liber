import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SelectRadioComponent extends StatefulWidget {
  const SelectRadioComponent({
    required this.options,
    this.selectedOption = 0,
    this.valueIsWidget = false,
    this.loading = false,
    this.callback,
  });

  final int selectedOption;
  final Map<dynamic, dynamic> options;
  final bool valueIsWidget;
  final bool loading;
  final Function(int?)? callback;
  @override
  _SelectRadioComponentState createState() => _SelectRadioComponentState();
}

class _SelectRadioComponentState extends State<SelectRadioComponent> {
  late List<Widget> _options;

  @override
  Widget build(BuildContext context) {
    _options = <Widget>[];

    widget.options.forEach((dynamic key, dynamic value) {
      _options.add(
        RadioListTile<int>(
          title: widget.valueIsWidget
              ? value
              : Text(
                  value,
                  style: TextStyle(
                    color: HexColor('#3C3F4C'),
                    fontSize: 16.0,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
          controlAffinity: ListTileControlAffinity.trailing,
          value: key,
          selected: widget.selectedOption == key,
          groupValue: widget.selectedOption,
          onChanged: widget.callback,
        ),
      );
    });

    if (_options.isEmpty) {
      _options.add(
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 16.0,
          ),
          child: Text(
            'Nenhuma opção disponível',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      child: widget.loading
          ? const Center(child: CircularProgressIndicator())
          : Scrollbar(
              child: ListView(
                shrinkWrap: true,
                children: _options,
              ),
            ),
    );
  }
}
