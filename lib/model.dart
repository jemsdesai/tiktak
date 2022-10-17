import 'package:get/get.dart';

class ctr extends GetxController{
  RxInt cnt = 1.obs;
RxList<String> grid=List.filled(9, "").obs;
String p1="X",p2="O";
  RxString status="Game Is Runing...".obs;
button_click(int pos){
if(grid[pos]=="")
  {
    if(cnt%2==0)
    {
      grid[pos]=p1;
    }
    else
    {
      grid[pos]=p2;
    }
    cnt++;
  }
}

}