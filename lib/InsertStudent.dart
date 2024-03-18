import 'package:flutter/material.dart';
import 'package:sqllite/database.dart';

class InsertStudent extends StatefulWidget {
  InsertStudent({super.key, this.map});

  Map? map;

  @override
  State<InsertStudent> createState() => _InsertStudentState();
}

class _InsertStudentState extends State<InsertStudent> {
  TextEditingController namecontroller = TextEditingController();
  MyDatabase db = MyDatabase();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namecontroller.text =
    widget.map?['name'] == null ? "" : widget.map!['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input Data"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: namecontroller,
          ),
          ElevatedButton(
              onPressed: () {
                if (widget.map == null) {
                  db.insertStudent(name: namecontroller.text).then((value) {
                    Navigator.pop(context);
                  });
                } else {
                  db.updateStudent(name: namecontroller.text,
                      id: widget.map!["StudentID"]).then((value) {
                    Navigator.pop(context);
                  });
                }
              },
              child: Text("Submit"))
        ],
      ),
    );
  }
}
