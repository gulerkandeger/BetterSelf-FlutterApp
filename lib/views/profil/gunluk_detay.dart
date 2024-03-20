import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:better_self/model/gunluk_model.dart';
import 'package:better_self/model/myColors.dart';
import 'package:better_self/services/gunluk_services.dart';
import 'package:better_self/views/profil/gunluk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GunlukDetay extends StatefulWidget {

  final GunlukModel gunluk;
  final GunlukService gunlukService;


  GunlukDetay({required this.gunluk, required this.gunlukService});


  @override
  State<GunlukDetay> createState() => _GunlukDetayState();
}

class _GunlukDetayState extends State<GunlukDetay> {

  DateTime now = DateTime.now();
  TextEditingController tfTarih = TextEditingController();
  TextEditingController tfGunluk = TextEditingController();


  @override
  void initState() {
    super.initState();
    var gunluk = widget.gunluk;
    tfTarih.text = gunluk!.tarih;
    tfGunluk.text = gunluk!.gunlukVeri;
  }

  final _firestoreService = GunlukService();

  void gunlukGuncelle() async {
    String id = widget.gunluk.id;
    String tarih = tfTarih.text;
    String gunlukVeri = tfGunluk.text;
    await _firestoreService.gunlukVeriGuncelleme(GunlukModel(id: id, tarih: tarih, gunlukVeri: gunlukVeri,eklenmeTarihi:now ));
  }

  void gunlukSil() async{
    String id = widget.gunluk.id;
    await _firestoreService.gunlukVeriSil(id);
  }


  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MyColors.mc_cornsilk,
      appBar: AppBar(
        backgroundColor: MyColors.mc_cornsilk,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8,top: 5),
            child: IconButton(
              icon: Icon(Icons.delete,color: Colors.black26,),
              onPressed: (){
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.bottomSlide,
                  title: 'İzin Yok',
                  desc: "Bu sayfayı silmek istediğinize emin misiniz?",
                  descTextStyle: TextStyle(color: Colors.black54,fontSize: 18),
                  btnOkOnPress: (){
                    setState(() {
                      gunlukSil();
                      Navigator.pop(context);
                      _firestoreService.gunlukVeriAlma();
                    });
                  },
                  btnOkText: 'Evet',
                  btnOkColor: MyColors.mc_paynesGrey,
                  btnCancelText: 'Hayır',
                  btnCancelOnPress: (){}
                ).show();
              },
            ),
          ),
        ],
      ),
     body:SingleChildScrollView(
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
                     gunlukGuncelle();
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Gunluk()));
                   },
                   child: Text("Güncelle"),
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
