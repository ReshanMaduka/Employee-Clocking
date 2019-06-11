import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './profile.dart';

import '../scoped_models/main.dart';
import './upcoming.dart';
import './notification.dart';

class SchedulesPage extends StatelessWidget {

  PageController controller = PageController();
  var currentPageValue = 0.0;



  final MainModel model;
  SchedulesPage(this.model);

  @override
  Widget build(BuildContext context) {
    String line1 = "Hey Pathum";
    String line2 = "this is your Roster.";
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: const Color(0xFF242133),
          appBar: AppBar(
            title: Text(line1+"\n"+line2,style: TextStyle(fontSize: 24.0),),
            elevation: 0.0,
            backgroundColor: const Color(0xFF242133),
          ),
          body: PageView.builder(
            controller: controller,
            itemBuilder: (context, position) {
              if (position == currentPageValue.floor()) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..setEntry(3, 2, 0.004)
                    ..rotateX(currentPageValue - position)
                    ..rotateY(currentPageValue - position)
                    ..rotateZ(currentPageValue - position),
                  child: Container(
                    color: position % 2 == 0 ? Colors.blue : Colors.pink,
                    child: Center(
                      child: Text(
                        "Page",
                        style: TextStyle(color: Colors.white, fontSize: 22.0),
                      ),
                    ),
                  ),
                );
              } else if (position == currentPageValue.floor() + 1){
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..setEntry(3, 2, 0.004)

                    ..rotateX(currentPageValue - position)
                    ..rotateY(currentPageValue - position)
                    ..rotateZ(currentPageValue - position),
                  child: Container(
                    color: position % 2 == 0 ? Colors.blue : Colors.pink,
                    child: Center(
                      child: Text(
                        "Page",
                        style: TextStyle(color: Colors.white, fontSize: 22.0),
                      ),
                    ),
                  ),
                );
              } else {
                return Container(
                  color: position % 2 == 0 ? Colors.blue : Colors.pink,
                  child: Center(
                    child: Text(
                      "Page",
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    ),
                  ),
                );
              }
            },
            itemCount: 10,
          ),
          ),
        );
  }
}
