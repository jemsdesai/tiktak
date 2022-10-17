import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tictac/tictac1.dart';

void main() {
  runApp(const GetMaterialApp(
    home: tictac1(),
  ));
}

class tictac extends StatefulWidget {
  const tictac({Key? key}) : super(key: key);

  @override
  State<tictac> createState() => _tictacState();
}

class _tictacState extends State<tictac> {
  initState() {
    super.initState();
  }

  List<String> grid = List.filled(9, "");
  List<String> undo_sign = [];

  List<int> undo_pos = [];
  List<String> redo_sign = [];
  List<int> redo_pos = [];
  List<int>temp=[];
  int t=0;


  String p1 = "X";
  String p2 = "0";
  String status = "";
  int cnt = 0;
  bool won = false;

  void plyaGame(int x) {
    setState(() {


        if(grid[x]=="")
        {
          grid[x]=p1;
          temp.add(x);
          t++;
          grid[x] = p1;
          cnt++;
          undo_pos.add(x);
          undo_sign.add(p1);

        }
        if(t<=4)
        {
          while(true)
          {
            int random=Random().nextInt(9);
            if(!temp.contains(random))
            {
              grid[random] = p2;
              cnt++;
              undo_pos.add(random);
              undo_sign.add(p2);

              grid[random]=p2;
              temp.add(random);
              break;
            }
          }
        }
        win();

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        //LAYOUT------------------------------------------------------------------------------------------------------------------
        appBar: AppBar(
          title: const Text("Tic Tac Toi",
              style: TextStyle(color: Colors.white, fontSize: 35)),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            Container(
              child: Text(
                "$status",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 35),
              ),
              height: 50,
              width: double.infinity,
              color: Colors.purpleAccent,
            ),
            Expanded(
                child: Row(
              children: [
                allButttons(0),
                allButttons(1),
                allButttons(2),
              ],
            )),
            Expanded(
                child: Row(
              children: [
                allButttons(3),
                allButttons(4),
                allButttons(5),
              ],
            )),
            Expanded(
                child: Row(
              children: [
                allButttons(6),
                allButttons(7),
                allButttons(8),
              ],
            )),
            Row(children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (undo_pos.length > 0) {
                      int last_pos = undo_pos.last;
                      String last_sign = undo_sign.last;
                      grid[last_pos] = "";
                      cnt--;
                      undo_sign.removeLast();
                      undo_pos.removeLast();

                      redo_pos.add(last_pos);
                      redo_sign.add(last_sign);

                      setState(() {});
                    }
                  },
                  child: Text("UNDO",
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                ),
              ),
              Expanded(
                  child: ElevatedButton(
                onPressed: () {
                  reset();
                  },
                child: Text(
                  "RESET",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              )),
              Expanded(
                  child: ElevatedButton(
                onPressed: () {
                  if (redo_pos.length > 0) {
                    int last_pos = redo_pos.last;
                    String last_sign = redo_sign.last;

                    grid[last_pos] = last_sign;
                    cnt++;

                    redo_sign.removeLast();
                    redo_pos.removeLast();

                    undo_pos.add(last_pos);
                    undo_sign.add(last_sign);

                    setState(() {});
                  }
                },
                child: Text(
                  "REDO",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ))
            ])
          ],
        ));
  }

  allButttons(int i) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if ((grid[i] == "" || won == true) && cnt != 9) {
            if (won == true) {
              grid = List.filled(9, "");
              undo_sign.clear();
              undo_pos.clear();
              redo_pos.clear();
              redo_sign.clear();
              cnt = 0;
              setState(() {});
              won = false;
            }}
           // if (cnt % 2 == 0) {
          //     grid[i] = p1;
          //     cnt++;
          //     undo_pos.add(i);
          //     undo_sign.add(p1);
          //     auto();
          //   }
          //   print(cnt);
          //
          //   win();
          // }
          plyaGame(i);
        },
        child: Container(
          color: (grid[i] == "")
              ? Colors.deepPurple
              : (grid[i] == p1 ? Colors.cyanAccent : Colors.blue),
          margin: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Text(grid[i], style: TextStyle(fontSize: 50)),
        ),
      ),
    );
  }

  win() {
    if (grid[0] == p1 && grid[1] == p1 && grid[2] == p1 ||
        grid[3] == p1 && grid[4] == p1 && grid[5] == p1 ||
        grid[6] == p1 && grid[7] == p1 && grid[8] == p1 ||
        grid[0] == p1 && grid[4] == p1 && grid[8] == p1 ||
        grid[2] == p1 && grid[4] == p1 && grid[6] == p1 ||
        grid[0] == p1 && grid[3] == p1 && grid[6] == p1 ||
        grid[1] == p1 && grid[4] == p1 && grid[7] == p1 ||
        grid[2] == p1 && grid[5] == p1 && grid[8] == p1) {
      status = "PLAYER $p1 IS WON";
      won = true;
      reset(true);
    } else if (grid[0] == p2 && grid[1] == p2 && grid[2] == p2 ||
        grid[3] == p2 && grid[4] == p2 && grid[5] == p2 ||
        grid[6] == p2 && grid[7] == p2 && grid[8] == p2 ||
        grid[0] == p2 && grid[4] == p2 && grid[8] == p2 ||
        grid[2] == p2 && grid[4] == p2 && grid[6] == p2 ||
        grid[0] == p2 && grid[3] == p2 && grid[6] == p2 ||
        grid[1] == p2 && grid[4] == p2 && grid[7] == p2 ||
        grid[2] == p2 && grid[5] == p2 && grid[8] == p2) {
      status = "PLAYER $p2 IS WON";
      won = true;

      reset(true);
    } else {
      status = "MATCH IS RUNNING";
    }
    setState(() {});
  }

  Blank() {
    bool isFind =false;

    int max = 0;
    int min = 9;
    int blankIndex;
    int random = Random().nextInt(max - min) + min;

    for (;isFind==false;) {
      if (grid[random] == "") {
        isFind=true;
       return  blankIndex=random;
      }
      else
        {
          random=Random().nextInt(max - min) + min;
        }
    }
  }
  reset([bool delay=false]) async{

    if(delay)
      {
        await Future.delayed(Duration(seconds: 2));
      }
    grid = List.filled(9, "");
    undo_sign.clear();
    undo_pos.clear();
    redo_pos.clear();
    redo_sign.clear();
    cnt = 0;
    t=0;
    setState(() {});
  }
}
