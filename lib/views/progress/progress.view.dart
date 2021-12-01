import 'package:flutter/material.dart';
import 'package:nicotine/components/appBar/default_appbar.component.dart';

class ProgressView extends StatefulWidget {
  const ProgressView();

  @override
  _ProgressViewState createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: DefaultAppBarComponent(context));
  }
}
