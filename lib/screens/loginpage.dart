import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ufinix/brand_colors.dart';
import 'package:ufinix/screens/mainpage.dart';
import 'package:ufinix/screens/registrationpage.dart';
import 'package:ufinix/widgets/TaxiButton.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
var emailController = TextEditingController();
var passwordController = TextEditingController();

void loginUser() async {
  try {
    UserCredential user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
  } catch (e) {
    print(e);

    if (UserCredential != null) {
      print("Berhasil Masuk");
    }
  }
}

// void loginUser() async {
//   try {
//     FirebaseAuth.instance.signInWithEmailAndPassword(
//       email: emailController.text,
//       password: passwordController.text,
//     );
//   } catch (e) {
//     print(e);
//   }
// }

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[50],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 70,
                  ),
                  Image(
                    alignment: Alignment.center,
                    height: 100.0,
                    width: 100.0,
                    image: AssetImage('images/logo.png'),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Masuk Sebagai Mitra",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: ('Brand-Bold'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: emailController,
                          maxLength: 20,
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Alamat E-mail",
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            ),
                          ),
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        TextField(
                          maxLength: 15,
                          controller: passwordController,
                          obscureText: true,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Kata Sandi",
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            ),
                          ),
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TaxiButton(
                            title: "MASUK",
                            color: BrandColors.colorGreen,
                            onPressed: () {
                              loginUser();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MainPage()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegistrationPage()));
                    },
                    child: Text('Belum Punya Akun?, Yuk Gabung'),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
