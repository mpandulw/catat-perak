class TransactionItem {
  final String item;
  final double amount;

  TransactionItem({required this.item, required this.amount});

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    return TransactionItem(item: json['item'], amount: json['amount']);
  }

  Map<String, dynamic> toJson() => {"item": item, "amount": amount};
}
