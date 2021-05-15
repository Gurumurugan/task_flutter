import 'package:flutter/widgets.dart';
import 'package:flutter_app_task/sign_in/sign_in_screen.dart';
import 'package:flutter_app_task/sign_up/sign_up_screen.dart';
import 'home/home_screen.dart';




// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SignInScreen.routeName: (context) => SignInScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
};
