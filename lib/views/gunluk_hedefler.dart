import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:better_self/cubit/gunluk_hedefler_cubit.dart';
import 'package:better_self/model/myColors.dart';
import 'package:better_self/status/gunluk_hedef_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';



class GunlukHedefler extends StatefulWidget {
   GunlukHedefler({super.key});

  @override
  State<GunlukHedefler> createState() => _GunlukHedeflerState();

}

class _GunlukHedeflerState extends State<GunlukHedefler> {

  DateTime _selectedDate = DateTime.now();
  DateTime _currentDate = DateTime.now();
  bool isCheck= false;

  TextEditingController gorevController = TextEditingController();

  Color hexToColor(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  void gorevEkle(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
            child: yeniGorevEkle(gorevController: gorevController)
        )
    );
  }



  @override
  void initState() {
    super.initState();
    context.read<GunlukHedeflerCubit>().getGunlukHedefler();
  }

  @override
  Widget build(BuildContext context) {

    String formattedDate = DateFormat('MMMM y', 'en_US').format(_currentDate);


    return Scaffold(
      backgroundColor: MyColors.mc_thistle,
      appBar: AppBar(
        backgroundColor: MyColors.mc_thistle,
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment.center,
            child: Text("Günlük Hedefler")
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(formattedDate,style: TextStyle(fontSize: 17,color: Colors.black54),)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                child: DatePicker(
                  DateTime.now(),
                  height: 90,
                  width: 80,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: MyColors.mc_ametist,
                  selectedTextColor: MyColors.mc_wisteria,
                  onDateChange: (date){
                    _selectedDate = date;
                    context.read<GunlukHedeflerCubit>().getGunlukHedefler();
                  },
                ),
              ),
            ),
            BlocBuilder<GunlukHedeflerCubit, GunlukHedefState>(
                builder: (context, state){
                  if (state is GunlukHedefLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  }
                  else if (state is GunlukHedefErrorState) {
                    return Text('${state.error}');
                  }
                  else if (state is GunlukHedefSuccessState) {
                    return Container();
                  }
                  else if(state is GunlukHedefLoadedState ) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.gorevList.length,
                        itemBuilder: (context,index){
                          print("loaded state çalışıyor.");
                          final veriler = state.gorevList[index];
                          final id = veriler['id'];
                          isCheck = veriler['check'];
                          final flag = veriler['oncelik'];
                          DateTime tarih = veriler['tarih'];
                          String myHexColor = "$flag";
                          Color flagColor = hexToColor(myHexColor);
                          if(_selectedDate.year == tarih.year) {
                            if (_selectedDate.month == tarih.month) {
                              print("selected : ${_selectedDate.day}");
                              print("tarih: ${tarih.day}");
                              if (_selectedDate.day == tarih.day) {
                                return SizedBox(
                                  height: 80,
                                  child: Slidable(
                                    endActionPane: ActionPane(
                                      motion: StretchMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: ((context){
                                            context.read<GunlukHedeflerCubit>().deleteGunlukHedefler(id);
                                          }),
                                          backgroundColor: Colors.red,
                                          icon: Icons.delete_rounded,
                                        )
                                      ],
                                    ),
                                    child: Card(
                                      color: MyColors.mc_thistle,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: veriler['check'],
                                            onChanged: (bool? value){
                                              setState(() {
                                                isCheck = value!;
                                                context.read<GunlukHedeflerCubit>().updateGunlukHedefler(id,veriler['gorev'] , isCheck);
                                              });
                                            },
                                          ),
                                          Text(veriler['gorev'], style: TextStyle(decoration: isCheck ? TextDecoration.lineThrough : null,fontSize: 18),),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 7),
                                            child: Icon((Icons.flag),color:flagColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }
                          }
                        },
                      ),
                    );
                  }
                  else{
                    return Container();
                  }
                }
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.mc_wisteria,
        onPressed: () => gorevEkle(context),
        child: Icon(Icons.add,color: Colors.white,),
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class yeniGorevEkle extends StatelessWidget {
  yeniGorevEkle({
    super.key,
    required this.gorevController,
  });


  DateTime currentDate = DateTime.now();


  final TextEditingController gorevController;
  List<Color> oncelik = [Colors.red,Colors.orange,Colors.yellowAccent,Colors.black26];
  List<String> selectedOncelik = ['#FF0000','#FFA500','#FFFF00','#737373'];
  int selectedFlag = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.cancel_outlined,color: Colors.black12,),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
            TextField(
              autofocus: false,
              controller: gorevController,
              decoration: InputDecoration(
                label: Text("Yeni Görev"),
                border: OutlineInputBorder(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15,bottom:5),
              child: Align(
                alignment: Alignment.centerLeft,
                  child: Text("Görevin öncelik seviyesi nedir?",style: TextStyle(color: Colors.black26,fontSize: 16))
              ),
            ),
            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: oncelik.length,
                itemBuilder: (context, index){
                  return SizedBox(
                    width: 60,
                    child: GestureDetector(
                      onTap: (){
                        selectedFlag = index;
                      },
                      child: Card(
                        child: Icon(Icons.flag,color: oncelik[index],),
                      ),
                    ),
                  );
                },
              ),
            ),
            TextButton(
              child: Text("Ekle",style: TextStyle(fontSize: 17,color: MyColors.mc_wisteria),),
              onPressed: (){
                if(gorevController.text.isNotEmpty){
                  context.read<GunlukHedeflerCubit>().addGunlukHedefler(gorevController.text, false, selectedOncelik[selectedFlag],currentDate);
                  Navigator.pop(context);
                  gorevController.clear();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
