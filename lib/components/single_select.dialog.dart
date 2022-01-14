import 'package:flutter/material.dart';
import 'package:nicotine/components/bottom_buttons.component.dart';
import 'package:nicotine/components/select_radio.component.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleSelectDialogComponent extends StatefulWidget {
  const SingleSelectDialogComponent({
    required this.selectedOption,
    required this.options,
    this.callback,
    this.title = '',
  });

  final String title;
  final int selectedOption;
  final Map<dynamic, dynamic> options;
  final Function(String?)? callback;

  @override
  _SingleSelectDialogComponentState createState() => _SingleSelectDialogComponentState();
}

class _SingleSelectDialogComponentState extends State<SingleSelectDialogComponent> {
  late int _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Selecione uma opção',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.sp),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SelectRadioComponent(
              options: widget.options,
              selectedOption: _selectedOption,
              callback: (dynamic status) {
                setState(() => _selectedOption = status);
              },
            ),
          ),
          BottomButtonsComponent(
            confirmAction: () => Navigator.of(context).pop(_selectedOption),
            cancelAction: () => Navigator.of(context).pop(),
            confirmText: 'Salvar',
          )
        ],
      ),
    );
  }
}
