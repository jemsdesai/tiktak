import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tictac/model.dart';

class tictac1 extends StatelessWidget {
  const tictac1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    var _ct = Get.put(ctr());
    String p1="X";
    String p2="O";
    bool won=false;
   
    reset([bool delay=false])async{
      if(delay)
      {
        await Future.delayed(Duration(seconds: 2));
      }
      _ct.grid.value=List.filled(9, "");
      _ct.cnt.value=1;
    }
    win() {

      if (_ct.grid[0] == p1 && _ct.grid[1] == p1 && _ct.grid[2] == p1 ||
          _ct.grid[3] == p1 && _ct.grid[4] == p1 && _ct.grid[5] == p1 ||
          _ct.grid[6] == p1 && _ct.grid[7] == p1 && _ct.grid[8] == p1 ||
          _ct.grid[0] == p1 && _ct.grid[4] == p1 && _ct.grid[8] == p1 ||
          _ct.grid[2] == p1 && _ct.grid[4] == p1 && _ct.grid[6] == p1 ||
          _ct.grid[0] == p1 && _ct.grid[3] == p1 && _ct.grid[6] == p1 ||
          _ct.grid[1] == p1 && _ct.grid[4] == p1 && _ct.grid[7] == p1 ||
          _ct.grid[2] == p1 && _ct.grid[5] == p1 && _ct.grid[8] == p1) {
        _ct.status.value = "PLAYER $p1 IS WON";
        won = true;
        reset(true);
      } else if (_ct.grid[0] == p2 && _ct.grid[1] == p2 && _ct.grid[2] == p2 ||
          _ct.grid[3] == p2 && _ct.grid[4] == p2 &&_ct. grid[5] == p2 ||
          _ct.grid[6] == p2 && _ct.grid[7] == p2 &&_ct. grid[8] == p2 ||
          _ct.grid[0] == p2 && _ct.grid[4] == p2 &&_ct. grid[8] == p2 ||
          _ct.grid[2] == p2 && _ct.grid[4] == p2 &&_ct. grid[6] == p2 ||
          _ct.grid[0] == p2 && _ct.grid[3] == p2 &&_ct. grid[6] == p2 ||
          _ct.grid[1] == p2 && _ct.grid[4] == p2 &&_ct. grid[7] == p2 ||
          _ct.grid[2] == p2 && _ct.grid[5] == p2 &&_ct. grid[8] == p2) {
        _ct.status.value = "PLAYER $p2 IS WON" ;
        won = true;

        reset(true);
      } else {
        _ct.status.value = "MATCH IS RUNNING" ;
      }

    }
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.1,
              width: double.infinity,
              child: Container(
                  alignment: Alignment.center,
                  color: Colors.black,

                  child: Obx(() => Text("${_ct.status}",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold)))),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.8,
              child: GridView.builder(
              itemCount: 9,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                print(index);
                return InkWell(
                  onTap: (){
                    _ct.button_click( index);
                    win();
                  },
                  child: Container(
                      child: Obx(() => Text(
                        "${_ct.grid[index]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 50, color: Colors.white),
                      )),
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.purpleAccent,
                          border: Border.all(width: 4, color: Colors.white))),
                );
              },
            ),),
            SizedBox( height: MediaQuery.of(context).size.height*0.1,child:  ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.black87),
                onPressed: (){

              reset();
                }, child: Text("Reset")),)
          ],
        ),
      ),
    );
  }
}
