import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'MainMenu.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  TextEditingController _userName = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: const Color(0xFFFFBD00),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  new AssetImage('assets/defaultphoto.jpg'))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: const Color(0xFFFFBD00),
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('ChattingID',
                    style: TextStyle(color: Colors.amber, fontSize: 15)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(
                          text: FirebaseAuth.instance.currentUser.uid));
                    },
                    child: Text(FirebaseAuth.instance.currentUser.uid)),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('Username',
                    style: TextStyle(color: Colors.amber, fontSize: 15)),
              ),
              TextFormField(
                controller: _userName,
                decoration: InputDecoration(
                    hintText:
                        FirebaseAuth.instance.currentUser.displayName == null
                            ? 'Enter Username'
                            : FirebaseAuth.instance.currentUser.displayName),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('Password',
                    style: TextStyle(color: Colors.amber, fontSize: 15)),
              ),
              TextFormField(
                controller: _password,
                decoration: InputDecoration(hintText: '***************'),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('E-Mail',
                    style: TextStyle(color: Colors.amber, fontSize: 15)),
              ),
              TextFormField(
                enabled: false,
                controller: _email,
                decoration: InputDecoration(
                    hintText: FirebaseAuth.instance.currentUser.email),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      print(FirebaseAuth.instance.currentUser.uid);
                      Navigator.pop(context);
                    },
                    child: Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      print(FirebaseAuth.instance.currentUser.uid);
                      setState(() {
                        if (_userName.text.isNotEmpty) {
                          FirebaseAuth.instance.currentUser.updateProfile(
                            displayName: _userName.text,
                          );
                        } else {}
                        if (_password.text.isNotEmpty) {
                          FirebaseAuth.instance.currentUser
                              .updatePassword(_password.text);
                        } else {}
                      });
                    },
                    color: const Color(0xFFFFBD00),
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
