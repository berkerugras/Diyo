import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Chat.dart';
import 'AddChat.dart';
import 'DynamicList.dart';
import 'list_provider.dart';
import 'package:provider/provider.dart';
import 'AddScreen.dart';
import 'user.dart';
import 'list_provider.dart';
import 'RegisterPage.dart';

class PrivateMessages extends StatefulWidget {
  PrivateMessages();

  @override
  _PrivateMessagesState createState() => _PrivateMessagesState();
}

class _PrivateMessagesState extends State<PrivateMessages> {
  GlobalKey<FormState> _formKey;
  TextEditingController _controller;
  var docname;
  var taskItems;
  int counter = 0;
  DynamicList listClass;
  var GroupName;
  var Description;
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
    asyncInit();
  }

  Future<void> asyncInit() async {
    await Firebase.initializeApp();
  }

  refreshpage() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('profile').get();
    snapshot.docs.forEach((document) {
      if (document.get('Id1') == FirebaseAuth.instance.currentUser.uid ||
          document.get('Id2') == FirebaseAuth.instance.currentUser.uid) {
        if (!taskItems.check(document.get('GroupName'))) {
          taskItems.addtomap(document.get('GroupName'), document.id);
          createGroup((document.get('GroupName')));
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  void rebuildit() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    refreshpage();
    // loadingfunction();
    return Scaffold(
      appBar: AppBar(
        title: new Text('Diyo!',
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontFamily: 'RaleWay')),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Image.asset(
                'assets/reload.png',
                alignment: Alignment.center,
                scale: 3,
              )),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Messages',
                style: TextStyle(fontSize: 35),
              ),
            ),
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
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddChat(
                        (var value) {
                          if (value != null) {
                            setState(() {});
                          }
                        },
                      ),
                    ),
                  );
                },
                child: Text("Chat With Your Friend"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildList(BuildContext context, int index) {
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
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider<ListProvider>(
                  create: (context) => ListProvider(),
                  child: Chat(
                      taskItems.getfrommap(listClass.list[index].toString())),
                ),
              ),
            );
          },
          title: Text(listClass.list[index].toString()),
          trailing: Icon(Icons.email),
        ),
      ),
    );
  }

  void setGroupName(String GroupName) {
    this.GroupName = GroupName;
  }

  void createGroup(var value) {
    print(value);
    taskItems.addItem(value);
  }
}
