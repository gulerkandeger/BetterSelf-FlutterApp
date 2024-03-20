import 'package:better_self/model/myColors.dart';
import 'package:better_self/views/intro_screens/avatar_select.dart';
import 'package:better_self/views/navigation_bar.dart';
import 'package:better_self/views/profil/Profil.dart';
import 'package:better_self/views/profil/avatar_duzenle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfiliDuzenle extends StatefulWidget {
  const ProfiliDuzenle({super.key});

  @override
  State<ProfiliDuzenle> createState() => _ProfiliDuzenleState();
}

class _ProfiliDuzenleState extends State<ProfiliDuzenle> {

  late IconData iconData;
  var tfKullaniciAdi = TextEditingController();
  String? name;
  String? avatar;
  int? cinsiyet;

  Future<void> avatarGoster() async{
    var sp = await SharedPreferences.getInstance();
    setState(() {
      avatar = sp.getString("avatar")!;
    });
  }
  Future<void> avatarKayit() async{
    var sp = await SharedPreferences.getInstance();
    sp.setString("avatar", avatar!);
  }
  Future<void> adGoster() async{
    var sp = await SharedPreferences.getInstance();
    setState(() {
      name = sp.getString("isim") ?? "kullanıcı adı yok";
      tfKullaniciAdi.text =name!;
    });
  }
  Future<void> adKayit() async{
    var sp = await SharedPreferences.getInstance();
    sp.setString("isim", name!);
  }
  Future<void> cinsiyetKayit() async{
    var sp = await SharedPreferences.getInstance();
    setState(() {
      sp.setInt("cinsiyet", cinsiyet!) ;
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

    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MyColors.mc_pureWhite,
      appBar: AppBar(
        backgroundColor: MyColors.mc_copperRed,
        title: Text("Profili Düzenle"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AvatarDuzenle()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30,top: 60),
                  child: CircleAvatar(
                    backgroundImage: AssetImage("images/$avatar"),
                    radius: 50.0,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            radius: 15.0,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.add,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 250,
                height: 50,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.black26,
                      fontSize: 16,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: MyColors.mc_peru , width: 5)
                    ),
                  ),
                  controller: tfKullaniciAdi,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 60,top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width/3,
                      child: RadioListTile(
                        title: Icon(Icons.female),
                        value: 0,
                        groupValue: cinsiyet,
                        onChanged: (cinsiyet_value){
                          setState(() {
                            cinsiyet = cinsiyet_value;
                            cinsiyetKayit();
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: width/3,
                      child: RadioListTile(
                        title: Icon(Icons.male),
                        value: 1,
                        groupValue: cinsiyet,
                        onChanged: (cinsiyet_value){
                          setState(() {
                            cinsiyet = cinsiyet_value;
                            cinsiyetKayit();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                child: Text("Profili Güncelle"),
                onPressed: (){
                  setState(() {
                    name = tfKullaniciAdi.text;
                    adKayit();
                    avatarKayit();
                    cinsiyetKayit();
                  });
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>CurvedNavigationBar()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:Colors.deepOrange.shade400,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 4.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
