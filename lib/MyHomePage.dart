import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MainMenu.dart';
import 'RegisterPage.dart';
import 'authprovider.dart';
import 'list_provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
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

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    RegisterArea();
  }

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final iskeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
            MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  AuthClass()
                      .signIN(
                      email: _email.text.trim(),
                      password: _password.text.trim())
                      .then((value) {
                    if (value == "Welcome") {
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChangeNotifierProvider<ListProvider>(
                                create: (context) => ListProvider(),
                                child: MainMenu(),
                              ),
                        ),
                      );
                    } else {
                      setState(() {
                        isLoading = false;
                      });
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(value)));
                    }
                  });
                },
                child: Text("Log In ")),
            SizedBox(
              height: 20,
            ),
            Text(
              "No account ?",
              style: TextStyle(fontSize: 20),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ));
              },
              child: Text(
                "Register",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
            ),
          ],
        ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class RegisterArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.symmetric(vertical: 50, horizontal: 40),
      child: Column(
        children: [
          Text(
            "No account ?",
            style: TextStyle(fontSize: 20),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(),
                  ));
            },
            child: Text(
              "Register",
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
