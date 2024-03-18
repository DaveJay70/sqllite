import 'package:flutter/material.dart';
import 'package:sqllite/InsertStudent.dart';
import 'package:sqllite/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MyDatabase db = MyDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: db.copyPasteAssetFileToRoot(),
        builder: (context, snapshot2) {
          if (snapshot2.hasData) {
            return FutureBuilder(
              future: db.getDataFromStudent(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return InsertStudent(
                              map: snapshot.data![index],
                            );
                          })).then((value) {
                            setState(() {});
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                snapshot.data![index]['name'].toString(),
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                db
                                    .deleteStudent(int.parse(
                                        "${snapshot.data![index]['StudentID']}"))
                                    .then((value) {
                                  setState(() {});
                                });
                              },
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                            )
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Text("NO Data Found");
                }
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return InsertStudent();
          })).then((value) {
            setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
