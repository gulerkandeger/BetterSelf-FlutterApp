import 'package:better_self/model/myColors.dart';
import 'package:better_self/views/gunluk_hedefler.dart';
import 'package:better_self/views/ilham_noktasi/ilham_noktasi.dart';
import 'package:better_self/views/pariltili_degisim/pariltili_degisim.dart';
import 'package:better_self/views/zinciri_kirma/zinciri_kirma.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Anasayfa extends StatefulWidget {


  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  String? name;
  String? avatar;

  Future<void> adGoster() async{
    var sp = await SharedPreferences.getInstance();
    setState(() {
      name = sp.getString("isim") ?? "kullanıcı adı yok";
    });
  }
  Future<void> avatarGoster() async{
    var sp = await SharedPreferences.getInstance();
    setState(() {
      avatar = sp.getString("avatar");
    });
  }

  @override
  void initState() {
    super.initState();
    adGoster();
    avatarGoster();
  }

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: MyColors.mc_pureWhite,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: MyColors.mc_copperRed,
            title:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 5),
                  child: Text("Merhaba $name " , style: TextStyle(fontFamily: 'NotoSerif', fontSize: 20,color: Colors.white),),
                ),
                Text("Bugün Nasılsın ?", style: TextStyle(fontFamily: 'NotoSerif',fontSize: 13,color: Colors.white54),),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: CircleAvatar(
                  radius: 33,
                  backgroundImage: AssetImage("images/$avatar"),
                ),
              ),
            ],
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(140),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Container(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 2/2.7,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ZinciriKirma()));
                  },
                  child: Card(
                    color: MyColors.mc_frenchGrey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width:80, child: Image.asset("images/zinciri_kirma.png")),
                        Text("Zinciri Kırma",style: TextStyle(fontSize: 15,fontFamily: 'NotoSerif'),),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> GunlukHedefler()));
                  },
                  child: Card(
                    color: MyColors.mc_cornsilk,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width:80, child: Padding(
                          padding: const EdgeInsets.only(left: 5,bottom: 3),
                          child: Image.asset("images/gunluk_hedef.png"),
                        )),
                        Text("Günlük Yapılacaklar",style: TextStyle(fontSize: 15,fontFamily: 'NotoSerif'),),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> PariltiliDegisim()));
                  },
                  child: Card(
                    color: MyColors.mc_glacierBlue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width:80, child: Image.asset("images/parilti_degisim.png")),
                        Text("Parıltılı Değişim",style: TextStyle(fontSize: 15,fontFamily: 'NotoSerif'),),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>IlhamNoktasi()));
                  },
                  child: Card(
                    color: MyColors.mc_gainsboro,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width:80, child: Image.asset("images/ilham_noktasi.png")),
                        Text("Motivasyon Durağı",style: TextStyle(fontSize: 15,fontFamily: 'NotoSerif'),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
