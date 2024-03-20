class ZinciriKirmaModel{

  String id;
  String habitName;
  String habitDesc;
  DateTime startDate;
  int habitTime;

  ZinciriKirmaModel({required this.id, required this.habitName, required this.habitDesc, required this.startDate, required this.habitTime});

  factory ZinciriKirmaModel.fromSnapshot(DocumentSnapshot, snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return ZinciriKirmaModel(
      id: snapshot.id,
      habitName: data['name'],
      habitDesc: data['desc'],
      startDate: data['startDate'],
      habitTime: data['habitTime']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': habitName,
      'desc' : habitDesc,
      'startDate' : startDate,
      'habitTime' : habitTime,
    };
  }

}