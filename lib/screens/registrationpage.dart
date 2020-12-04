import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ufinix/brand_colors.dart';
import 'package:ufinix/screens/loginpage.dart';
import 'package:ufinix/screens/mainpage.dart';
import 'package:ufinix/widgets/TaxiButton.dart';

class RegistrationPage extends StatelessWidget {
  static const String id = 'register';
  final GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title) {
    final snackbar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    scaffoldkey.currentState.showSnackBar(snackbar);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var fullNameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void registerUser() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } catch (e) {
      print(e);

      if (UserCredential != null) {
        print("Berhasil Registrasi");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldkey,
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
                    image: AssetImage('images/user_icon.png'),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Buat Akun Mitra",
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
                          controller: fullNameController,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Nama Lengkap :",
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
                          height: 20,
                        ),
                        TextField(
                          controller: phoneController,
                          obscureText: false,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: "No Telepon :",
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
                          controller: emailController,
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
                            title: "DAFTAR",
                            color: BrandColors.colorTextDark,
                            onPressed: () {
                              if (fullNameController.text.length < 3) {
                                showSnackBar(
                                    "Panjang nama anda kurang min 3 digit");
                                return;
                              }
                              if (phoneController.text.length < 10) {
                                showSnackBar(
                                    "Panjang No Telpon anda kurang min 10 digit");
                                return;
                              }

                              if (!emailController.text.contains('@')) {
                                showSnackBar("email anda tidak valid ");
                                return;
                              }

                              if (passwordController.text.length < 8) {
                                showSnackBar(
                                    "Panjang sandi anda kurang min 8 digit");
                                return;
                              }

                              registerUser();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text('Akun Mitra telah siap!, Masuk'),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
