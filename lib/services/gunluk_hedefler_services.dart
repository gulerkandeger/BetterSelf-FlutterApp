import 'package:better_self/model/gunluk_hedefler_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GunlukHedeflerService{

  final CollectionReference gunlukHedefCollection = FirebaseFirestore.instance.collection('gunlukHedefler');

  Future<List<GunlukHedeflerModel>> gunlukHedefVeriAlma() async{
    QuerySnapshot querySnapshot = await gunlukHedefCollection.get();
    List<DocumentSnapshot> documents = querySnapshot.docs;
    return documents.map((doc){
      return GunlukHedeflerModel(
        id: doc.id,
        gorev: doc['gorev'],
        check: doc['check'],
        oncelik: doc['oncelik'],
        tarih: doc['tarih'].toDate()
      );
    }).toList();
  }


  Future<void> gunlukHedefGuncelleme(String id, String yeniGorev, bool yeniCheck) async {
    await gunlukHedefCollection.doc(id).update({
      'gorev': yeniGorev,
      'check' : yeniCheck,
    });
  }

  Future<void> gunlukHedefVeriEkleme(String gorev, bool check, String oncelik, DateTime tarih) async{
    await gunlukHedefCollection.add({
      'gorev': gorev,
      'check' : check,
      'oncelik' : oncelik,
      'tarih' : tarih
    });
  }

  Future<void> gunlukHedefSilme(String id)async{
    await gunlukHedefCollection.doc(id).delete();
  }

}