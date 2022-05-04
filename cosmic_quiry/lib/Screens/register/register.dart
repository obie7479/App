
import 'package:cosmic_quiry/Components/popup.dart';
import 'package:cosmic_quiry/Screens/home/home.dart';
import 'package:cosmic_quiry/Screens/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterScreen createState() => RegisterScreen();
}

class RegisterScreen extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var jsonResponse;
  bool isLoading = false;
  signUp(String name, String account, String password) async {
    const url = "https://blogcq.herokuapp.com/api/register";
    Map body = {"name": name, "account": account, "password": password};

    var res = await http.Client().post(Uri.parse(url), body: body);
    if (res.statusCode == 200) {
      // var jsonResponse = json.decode(res.body);
      var jsonResponse = res.body;
      print("Response status: ${res.statusCode}");
      if (jsonResponse.toString().length <= 5) {
        setState(() {
          isLoading = true;
        });
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('jwt', jsonResponse);
      // kayıt başarılı!

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  HomeScreen.fromBase64(jsonResponse)),
          (Route<dynamic> route) => false);

      showDialog(
        context: context,
        builder: (_) => PopUpDialog(
          title: "Registration Error",
          content: "Email / password is wrong!",
          page: RegisterPage(),
        ),
        //barrierDismissible: false,
      );
    } else {
      setState(() {
        isLoading = false;
      });

      showDialog(
        context: context,
        builder: (_) => PopUpDialog(
          title: "Registration Successfull!",
          content: "Please login with your credentials!",
          page: LoginPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Register",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2661FA),
                    fontSize: 36),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: "Username"),
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: ElevatedButton(
                onPressed: usernameController.text == "" ||
                        passwordController.text == ""
                    ? null
                    : () {
                        setState(() {
                          isLoading = true;
                        });
                        signUp(usernameController.text, emailController.text,
                            passwordController.text);
                      },

                //shape: RoundedRectangleBorder(
                //    borderRadius: BorderRadius.circular(80.0)),
                //textColor: Colors.white,
                //padding: const EdgeInsets.all(0),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: const EdgeInsets.all(0)),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: new LinearGradient(colors: [
                        Color.fromARGB(255, 255, 136, 34),
                        Color.fromARGB(255, 255, 177, 41)
                      ])),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "Sign Up",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()))
                },
                child: Text(
                  "Already Have an Account? Login",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
