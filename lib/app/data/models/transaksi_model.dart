import 'package:flutter_application_1/app/data/models/item_transaksi_model.dart';

class Transaction {
  final String id;
  final String title;
  final DateTime date;
  final String account;
  final String type;
  final String? note;
  final List<TransactionItem>? items;
  final int totalPrice;

  Transaction({
    required this.id,
    required this.title,
    required this.date,
    required this.account,
    required this.type,
    required this.items,
    this.note,
    required this.totalPrice,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      title: json['name'],
      date: DateTime.parse(json['date']),
      account: json['account'],
      type: json['type'],
      items:
          json['items'] != null
              ? List<TransactionItem>.from(
                json['items'].map((x) => TransactionItem.fromJson(x)),
              )
              : null,
      note: json['note'],
      totalPrice: json['total_price'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': title,
    'date': date.toIso8601String(),
    'account': account,
    'type': type,
    'items': items?.map((x) => x.toJson()).toList(),
    'note': note,
  };

  // double get totalAmount {
  //   // if (amount != null) return amount!;
  //   return items?.fold(0.0, (sum, item) => sum! + item.amount) ?? 0.0;
  // }
}
