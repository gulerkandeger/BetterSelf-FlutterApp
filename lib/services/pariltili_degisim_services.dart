import 'package:better_self/model/pariltili_degisim_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PariltiliDegisimService{

  final CollectionReference kendiniSevCollection = FirebaseFirestore.instance.collection('challengeKendiniSev');
  final CollectionReference ozguvenCollection = FirebaseFirestore.instance.collection('challengeOzguven');
  final CollectionReference mentalCollection = FirebaseFirestore.instance.collection('challengeMental');
  final CollectionReference uretkenlikCollection = FirebaseFirestore.instance.collection('challengeUretkenlik');
  final CollectionReference kisiselGelisimCollection = FirebaseFirestore.instance.collection('challengeKisiselGelisim');





  Future<List<PariltiliDegisimModel>> kendiniSevVeriAlma() async{
    QuerySnapshot querySnapshot = await kendiniSevCollection.get();
    List<DocumentSnapshot> documents = querySnapshot.docs;
    return documents.map((doc){
      return PariltiliDegisimModel(
        id: doc.id,
        challenge: doc['challenge'],
        check: doc['check'],
      );
    }).toList();
  }

  Future<void> kendiniSevCheckUpdate(String documentId,bool check) async {
    await kendiniSevCollection.doc(documentId).update({
      'check': check
    });
  }

  Future<List<PariltiliDegisimModel>> ozguvenVeriAlma() async{
    QuerySnapshot querySnapshot = await ozguvenCollection.get();
    List<DocumentSnapshot> documents = querySnapshot.docs;
    return documents.map((doc){
      return PariltiliDegisimModel(
        id: doc.id,
        challenge: doc['challenge'],
        check: doc['check'],
      );
    }).toList();
  }

  Future<void> ozguvenCheckUpdate(String documentId,bool check) async {
    await kendiniSevCollection.doc(documentId).update({
      'check': check
    });
  }

  Future<List<PariltiliDegisimModel>> mentalVeriAlma() async{
    QuerySnapshot querySnapshot = await mentalCollection.get();
    List<DocumentSnapshot> documents = querySnapshot.docs;
    return documents.map((doc){
      return PariltiliDegisimModel(
        id: doc.id,
        challenge: doc['challenge'],
        check: doc['check'],
      );
    }).toList();
  }

  Future<void> mentalCheckUpdate(String documentId,bool check) async {
    await kendiniSevCollection.doc(documentId).update({
      'check': check
    });
  }

  Future<List<PariltiliDegisimModel>> uretkenlikVeriAlma() async{
    QuerySnapshot querySnapshot = await uretkenlikCollection.get();
    List<DocumentSnapshot> documents = querySnapshot.docs;
    return documents.map((doc){
      return PariltiliDegisimModel(
        id: doc.id,
        challenge: doc['challenge'],
        check: doc['check'],
      );
    }).toList();
  }

  Future<void> uretkenlikCheckUpdate(String documentId,bool check) async {
    await kendiniSevCollection.doc(documentId).update({
      'check': check
    });
  }

  Future<List<PariltiliDegisimModel>> kisiselGelisimVeriAlma() async{
    QuerySnapshot querySnapshot = await kisiselGelisimCollection.get();
    List<DocumentSnapshot> documents = querySnapshot.docs;
    return documents.map((doc){
      return PariltiliDegisimModel(
        id: doc.id,
        challenge: doc['challenge'],
        check: doc['check'],
      );
    }).toList();
  }

  Future<void> kisiselGelisimCheckUpdate(String documentId,bool check) async {
    await kendiniSevCollection.doc(documentId).update({
      'check': check
    });
  }
}