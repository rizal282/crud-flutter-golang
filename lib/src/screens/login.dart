import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:owl_test/src/config/string_constant.dart';
import 'package:owl_test/src/screens/post_screen.dart';
import 'package:owl_test/src/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> loginUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map<String, dynamic> dataLogin = {
      "email": email.text,
      "password": password.text
    };

    await AuthService.loginUser(dataLogin).then((res) {
      if (res != null) {
        sharedPreferences.setString(StringConstant.keyPrefToken, res);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const PostScreen()));
      }

      // debugPrint("Gagal login, coba lagi nanti");
    });
  }

  Future<void> handleGoogleSignIn() async {
    try {
      await googleSignIn.signIn();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login User"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              TextFormField(
                controller: email,
                decoration: const InputDecoration(hintText: "Email"),
              ),
              TextFormField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Password",
                ),
              ),
              ElevatedButton(
                  onPressed: () async => await loginUser(),
                  child: const Text("Masuk")),
              ElevatedButton(
                  onPressed: () async => await handleGoogleSignIn(),
                  child: const Text("Google Sign In"))
            ],
          ),
        ),
      ),
    );
  }
}
