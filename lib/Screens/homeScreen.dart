import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notebook/Screens/addNoteScreen.dart';
import 'package:notebook/Screens/loginScreen.dart';
import 'package:notebook/Screens/readScreen.dart';
import 'package:notebook/const.dart';
import 'package:notebook/widgets/customContainer.dart';
import 'package:notebook/widgets/textWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String? emailData;

getDataPref() async {
  final prif = await SharedPreferences.getInstance();
  emailData = prif.getString('username') ?? 'nomail';
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return AddNoteScreen(
                addUser: emailData!,
              );
            }));
          },
          child: Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: pryColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: pryColor,
          elevation: 0,
          centerTitle: false,
          title: CustomTxt(color: Colors.white),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Log out'),
                        content: const Text('Are you sure'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: CustomContainer(
                      icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ))),
            )
          ],
        ),
        body: FutureBuilder(
          future: getDataPref(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(emailData!)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                          children: snapshot.data!.docs.map((dataas) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () => Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return ReadScreen(
                                id: '${dataas.id}',
                                notes: '${dataas['notes']}',
                                tittle: '${dataas['tittle']}',
                                colloction: emailData!,
                              );
                            })),
                            child: GestureDetector(
                              onDoubleTap: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Delete Note'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection(emailData!)
                                              .doc(dataas.id)
                                              .delete();
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                child: ListTile(
                                  title: Text(
                                    '${dataas['tittle']}',
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList());
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  });
            }
          },
        ));
  }
}
