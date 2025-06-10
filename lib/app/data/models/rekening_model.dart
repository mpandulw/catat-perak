class RekeningModel {
  final String id;
  final String name;
  final int balance;

  RekeningModel({required this.id, required this.name, required this.balance});

  factory RekeningModel.fromJson(Map<String, dynamic> json) {
    return RekeningModel(
      id: json['id'],
      name: json['name'],
      balance: json['balance'],
    );
  }
}
