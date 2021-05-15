import 'dart:convert';

import 'package:csc_picker/csc_picker.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_task/components/default_button.dart';
import 'package:flutter_app_task/components/form_error.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../constants.dart';
import '../../size_config.dart';



class HomeForm extends StatefulWidget {

  @override
  _HomeFormState createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {

  bool isloading = false;
  final _formKey = GlobalKey<FormState>();
  String email;
  String name;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }



  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          CSCPicker(
            showStates: false,
            showCities: false,
            flagState: CountryFlag.DISABLE,
            dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                border:
                Border.all(color: Colors.grey.shade300, width: 1)),


            disabledDropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.grey.shade300,
                border:
                Border.all(color: Colors.grey.shade300, width: 1)),

            defaultCountry: DefaultCountry.India,

            selectedItemStyle: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),

            dropdownHeadingStyle: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold),

            dropdownItemStyle: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),

            dropdownDialogRadius: 10.0,
            searchBarRadius: 10.0,
            onCountryChanged: (value) {
              setState(() {
                countryValue = value;
              });
            },
            onStateChanged: (value) {
              setState(() {
                stateValue = value;
              });
            },
            onCityChanged: (value) {
              setState(() {
                cityValue = value;
              });
            },
          ),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Print",
            press: ()
              async {
                _showMyDialog();

              },
          ),
        ],
      ),
    );
  }


  TextFormField buildNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        name = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNameNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Enter your name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        email = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }



  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('HTML Text:'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Html(data:"<h1><p>$name<p></h1>"),
                Html(data:"<h1><p>$email<p></h1>"),
                Html(data:"<h1><p>$countryValue<p></h1>"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Post'),
              onPressed: () {
                sendData();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> sendData() async {
    setState(() {
      isloading = true;

    });
    await Dio().post("https://taskappflutter-default-rtdb.firebaseio.com//userprofile.json",
        data: json.encode({
          'name': name,
          'email': email,
          'country': countryValue,
        }));
    setState(() {
      isloading = false;
    });
  }
}
