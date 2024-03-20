import 'package:better_self/model/myColors.dart';
import 'package:better_self/views/pariltili_degisim/challenge_kendinisev.dart';
import 'package:better_self/views/pariltili_degisim/challenge_kisiselgelisim.dart';
import 'package:better_self/views/pariltili_degisim/challenge_mentalsaglik.dart';
import 'package:better_self/views/pariltili_degisim/challenge_ozguven.dart';
import 'package:better_self/views/pariltili_degisim/challenge_uretkenlik.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PariltiliDegisim extends StatefulWidget {
  const PariltiliDegisim({super.key});

  @override
  State<PariltiliDegisim> createState() => _PariltiliDegisimState();
}

class _PariltiliDegisimState extends State<PariltiliDegisim> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text("Parıltılı Değişim",style: TextStyle(color: Colors.white),)
        ),
        backgroundColor: MyColors.mc_paynesGrey,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Stack(
            children:[
              Image.asset("images/parilti_background.png", fit: BoxFit.cover,),
              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20,top: 20),
                  child: SizedBox(
                    height:110,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> KendiniSevChallenge()));
                      },
                      child: Image.asset("images/parilti_kendinisev.png")
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 80,top: 5),
                  child: SizedBox(
                    height: 110,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>OzguvenChallenge()));
                      },
                      child: Image.asset("images/parilti_ozguven.png")
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30,top: 5),
                  child: SizedBox(
                      height: 110,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MentalSaglikChallenge()));
                        },
                        child: Image.asset("images/parilti_mental.png")
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 80,top: 5),
                  child: SizedBox(
                      height: 115,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>UretkenlikChallenge()));
                        },
                        child: Image.asset("images/parilti_uretkenlik.png")
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30,top: 5),
                  child: SizedBox(
                      height: 110,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>KisiselGelisimChallenge()));
                        },
                        child: Image.asset("images/parilti_kgelisim.png")
                      )
                  ),
                ),
              ],
             ),
            ],
          ),
        ),
      ),
    );
  }
}
