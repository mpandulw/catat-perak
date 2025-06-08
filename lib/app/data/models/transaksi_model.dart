import 'package:flutter_application_1/app/data/models/item_transaksi_model.dart';

class Transaction {
  final String title;
  final DateTime date;
  final String account;
  final bool isIncome;
  final String? note;
  final List<TransactionItem>? items;

  Transaction({
    required this.title,
    required this.date,
    required this.account,
    required this.isIncome,
    required this.items,
    this.note,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      title: json['title'],
      date: json['date'],
      account: json['account'],
      isIncome: json['isIncome'],
      items:
          json['items'] != null
              ? List<TransactionItem>.from(
                json['items'].map((x) => TransactionItem.fromJson(x)),
              )
              : null,
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'date': date.toIso8601String(),
    'account': account,
    'isIncome': isIncome,
    'items': items?.map((x) => x.toJson()).toList(),
    'note': note,
  };

  double get totalAmount {
    // if (amount != null) return amount!;
    return items?.fold(0.0, (sum, item) => sum! + item.amount) ?? 0.0;
  }
}
