import 'package:better_self/model/ilham_noktasi_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IlhamNoktasiService{

  final CollectionReference ilhamCollection = FirebaseFirestore.instance.collection('ilhamnoktasi');

  Future<List<IlhamNoktasiModel>> ilhamVeriAlma() async{
     QuerySnapshot querySnapshot = await ilhamCollection.get();
     List<DocumentSnapshot> documents = querySnapshot.docs;
     documents.shuffle();
     return documents.map((doc){
       return IlhamNoktasiModel(
         id: doc.id,
         ilham: doc['ilham'],
         favori: doc['favori'],
       );
     }).toList();
  }

  Future<List<IlhamNoktasiModel>> favoriIlhamVeriAlma() async{
    QuerySnapshot querySnapshot = await ilhamCollection.where('favori', isEqualTo: true).get();
    List<DocumentSnapshot> documents = querySnapshot.docs;
    documents.shuffle();
    return documents.map((doc){
      return IlhamNoktasiModel(
        id: doc.id,
        ilham: doc['ilham'],
        favori: doc['favori'],
      );
    }).toList();
  }

  Future<void> ilhamFavGuncelleme(String id, bool yeniFavoriDurumu) async {
      await ilhamCollection.doc(id).update({
        'favori': yeniFavoriDurumu,
      });
  }


}