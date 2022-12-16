import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notebook/Screens/editScreen.dart';
import 'package:notebook/const.dart';
import 'package:notebook/widgets/customContainer.dart';

class ReadScreen extends StatefulWidget {
  String colloction;
  String tittle;
  String notes;
  String id;
  ReadScreen(
      {required this.tittle, required this.notes, required this.colloction,required this.id});

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pryColor,
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
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return EditScreen(
                    noteid: widget.id,
                    notes: widget.notes,
                    tittle: widget.tittle,
                    colloctionName: widget.colloction,
                  );
                }));
              },
              child: CustomContainer(
                  icon: Icon(
                Icons.edit,
                color: Colors.white,
              )),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${widget.tittle}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '${widget.notes}',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
