import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Chat.dart';
import 'AddComment.dart';
import 'DynamicList.dart';
import 'list_provider.dart';
import 'package:provider/provider.dart';
import 'AddScreen.dart';
import 'user.dart';
import 'list_provider.dart';
import 'RegisterPage.dart';

class Chat extends StatefulWidget {
  final String documentid;
  Chat(this.documentid);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  GlobalKey<FormState> _formKey;
  TextEditingController _controller;
  var docname;
  var taskItems;
  int counter = 0;
  DynamicList listClass;

  var GroupName;
  var DocumentID;

  var Description = "";
  DocumentReference doc;
  DocumentSnapshot docsnap;
  Map<String, dynamic> data;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();
    _controller = TextEditingController();
    taskItems = Provider.of<ListProvider>(context, listen: false);
    listClass = DynamicList(taskItems.list);
    DocumentID = widget.documentid;
    asyncInit();
  }

  Future<void> asyncInit() async {
    await Firebase.initializeApp();
    getDocuments();
  }

  getDocuments() async {
    List s = [];
    doc = FirebaseFirestore.instance.collection('profile').doc(DocumentID);
    docsnap = await doc.get();
    data = docsnap.data();
    setState(() {});
    for (var mes in data['messages']) {
      createGroup(mes);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Diyo!',
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontFamily: 'RaleWay')),
        actions: [
          // action button
          IconButton(
            icon: Image.asset(
              'assets/defphoto.png',
              alignment: Alignment.topRight,
              scale: 3,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Title(
                color: Colors.amber,
                child: Text(
                  Description,
                  style: TextStyle(fontSize: 35),
                )),
            Consumer<ListProvider>(builder: (context, provider, listTile) {
              return Expanded(
                child: ListView.builder(
                  itemCount: listClass.list.length,
                  itemBuilder: buildList,
                ),
              );
            }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
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
                    createGroup(_controller.text);
                    doc = FirebaseFirestore.instance
                        .collection('profile')
                        .doc(DocumentID);

                    await doc.update({
                      'messages': FieldValue.arrayUnion([_controller.text]),
                      'order': FieldValue.arrayUnion(
                          [FirebaseAuth.instance.currentUser.uid])
                    });
                  } else {
                    _controller.text = 'Add a Text';
                  }
                },
                child: Text("Send"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildList(BuildContext context, int index) {
    doc = FirebaseFirestore.instance.collection('profile').doc(DocumentID);
    counter++;
    return Dismissible(
      key: Key(counter.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        taskItems.deleteItem(index);
      },
      child: Container(
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          onTap: () {},
          title: Text(listClass.list[index].toString()),
          trailing: Icon(Icons.message),
        ),
      ),
    );
  }

  void setGroupName(String GroupName) {
    this.GroupName = GroupName;
  }

  void setDescription(String Description) {
    this.Description = Description;
  }

  void createGroup(var value) {
    taskItems.addItem(value);
  }
}
