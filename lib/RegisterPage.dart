import 'package:flutter/material.dart';
import 'MainMenu.dart';
import 'MyHomePage.dart';

import 'authprovider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(
            image: new AssetImage('assets/diyo.png'),
            width: 150,
            height: 150,
          ),
        ],
      ),
    );
  }
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final iskeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: isLoading == false
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (!iskeyboard) Logo(),
                    TextFormField(
                      controller: _email,
                      decoration: InputDecoration(hintText: "Email"),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _password,
                      decoration: InputDecoration(hintText: "Password"),
                    ),
                    FlatButton(
                        color: Colors.blue,
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          AuthClass()
                              .createAccount(
                                  email: _email.text.trim(),
                                  password: _password.text.trim())
                              .then((value) {
                            if (value == "Account created") {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()),
                                  (route) => false);
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(value)));
                            }
                          });
                        },
                        child: Text("Create account")),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()));
                      },
                      child: Text("Already have an account? Login "),
                    ),
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator()));
  }
}
