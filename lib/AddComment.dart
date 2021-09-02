import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddComment extends StatefulWidget {
  AddComment(this.createGroup, this.documentid);
  final Function createGroup;
  final String documentid;

  @override
  _AddCommentState createState() => _AddCommentState(createGroup: createGroup);
}

class _AddCommentState extends State<AddComment> {
  _AddCommentState({
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
  String documentid;

  void initState() {
    super.initState();
    _formKey1 = GlobalKey();
    _formKey = GlobalKey();
    _controller = TextEditingController();
    _controller1 = TextEditingController();
    documentid = widget.documentid;
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
            Text("Share Your Comment"),
            Text("Your Comment: "),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey1,
                child: TextFormField(
                  controller: _controller,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (_controller.text != '') {
                    Navigator.pop(context);
                    createGroup(_controller.text);
                    doc = FirebaseFirestore.instance
                        .collection('project')
                        .doc(documentid);

                    await doc.update({
                      'messages': FieldValue.arrayUnion([_controller.text]),
                      'id': FirebaseAuth.instance.currentUser.uid,
                    });
                  } else {
                    _controller.text = 'Add a Text';
                  }
                },
                child: Text("SHARE MY IDEA !"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
