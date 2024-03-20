import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:better_self/cubit/pariltili_degisim_cubit.dart';
import 'package:better_self/model/myColors.dart';
import 'package:better_self/status/parilti_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MentalSaglikChallenge extends StatefulWidget {
  const MentalSaglikChallenge({super.key});

  @override
  State<MentalSaglikChallenge> createState() => _MentalSaglikChallengeState();
}

class _MentalSaglikChallengeState extends State<MentalSaglikChallenge> {

  int _passedDays = 0;

  _loadPassedDays() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? firstEntryDate = prefs.getString('firstEntryDate');

    if (firstEntryDate != null) {
      DateTime entryDate = DateTime.parse(firstEntryDate);
      DateTime now = DateTime.now();
      int difference = now.difference(entryDate).inDays;
      setState(() {
        _passedDays = difference;
      });
    }
    else {
      DateTime now = DateTime.now();
      prefs.setString('firstEntryDate', now.toIso8601String());
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPassedDays();
    context.read<PariltiliDegisimCubit>().getMentalChallenges();
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MyColors.mc_silverChalice,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
              height: 130,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text("30",style: TextStyle(fontSize: 100,fontFamily: 'font4',color: Colors.black54),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: RotatedBox(
                        quarterTurns: 1,
                        child: Text("gün",style: TextStyle(fontSize: 20,fontFamily: 'font4',fontWeight: FontWeight.bold,color: Colors.black54),)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,top: 55),
                    child: Column(
                      children: [
                        Text("Mental Sağlık",style: TextStyle(fontSize: 17,fontFamily: 'font4',fontWeight: FontWeight.bold,color: Colors.black54),),
                        Text("Challenge",style: TextStyle(fontSize: 20,fontFamily: 'font4',fontWeight: FontWeight.bold,color: Colors.black54),),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 30,right: 10),
                    child: SizedBox(width:60, child: Image.asset("images/challenge_mental.png")),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<PariltiliDegisimCubit, PariltiState>(
            builder: (context,state){
              if (state is PariltiLoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              else if (state is PariltiErrorState) {
                return Text('${state.error}');
              }
              else if (state is PariltiSuccessState) {
                return Container();
              }
              else if (state is PariltiLoadedState){
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.challengeList.length,
                    itemBuilder: (context,index){
                      final veriler = state.challengeList[index];
                      final id = veriler['id'];
                      if(index <= _passedDays ) {
                        return SizedBox(
                          height: 80,
                          child: Card(
                            color:veriler['check']
                                ? Colors.green.shade100
                                : MyColors.mc_frenchGrey,
                            child: Center(
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: veriler['check'],
                                    checkColor: Colors.white,
                                    activeColor: Colors.green.shade400,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        context.read<PariltiliDegisimCubit>().updateKendiniSevCheck(id, value!);
                                      });
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: 300,
                                          child: Text("${veriler['challenge']}",
                                            style: TextStyle(fontSize: 17,
                                                color: Colors.black54,
                                                fontFamily: 'font1'),
                                          ),
                                        )
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon(Icons.lock_open_rounded,
                                      color: Colors.black54,),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      else{
                        return SizedBox(
                            height: 80,
                            child: GestureDetector(
                              onTap: (){
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.bottomSlide,
                                  title: 'İzin Yok',
                                  desc: "Bu challenge'ı henüz göremezsiniz.",
                                  descTextStyle: TextStyle(color: Colors.black54,fontSize: 18),
                                  btnOkOnPress: (){},
                                  btnOkText: 'Tamam',
                                  btnOkColor: MyColors.mc_paynesGrey,
                                ).show();
                              },
                              child: Card(
                                color: MyColors.mc_frenchGrey,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("${index+1} . Gün",style: TextStyle(fontSize: 17,color: Colors.black54,fontFamily: 'font1'),)
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(Icons.lock_outline,
                                        color: Colors.black,),
                                    )
                                  ],
                                ),
                              ),
                            )
                        );
                      }
                    },
                  ),
                );
              }
              else{
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
