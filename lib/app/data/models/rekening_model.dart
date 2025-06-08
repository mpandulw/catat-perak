class RekeningModel {
  final int? id;
  final String name;
  final int balance;

  RekeningModel({this.id, required this.name, required this.balance});

  factory RekeningModel.fromMap(Map<String, dynamic> map) {
    return RekeningModel(
      id: map['id'],
      name: map['name'],
      balance: map['balance'],
    );
  }

  Map<String, dynamic> toMap() {
    final data = {"name": name, "balance": balance};
    if (id != null) data['id'] = id!;
    return data;
  }
}
