import 'package:exampleflr/NotePad/NotePadData.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormInsert extends StatefulWidget {
  FormInsert({Key key, this.count}) : super(key: key);
  final int count;

  _FormInsertState createState() => _FormInsertState();
}

class _FormInsertState extends State<FormInsert> {
  int count;
  NotePadData data =
      NotePadData(dateTime: null, subTitle: null, text: null, title: null);
  bool error = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count=widget.count;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insert Data"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            child: Text(
              "Insert The Values",
              style: TextStyle(color: Colors.cyan, fontSize: 30),
            ),
            alignment: Alignment.center,
          ),
          Form(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      initialValue: data.title,
                      onChanged: (value) {
                        setState(() {
                          data.title = value;
                        });
                      },
                      style: TextStyle(color: Colors.redAccent),
                      keyboardType: TextInputType.text,
                      maxLength: 10,
                      decoration: InputDecoration(
                        labelText: "Title",
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber[500], width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      initialValue: data.subTitle,
                      onChanged: (value) {
                        setState(() {
                          data.subTitle = value;
                        });
                      },
                      style: TextStyle(color: Colors.redAccent),
                      keyboardType: TextInputType.text,
                      maxLength: 15,
                      decoration: InputDecoration(
                        labelText: "Sub Title",
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber[500], width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    maxLines: 3,
                    onChanged: (value) {
                      setState(() {
                        data.text = value;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: "Text",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text("Submit"),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void insert() async {
    try {
      var sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("title$count", "${data.title}");
      sharedPreferences.setString("subTitle$count", "${data.subTitle}");
      sharedPreferences.setString("text$count", "${data.text}");
      sharedPreferences.setString(
          "dateTime$count", "${DateTime.now().toString()}");
    } catch (e) {
      print(e);
      setState(() {
        error = true;
      });
    }
  }
}
