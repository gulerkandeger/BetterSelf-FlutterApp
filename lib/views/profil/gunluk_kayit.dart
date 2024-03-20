import 'package:better_self/model/myColors.dart';
import 'package:better_self/services/gunluk_services.dart';
import 'package:better_self/views/profil/gunluk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GunlukKayit extends StatefulWidget {
  const GunlukKayit({super.key});

  @override
  State<GunlukKayit> createState() => _GunlukKayitState();
}

class _GunlukKayitState extends State<GunlukKayit> {

  TextEditingController tfTarih = TextEditingController();
  TextEditingController tfGunluk = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;


    final _firestoreService = GunlukService();

    void gunlukKaydet() async {
      String tarih = tfTarih.text;
      String gunlukVeri = tfGunluk.text;
      await _firestoreService.gunlukVeriEkleme(tarih,gunlukVeri);
    }



    return Scaffold(
      backgroundColor: MyColors.mc_cornsilk,
      appBar: AppBar(
        backgroundColor: MyColors.mc_cornsilk,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text("Tarih :",style: TextStyle(fontSize: 18,color: Colors.deepOrange,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(
                        width: width/2,
                        child: TextField(
                          controller: tfTarih,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20,left: 25),
                    child: TextFormField(
                      maxLines: null,
                      controller: tfGunluk,
                      decoration: InputDecoration(
                        hintText: "Bugün Neler Yaşadın ?",
                        border: InputBorder.none
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: ElevatedButton(
                    onPressed: (){
                      if(tfTarih.text.isNotEmpty){
                        if(tfGunluk.text.isNotEmpty){
                          gunlukKaydet();
                          Navigator.pop(context);
                        }
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Lütfen Boş Alanları Doldurun"),),
                        );
                      }
                    },
                    child: Text("Kaydet"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:Colors.deepOrange.shade400,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 4.0,
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
