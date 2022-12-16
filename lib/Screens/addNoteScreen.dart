import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notebook/Screens/loginScreen.dart';
import 'package:notebook/const.dart';
import 'package:notebook/widgets/customContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNoteScreen extends StatefulWidget {
  String addUser;
  AddNoteScreen({required this.addUser});
  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

TextEditingController tittleControll = TextEditingController();
TextEditingController notControll = TextEditingController();

class _AddNoteScreenState extends State<AddNoteScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: pryColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: CustomContainer(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                FirebaseFirestore.instance.collection(widget.addUser).add({
                  'tittle': tittleControll.text,
                  'notes': notControll.text,
                });
                Fluttertoast.showToast(
                    msg: "Saved",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Color.fromARGB(255, 250, 247, 247),
                    textColor: Color.fromARGB(255, 11, 11, 11),
                    fontSize: 16.0);
                Navigator.of(context).pop();
                tittleControll.clear();
                notControll.clear();
              },
              child: CustomContainer(
                  icon: Icon(
                Icons.save,
                color: Colors.white,
              )),
            ),
          )
        ],
      ),
      backgroundColor: pryColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            TextFormField(
              controller: tittleControll,
              decoration: InputDecoration(
                  hintText: 'Tittle', hintStyle: TextStyle(color: Colors.grey)),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: notControll,
              decoration: InputDecoration(
                  hintText: 'Note', hintStyle: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}
