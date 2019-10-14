import 'package:exampleflr/NotePad/FormInsert.dart';
import 'package:exampleflr/NotePad/NotePadData.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyAPP());

class MyAPP extends StatefulWidget {
  MyAPP({Key key}) : super(key: key);

  _MyAPPState createState() => _MyAPPState();
}

class _MyAPPState extends State<MyAPP> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FormInsert(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences sharedPreferences;
  int countList = 1;
  List items = <NotePadData>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    load();
  }

  void load() async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        countList = sharedPreferences.getInt("countList") ?? 0;
      });
      if (countList != 0) {
        for (var i = 0; i < countList; i++) {
          var item = NotePadData(
            title: sharedPreferences.getString("title$i") ?? null,
            subTitle: sharedPreferences.getString("subTitle$i") ?? null,
            dateTime: DateTime.parse(
                sharedPreferences.getString("dateTime$i") ?? null),
            text: sharedPreferences.getString("text$i") ?? null,
          );
          items.add(item);
        }
      }
    } catch (e) {
      print(e);
      setState(() {
        countList = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text("NotePad"),
        ),
        body: Stack(
          children: <Widget>[
            if (countList != 0)
              ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        title: Text("Title"),
                        leading: Icon(Icons.event_note),
                        subtitle: Text("Subtitle"),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    ),
                  );
                },
              )
            else
              Container(
                child: Center(
                  child: Text("Add some data"),
                ),
              ),
          ],
        ));
  }
}

class AnimiWithflr extends StatefulWidget {
  AnimiWithflr({Key key}) : super(key: key);

  _AnimiWithflrState createState() => _AnimiWithflrState();
}

class _AnimiWithflrState extends State<AnimiWithflr> {
  bool statedOfDay = false;
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Expanded(
          child: InkWell(
            onTap: () {
              setState(() {
                statedOfDay = !statedOfDay;
              });
            },
            child: FlareActor(
              "assets/switch_daytime.flr",
              animation: statedOfDay ? 'switch_night' : 'switch_day',
              fit: BoxFit.contain,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  statedOfDay = !statedOfDay;
                });
              },
              child:
                  Text("press the button for ${statedOfDay ? 'night' : 'day'}"),
            ),
          ),
        )
      ],
    );
  }
}
