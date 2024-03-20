import 'package:better_self/model/myColors.dart';
import 'package:better_self/services/zinciri_kirma_services.dart';
import 'package:better_self/views/zinciri_kirma/zinciri_kirma.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ZincirDetay extends StatefulWidget {
  const ZincirDetay({super.key});

  @override
  State<ZincirDetay> createState() => _ZincirDetayState();
}

class _ZincirDetayState extends State<ZincirDetay> {

  TextEditingController tf_zincirName = TextEditingController();
  TextEditingController tf_zincirDesc = TextEditingController();

  List<String> aylar = ['1 Ay','3 Ay','6 Ay', '12 Ay'];
  List<int> selectedDays = [30,90,180,360];
  int selectedMonthIndex = -1;
  int selectedMonth = 30;

  DateTime now = DateTime.now();
  final _firestoreService = ZinciriKirmaService();

  void zincirKaydet() async {
    String habitName = tf_zincirName.text;
    String habitDesc = tf_zincirDesc.text;
    await _firestoreService.zinciriKirmaVeriEkle(habitName, habitDesc,now,selectedMonth);
  }


  Future<void> habitOku() async{
    var sp = await SharedPreferences.getInstance();
    var zincirName = sp.getString("habitName");
    var zincirDesc = sp.getString("habitDesc");
    if (zincirName != null && zincirDesc != null) {
      tf_zincirName.text = zincirName;
      tf_zincirDesc.text = zincirDesc;
    } else {
      print("SharedPreferences'ten okunan değerler null.");
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      habitOku();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.mc_ametist,
      appBar: AppBar(
        backgroundColor: MyColors.mc_ametist,
        title: Text("Alışkanlık Ekle"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20,bottom: 5,left: 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                    child: Text("Alışkanlık Adı:")
                ),
              ),
              SizedBox(
                height: 50,
                width: 370,
                child: TextField(
                  controller: tf_zincirName,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: MyColors.mc_ametistLight,
                    hintText: "Alışkanlık Adını Yazınız",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30,bottom: 5,left: 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Alışkanlık Açıklaması:")
                ),
              ),
              SizedBox(
                width: 370,
                child: TextFormField(
                  controller: tf_zincirDesc,
                  maxLines: null,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: MyColors.mc_ametistLight,
                    hintText: "Alışkanlık Açıklamasını Giriniz",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30,bottom: 5,left: 5),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Alışkanlığa ne kadar devam edeceksiniz ?")
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: aylar.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: Card(
                            child: Center(
                              child: SizedBox(
                                width: 70,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Center(
                                            child: Text("${aylar[index]}",style: TextStyle(fontSize: 16, color: Colors.black87))
                                        )
                                    ),
                                    Visibility(
                                      visible: selectedMonthIndex == index,
                                      child: Icon(Icons.check, color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onTap: (){
                            if (selectedMonthIndex == index) {
                              setState(() {
                                selectedMonthIndex = -1;
                              });
                            } else {
                              setState(() {
                                selectedMonthIndex = index;
                              });
                            }
                            setState(() {
                              selectedMonth = selectedDays[index];
                            });
                          },
                        );
                      }
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.mc_wisteria,
                  ),
                  child: Text("Oluştur",style: TextStyle(color: MyColors.mc_ametistLight),),
                  onPressed: (){
                    zincirKaydet();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ZinciriKirma()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
