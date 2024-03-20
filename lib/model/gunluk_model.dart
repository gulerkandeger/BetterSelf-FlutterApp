import 'package:cloud_firestore/cloud_firestore.dart';

class GunlukModel{
  final String id;
  final String tarih;
  final String gunlukVeri;
  final DateTime eklenmeTarihi;

  GunlukModel({required this.id,required this.tarih, required this.gunlukVeri, required this.eklenmeTarihi});

  factory GunlukModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return GunlukModel(
      id: snapshot.id,
      tarih: data['tarih'],
      gunlukVeri: data['gunluk'],
      eklenmeTarihi: data['eklenmeTarihi'].toDate(),
    );
  }

}