import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:better_self/cubit/zinciri_kirma_cubit.dart';
import 'package:better_self/model/myColors.dart';
import 'package:better_self/status/zinciri_kirma_state.dart';
import 'package:better_self/views/navigation_bar.dart';
import 'package:better_self/views/zinciri_kirma/zinciri_kirma_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ZinciriKirma extends StatefulWidget {
  const ZinciriKirma({super.key});

  @override
  State<ZinciriKirma> createState() => _ZinciriKirmaState();
}

class _ZinciriKirmaState extends State<ZinciriKirma> {

  @override
  void initState() {
    super.initState();
    context.read<ZinciriKirmaCubit>().getHabits();
  }

  bool isCompleted = false;


  @override
  Widget build(BuildContext context) {

    Color tileColor;
    IconData tileIcon;
    int _passedDays = 0;
    DateTime _selectedDate = DateTime.now();
    DateTime _currentDate = DateTime.now();
    int day = _currentDate.day;
    String formattedDate = DateFormat('MMMM y', 'en_US').format(_currentDate);

    return WillPopScope(
        onWillPop: ()async {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CurvedNavigationBar()));
          return true;
        },
      child: Scaffold(
        backgroundColor: MyColors.mc_ametistLight,
        appBar: AppBar(
          backgroundColor: MyColors.mc_wisteria,
          title: Align(
            alignment: Alignment.center,
            child: Text("Zinciri Kırma",style: TextStyle(color: Colors.white),)
          ),
          automaticallyImplyLeading: false,
        ),
        body: Center(
           child: Column(
             children: [

               BlocBuilder<ZinciriKirmaCubit,ZincirState >(
                   builder: (context, state) {
                     if (state is ZincirLoadingState) {
                       return Center(child: CircularProgressIndicator());
                     }
                     else if (state is ZincirErrorState) {
                       return Text('${state.error}');
                     }
                     else if (state is ZincirSuccessState) {
                       return Container();
                     }
                     else if (state is ZincirLoadedState) {
                       return Expanded(
                         child: ListView.builder(
                           itemCount: state.habitList.length,
                           itemBuilder: (context,index){
                             final veriler = state.habitList[index];
                             final startDate = veriler['startDate'];
                             final habitTime = veriler['habitTime'];
                             final id = veriler['id'];
                              return Padding(
                                padding: const EdgeInsets.all( 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.black26,
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(veriler['name'],style: TextStyle(fontSize: 16),),
                                            ),
                                          ),
                                          Spacer(),
                                          IconButton(
                                            icon: Icon(Icons.delete,color: Colors.black12,),
                                            onPressed: (){
                                              AwesomeDialog(
                                                  context: context,
                                                  dialogType: DialogType.warning,
                                                  animType: AnimType.bottomSlide,
                                                  title: 'Alışkanlık Sil',
                                                  desc: "Bu alışkanlık silinsin mi?",
                                                  descTextStyle: TextStyle(color: Colors.black54,fontSize: 18),
                                                  btnOkOnPress: (){
                                                    setState(() {
                                                      context.read<ZinciriKirmaCubit>().deleteHabits(id);
                                                    });
                                                  },
                                                  btnOkText: 'Evet',
                                                  btnOkColor: Colors.deepPurple.shade300,
                                                  btnCancelText: 'Hayır',
                                                  btnCancelColor: Colors.black38,
                                                  btnCancelOnPress: (){}
                                              ).show();
                                            },
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(veriler['desc']),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10,left: 10,top: 15),
                                        child: Container(
                                          height: 100,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount : habitTime,
                                            itemBuilder: (context, index){
                                              DateTime nextDay = startDate.add(Duration(days: index));
                                              String formattedDateDay = DateFormat('d', 'en_US').format(nextDay);
                                              String formattedDateMonth = DateFormat('MMMM ', 'en_US').format(nextDay);
                                              int difference = _currentDate.difference(startDate).inDays;
                                              _passedDays = difference;
                                              if(isCompleted == true){
                                                print(isCompleted);
                                                tileColor = (index <= _passedDays) ? Colors.deepPurple.shade200 : Colors.deepPurple.shade100;
                                                if(index <= _passedDays){
                                                  tileIcon = Icons.check ;
                                                }
                                                else{
                                                  tileIcon = Icons.question_mark;
                                                }
                                              }
                                              else{
                                                print(isCompleted);
                                                tileColor = (index <= _passedDays) ? Colors.deepPurple.shade200 : Colors.deepPurple.shade100;
                                                tileIcon = Icons.question_mark;
                                              }
                                              return SizedBox(
                                                width: 100,
                                                child: GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      if(index <= _passedDays){
                                                        isCompleted = !isCompleted;
                                                      }
                                                    });
                                                  },
                                                  child: TimelineTile(
                                                    axis: TimelineAxis.horizontal,
                                                    isFirst: index == 0,
                                                    isLast: index == habitTime - 1,
                                                    beforeLineStyle: LineStyle(color: tileColor ,thickness:4),
                                                    indicatorStyle: IndicatorStyle(
                                                        height: 25,
                                                        color: tileColor  ,
                                                        iconStyle: IconStyle(iconData: tileIcon ,color: Colors.white)
                                                    ),
                                                    endChild: Container(
                                                      child: Column(
                                                        children: [
                                                          Text(formattedDateDay),
                                                          Text(formattedDateMonth)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 10, bottom: 10),
                                          child: SizedBox(
                                            width: 130,
                                            height: 35,
                                            child: ElevatedButton(
                                              child: Text("Tamamlandı"),
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(13.0),
                                                  side: BorderSide(color: MyColors.mc_lavanderGrey, width: 1.0),
                                                ),
                                              ),
                                              onPressed: (){
                                                setState(() {

                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                           },
                         ),
                       );
                     }
                     else{
                       return Text("Çalışmıyor");
                     }
                   },
                 ),
             ],
           ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: MyColors.mc_wisteria,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ZinciriKirmaAdd()));
          },
          child: Icon(Icons.add,color: Colors.white,),
          shape: CircleBorder(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
