import 'package:better_self/model/gunluk_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GunlukService{

  DateTime now = DateTime.now();


  final CollectionReference gunlukCollection = FirebaseFirestore.instance.collection('gunluk');


  Future<List<GunlukModel>> gunlukVeriAlma() async {
    QuerySnapshot querySnapshot = await gunlukCollection.orderBy('eklenmeTarihi', descending: true).get();
    return querySnapshot.docs.map((doc){
      return GunlukModel(
        eklenmeTarihi: now,
        id: doc.id,
        tarih: doc['tarih'],
        gunlukVeri: doc['gunluk'],
      );
    }).toList();
  }

  Future<void> gunlukVeriEkleme(String tarih, String gunlukVeri) async {
    await gunlukCollection.add({'tarih': tarih,'gunluk': gunlukVeri, 'eklenmeTarihi': now});
  }

  Future<void> gunlukVeriGuncelleme(GunlukModel gunlukModel) async {
    await gunlukCollection.doc(gunlukModel.id).update({
      //'eklenmeTarihi': now,
      'tarih': gunlukModel.tarih,
      'gunluk': gunlukModel.gunlukVeri,
    });
  }

  Future<void> gunlukVeriSil(String id) async {
    await gunlukCollection.doc(id).delete();
  }

}
