import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddChat extends StatefulWidget {
  AddChat(this.createGroup);
  final Function createGroup;

  @override
  _AddChatState createState() => _AddChatState(createGroup: createGroup);
}

class _AddChatState extends State<AddChat> {
  _AddChatState({
    this.createGroup,
  });

  final Function createGroup;
  GlobalKey<FormState> _formKey;
  GlobalKey<FormState> _formKey1;
  DocumentReference doc;
  CollectionReference col;
  DocumentSnapshot docsnap;
  TextEditingController _controller;
  TextEditingController _controller1;
  Map<String, dynamic> data;

  void initState() {
    super.initState();
    _formKey1 = GlobalKey();
    _formKey = GlobalKey();
    _controller = TextEditingController();
    _controller1 = TextEditingController();
    asyncInit();
  }

  Future<void> asyncInit() async {
    await Firebase.initializeApp();
  }

  loadingfunction() async {
    doc = FirebaseFirestore.instance.collection('project').doc('myGroup');
    docsnap = await doc.get();
    data = docsnap.data();
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    String value = '';
    loadingfunction();
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text("Create a Conversations"),
            Text("Conversation Topic: "),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey1,
                child: TextFormField(
                  controller: _controller,
                ),
              ),
            ),
            Text("Enter Your Friends ID"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _controller1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (_controller.text != '' && _controller1.text != '') {
                    Navigator.pop(context);
                    createGroup(_controller.text);
                    col = FirebaseFirestore.instance.collection('profile');

                    await col.add({
                      'CreateTime': DateTime.now().toString(),
                      'GroupName': _controller.text,
                      'Id1': FirebaseAuth.instance.currentUser.uid,
                      'Id2': _controller1.text,
                      'id': FirebaseAuth.instance.currentUser.uid,
                      'messages': [],
                      'order': [],
                    });
                  } else {
                    _controller.text = 'Add a Text';
                    _controller1.text = 'Add a Text';
                  }
                },
                child: Text("Connect to my friend"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
