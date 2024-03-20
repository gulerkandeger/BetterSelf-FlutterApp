import 'package:better_self/model/myColors.dart';
import 'package:better_self/views/zinciri_kirma/zincir_detay.dart';
import 'package:better_self/views/zinciri_kirma/zincir_kayit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ZinciriKirmaAdd extends StatefulWidget {
  const ZinciriKirmaAdd({super.key});

  @override
  State<ZinciriKirmaAdd> createState() => _ZinciriKirmaAddState();
}

class _ZinciriKirmaAddState extends State<ZinciriKirmaAdd> {

  List<String> popularHabits = ['📚️ Kitap Oku','🏋🏻‍♀️ Spor Yap','🥡 Şekersiz Yaşam','🧘🏻 Meditasyon','🚭️ Sigarayı Bırak','🛌🏻 Erken Kalk'];
  List<String> lifeHabits = ['🧘🏻 Meditasyon','🛌🏻 Erken Kalk','📚️ Kitap Oku','💆‍♀️ Kişisel Bakım','🧑‍🎓Dil öğren'];
  List<String> healthHabits = ['🚭️ Sigarayı Bırak','🙆‍♀️ Duruşunu Düzelt','🥡 Şekersiz Yaşam','🫗 Su iç'];
  List<String> sporHabits = ['🚶‍♀️ Yürüyüşe Çık','🥗 Dengeli Beslen','💊 Günlük Vitamin','🏋🏻‍♀️ Spor Yap'];

  List<String> popularDesc = ['Kendinizi geliştirmek ve yeni dünyalara açılmak için düzenli olarak kitap okuma alışkanlığı edinin.',
                              'Fiziksel sağlığınızı güçlendirmek ve enerji seviyelerinizi artırmak için düzenli olarak spor yapın.',
                              'Şeker tüketimini sınırlayarak sağlıklı bir yaşam tarzına geçin ve enerjinizi daha dengeli hale getirin.',
                              'Zihinsel sağlığınızı güçlendirmek, stresle başa çıkmak ve içsel huzur bulmak için meditasyon yapın.',
                              'Sağlığınızı iyileştirmek ve uzun vadeli bir yaşam için sigarayı bırakma çabasına katılın.',
                              'Düzenli olarak erken kalkmak, gününüzü daha planlı ve verimli geçirmenize yardımcı olabilir.'
                             ];

  List<String> lifeDesc = ['Zihinsel sağlığınızı güçlendirmek, stresle başa çıkmak ve içsel huzur bulmak için meditasyon yapın.',
                           'Düzenli olarak erken kalkmak, gününüzü daha planlı ve verimli geçirmenize yardımcı olabilir.',
                           'Kendinizi geliştirmek ve yeni dünyalara açılmak için düzenli olarak kitap okuma alışkanlığı edinin.',
                           'Kendinize zaman ayırarak kişisel bakımınıza özen gösterin, ruhsal ve fiziksel sağlığınızı güçlendirin.',
                            'Yeni bir dil öğrenmek, zihinsel kapasitenizi artırabilir ve kültürel açıdan zenginleşmenize katkı sağlar.'
                          ];

  List<String> healthDesc = [ 'Sağlığınızı iyileştirmek ve uzun vadeli bir yaşam için sigarayı bırakma çabasına katılın.',
                              'Doğru duruş alışkanlığı edinmek, sırt ve boyun problemlerini önlemeye yardımcı olabilir.',
                              'Şeker tüketimini sınırlayarak sağlıklı bir yaşam tarzına geçin ve enerjinizi daha dengeli hale getirin.',
                              'Günlük su tüketimine dikkat ederek vücudunuzu temizleyin ve genel sağlığınızı destekleyin.'
                            ];

  List<String> sporDesc = [ 'Düzenli yürüyüş yapmak, hem fiziksel hem de zihinsel sağlığınıza olumlu etkiler sağlar.',
                            'Beslenme alışkanlıklarınızı düzenleyerek vücudunuzun ihtiyaç duyduğu besinleri alın.',
                            'Vitamin ve mineral takviyeleri kullanarak sağlıklı bir beslenme alışkanlığı oluşturun.',
                            'Fiziksel sağlığınızı güçlendirmek ve enerji seviyelerinizi artırmak için düzenli olarak spor yapın.'
                          ];


