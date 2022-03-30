import 'package:flutter/material.dart';

class LogoComponent extends StatefulWidget {
  LogoComponent({
    this.size = 120,
    this.fullLogo = false,
  });

  final double size;
  final bool fullLogo;

  @override
  _LogoComponentState createState() => _LogoComponentState();
}

class _LogoComponentState extends State<LogoComponent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: widget.size,
          height: widget.size,
          child: Image.asset(
              widget.fullLogo ? 'assets/logo_transparente1.png' : 'assets/logo_transparente2.png')),
    );
  }
}
