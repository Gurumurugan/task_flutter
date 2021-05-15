import 'package:flutter/material.dart';
import 'package:flutter_app_task/home/home_screen.dart';
import 'package:flutter_app_task/routes.dart';
import 'package:flutter_app_task/sign_in/sign_in_screen.dart';
import 'package:flutter_app_task/sign_up/sign_up_screen.dart';
import 'package:flutter_app_task/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  print(email);
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      home: email == null ? SignUpScreen() : SignInScreen()));
}

/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      initialRoute: HomeScreen.routeName,
      routes: routes,
    );
  }
}
*/
