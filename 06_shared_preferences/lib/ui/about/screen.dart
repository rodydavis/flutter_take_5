import 'package:flutter/material.dart';

import '../../generated/i18n.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(I18n.of(context).aboutTitle),
      ),
      body: Container(),
    );
  }
}
