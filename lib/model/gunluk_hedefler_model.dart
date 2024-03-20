import 'package:cloud_firestore/cloud_firestore.dart';

class GunlukHedeflerModel{

  String id;
  String gorev;
  bool check;
  String oncelik;
  DateTime tarih;

  GunlukHedeflerModel({required this.id,required this.gorev,required this.check,required this.oncelik,required this.tarih});

  factory GunlukHedeflerModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return GunlukHedeflerModel(
      id: snapshot.id,
      gorev: data['gorev'],
      check: data['check'],
      oncelik: data['oncelik'],
      tarih: data['tarih'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gorev': gorev,
      'check': check,
      'oncelik' : oncelik,
      'tarih' : tarih,
    };
  }
}