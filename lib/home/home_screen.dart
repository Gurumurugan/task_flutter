import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home", style: headingStyle),
      ),
      body: Body(),
    );
  }
}
