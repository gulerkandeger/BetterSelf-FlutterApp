import 'package:better_self/model/zinciri_kirma_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ZinciriKirmaService{

  DateTime now = DateTime.now();
  
  final CollectionReference habitCollection = FirebaseFirestore.instance.collection('zinciriKirma');

  Future<List<ZinciriKirmaModel>> zinciriKirmaVeriAl() async{
    QuerySnapshot querySnapshot = await habitCollection.get();
    List<DocumentSnapshot> documents = querySnapshot.docs;
    return documents.map((doc){
      return ZinciriKirmaModel(
        id: doc.id,
        habitName: doc['name'],
        habitDesc: doc['desc'],
        startDate: doc['startDate'].toDate(),
        habitTime: doc['habitTime'],
      );
    }).toList();
  }


  Future<void> zinciriKirmaVeriEkle(String habitName, String habitDesc, DateTime startDate, int habitTime) async{
    await habitCollection.add({
      'name': habitName,
      'desc' : habitDesc,
      'startDate' : startDate,
      'habitTime' : habitTime,
    });
  }

  Future<void> zinciriKirmaVeriGuncelle(String id, String habitName, String habitDesc) async{
    await habitCollection.doc(id).update({
      'name': habitName,
      'desc' : habitDesc,
    });
  }

  Future<void> zinciriKirmaVeriSil(String id) async{
    await habitCollection.doc(id).delete();
  }
  
}