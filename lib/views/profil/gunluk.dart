import 'package:better_self/model/gunluk_model.dart';
import 'package:better_self/model/myColors.dart';
import 'package:better_self/services/gunluk_services.dart';
import 'package:better_self/views/profil/Profil.dart';
import 'package:better_self/views/profil/gunluk_detay.dart';
import 'package:better_self/views/profil/gunluk_kayit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Gunluk extends StatefulWidget {

  @override
  State<Gunluk> createState() => _GunlukState();
}

class _GunlukState extends State<Gunluk> {

  final GunlukService gunlukService = GunlukService();
  final _firestoreService = GunlukService();

  @override
  void initState() {
    super.initState();
    _firestoreService.gunlukVeriAlma();
  }

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();

    return WillPopScope(
      onWillPop: ()async{
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.mc_cornsilk,
          automaticallyImplyLeading: false,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Günlük  ",style:GoogleFonts.notoSerif()),
              SizedBox(width:35,child: Image.asset("images/gunluk.png")),
            ],
          ),
        ),
        body: FutureBuilder(
          future: _firestoreService.gunlukVeriAlma(),
          builder: (context, AsyncSnapshot<List<GunlukModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            else if(snapshot.connectionState == ConnectionState.done && snapshot.data == null){
              return Center(child: Text("Bir şeyler eklemek ister misin ?"));
            }
            else if (snapshot.hasError) {
              return Text('Hata: ${snapshot.error}');
            }
            else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2/1.5,
                    crossAxisCount: 2, // İki sütunlu bir grid
                    crossAxisSpacing: 8.0, // Sütunlar arası boşluk
                    mainAxisSpacing: 8.0, // Satırlar arası boşluk
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>GunlukDetay(gunluk:snapshot.data![index], gunlukService: gunlukService)));
                      },
                      child: Card(
                        color: MyColors.mc_frenchGrey,
                        child: Stack(
                          children: [
                            GridTile(
                              child: Center(
                                child: Text(
                                  snapshot.data![index].tarih,
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Agbalumo',
                                  ),
                                ),
                              ),
                              footer: GridTileBar(
                                backgroundColor: Colors.white54,
                                title: Text(snapshot.data![index].gunlukVeri, style: TextStyle(color: Colors.black)),
                              ),
                            ),
                            Positioned(
                              top: 8.0,
                              left: 8.0,
                              child: Icon(Icons.attach_file_rounded,color: Colors.black26,),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange.shade400,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>GunlukKayit()));
          },
          child: Icon(Icons.add,color: Colors.white,),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