  Future<void> habitKayit(String habitName, String habitDesc) async{
    var sp = await SharedPreferences.getInstance();
    sp.setString("habitName", habitName);
    sp.setString("habitDesc", habitDesc);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: MyColors.mc_wisteria,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.mc_wisteria,
        title: Align(
          alignment: Alignment.center,
            child: Text("Zinciri Kırma",style: TextStyle(color: MyColors.mc_vanilya),)
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20,bottom: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Popüler Alışkanlıklar",style: TextStyle(color: Colors.black26),)
                  ),
                ),
                SizedBox(
                  height: 110,
                  child: ListView.builder(
                    itemCount: popularHabits.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return SizedBox(
                        width: 170,
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              habitKayit(popularHabits[index], popularDesc[index]);
                            });
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ZincirDetay()));
                          },
                          child: Card(
                            color: MyColors.mc_pureWhite,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Text( popularHabits[index],style: TextStyle(fontSize: 17),maxLines: 2,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(popularDesc[index],style: TextStyle(fontSize: 12,color: Colors.black26),overflow: TextOverflow.ellipsis,maxLines: 2,),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                        width: 23,
                                        height: 23,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: MyColors.mc_wisteria
                                        ),
                                        child: const Icon(Icons.add_sharp,color: Colors.white,)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20,bottom: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Yaşam Tarzı",style: TextStyle(color: Colors.black26),)
                  ),
                ),
                SizedBox(
                  height: 110,
                  child: ListView.builder(
                    itemCount: lifeHabits.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return SizedBox(
                        width: 170,
                        child: GestureDetector(
                          onTap: (){
                              habitKayit(lifeHabits[index], lifeDesc[index]);
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ZincirDetay()));
                          },
                          child: Card(
                            color: MyColors.mc_pureWhite,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Text( lifeHabits[index],style: TextStyle(fontSize: 17),maxLines: 2,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(lifeDesc[index],style: TextStyle(fontSize: 12,color: Colors.black26),overflow: TextOverflow.ellipsis,maxLines: 2,),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                        width: 23,
                                        height: 23,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: MyColors.mc_wisteria
                                        ),
                                        child: const Icon(Icons.add_sharp,color: Colors.white,)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20,bottom: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Sağlık",style: TextStyle(color: Colors.black26),)
                  ),
                ),
                SizedBox(
                  height: 110,
                  child: ListView.builder(
                    itemCount: healthHabits.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return SizedBox(
                        width: 170,
                        child: GestureDetector(
                          onTap: (){
                            habitKayit(healthHabits[index], healthDesc[index]);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ZincirDetay()));
                          },
                          child: Card(
                            color: MyColors.mc_pureWhite,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Text( healthHabits[index],style: TextStyle(fontSize: 16),maxLines: 2,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(healthDesc[index],style: TextStyle(fontSize: 12,color: Colors.black26),overflow: TextOverflow.ellipsis,maxLines: 2,),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                        width: 23,
                                        height: 23,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: MyColors.mc_wisteria
                                        ),
                                        child: const Icon(Icons.add_sharp,color: Colors.white,)),
                                  ),                              ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20,bottom: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Spor & Beslenme",style: TextStyle(color: Colors.black26),)
                  ),
                ),
                SizedBox(
                  height: 110,
                  child: ListView.builder(
                    itemCount: sporHabits.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return SizedBox(
                        width: 170,
                        child: GestureDetector(
                          onTap: (){
                            habitKayit(sporHabits[index], sporDesc[index]);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ZincirDetay()));
                          },
                          child: Card(
                            color: MyColors.mc_pureWhite,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Text( sporHabits[index],style: TextStyle(fontSize: 17),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(sporDesc[index],style: TextStyle(fontSize: 12,color: Colors.black26),overflow: TextOverflow.ellipsis,maxLines: 2,),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                        width: 23,
                                        height: 23,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: MyColors.mc_wisteria
                                        ),
                                        child: const Icon(Icons.add_sharp,color: Colors.white,)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                    child: Text("➕  Yeni Alışkanlık Ekle",style: TextStyle(color: Colors.black87),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.mc_lavenderGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13)
                      ),
                      fixedSize: Size(300, 45)
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ZincirKayit()));
                    },
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
