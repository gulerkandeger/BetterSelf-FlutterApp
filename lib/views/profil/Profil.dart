import 'package:better_self/model/myColors.dart';
import 'package:better_self/views/profil/fav_ilhamlar.dart';
import 'package:better_self/views/profil/gunluk.dart';
import 'package:better_self/views/profil/profili_duzenle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {

  String? name;
  String? avatar;
  int? cinsiyet;
  IconData? iconData;

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

  Future<void> cinsiyetGoster() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
       cinsiyet = prefs.getInt('cinsiyet') ;
       if (cinsiyet == 0) {
         iconData = Icons.female;
       } else {
         iconData = Icons.male;
       }
    });
  }

  @override
  void initState() {
    super.initState();
    adGoster();
    avatarGoster();
    cinsiyetGoster();
  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: MyColors.mc_pureWhite,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.mc_copperRed,
          title: Align(alignment: Alignment.center,child: Text("Profil",style: TextStyle(color: MyColors.mc_cornsilk,fontWeight: FontWeight.bold,),)),
          actions: [
            IconButton(
              icon: Icon(Icons.settings,color: Colors.black26,),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfiliDuzenle()));
              },
            )

          ],
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30,bottom: 20),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("images/$avatar"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 80,top: 20),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(iconData),
                      ),
                      Text("$name",style: TextStyle(fontSize: 22,fontFamily: 'NotoSerif'),),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Gunluk()));
                },
                child: SizedBox(
                  height: 50,
                  width: 250,
                  child: Card(
                    color: MyColors.mc_cornsilk,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width:40, child: Image.asset("images/gunluk.png")),
                        SizedBox(width: 15,),
                        Text("Günlük",style: TextStyle(fontSize: 20,fontFamily: 'NotoSerif'),),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(width:40, child: Image.asset("images/fav_ilhamlar.png")),
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoriIlhamlar()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
