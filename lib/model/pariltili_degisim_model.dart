
import 'package:cloud_firestore/cloud_firestore.dart';

class PariltiliDegisimModel{

  final String id;
  final String challenge;
  final bool check;

  PariltiliDegisimModel({required this.id, required this.challenge,required this.check});


  factory PariltiliDegisimModel.fromSnapshot(DocumentSnapshot, snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return PariltiliDegisimModel(
      id: snapshot.id,
      challenge: data['challenge'],
      check: data['check'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'challenge': challenge,
      'check' : check,
    };
  }

}