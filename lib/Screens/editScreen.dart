import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notebook/Screens/homeScreen.dart';
import 'package:notebook/const.dart';
import 'package:notebook/widgets/customContainer.dart';

class EditScreen extends StatefulWidget {
  String colloctionName;
  String tittle;
  String notes;
  String noteid;
  EditScreen(
      {required this.notes,
      required this.tittle,
      required this.colloctionName,
      required this.noteid});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

TextEditingController tittleControll = TextEditingController();
TextEditingController noteControll = TextEditingController();

class _EditScreenState extends State<EditScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tittleControll.text = widget.tittle;
    noteControll.text = widget.notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: CustomContainer(
                icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ))),
        backgroundColor: pryColor,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                FirebaseFirestore.instance
                    .collection(widget.colloctionName)
                    .doc(widget.noteid)
                    .update({
                  'tittle': tittleControll.text,
                  'notes': noteControll.text,
                });
                Fluttertoast.showToast(
                    msg: "Updated",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Color.fromARGB(255, 241, 238, 237),
                    textColor: Color.fromARGB(255, 6, 6, 6),
                    fontSize: 16.0);
                Navigator.of(context).pop();
                tittleControll.clear();
                noteControll.clear();
                Navigator.of(context).pop(HomeScreen());
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
                  hintText: tittleControll.text,
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: noteControll,
              decoration: InputDecoration(
                  hintText: noteControll.text,
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}
