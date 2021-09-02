import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'GroupPage.dart';
import 'AddComment.dart';
import 'DynamicList.dart';
import 'list_provider.dart';
import 'package:provider/provider.dart';
import 'AddScreen.dart';
import 'user.dart';
import 'list_provider.dart';
import 'RegisterPage.dart';

class GroupPage extends StatefulWidget {
  final String documentid;
  GroupPage(this.documentid);

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
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
  // loadingfunction() async {
  //   doc = FirebaseFirestore.instance.collection('project').doc('myGroup');
  //   docsnap = await doc.get();
  //   data = docsnap.data();
  //   print(data['messages']);
  //   listClass.list.add(data['messages']);
  // }

  // getDocuments() async {
  //   QuerySnapshot snapshot =
  //       await FirebaseFirestore.instance.collection('project').get();
  //   print("12");
  //   int i = 0;
  //   snapshot.docs.forEach((document) {
  //     print(document.id);
  //     print(document.get('GroupName'));
  //     taskItems.addtomap(document.get('GroupName'), document.id);
  //     createGroup((document.get('GroupName')));
  //   });
  // }

  getDocuments() async {
    List s = [];
    doc = FirebaseFirestore.instance.collection('project').doc(DocumentID);
    docsnap = await doc.get();
    data = docsnap.data();
    print(data['Description']);
    setState(() {
      Description = data['Description'].toString();
    });
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
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    Description,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
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
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddComment((var value) {
                        taskItems.addItem(value);
                      }, DocumentID),
                    ),
                  );
                },
                child: Text("Share"),
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
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => GroupPage(),
            //   ),
            // );
          },
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
    print(value);
    taskItems.addItem(value);
  }
}

/*
Padding(
padding: const EdgeInsets.all(8.0),
child: Form(
key: _formKey,
child: TextFormField(controller: _controller,
onSaved: (val){
taskItems.addItem(val);
},
validator: (val){
if (val.length>0){
return null;
}else
return 'Add a Text';
},
),
),
),
*/
