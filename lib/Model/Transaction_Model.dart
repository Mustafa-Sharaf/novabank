class TransactionModel {
  final int id;
  final int amount;
  final String transactionType;
  final String status;
  final int fromAccountId;
  final int toAccountId;
  final String approvedByUserId;
  final String? approvedByUserName;
  final DateTime approvedAt;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.transactionType,
    required this.status,
    required this.fromAccountId,
    required this.toAccountId,
    required this.approvedByUserId,
    this.approvedByUserName,
    required this.approvedAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      amount: json['amount'],
      transactionType: json['transactionType'],
      status: json['status'],
      fromAccountId: json['fromAccountId'],
      toAccountId: json['toAccountId'],
      approvedByUserId: json['approvedByUserId'],
      approvedByUserName: json['approvedByUserName'],
      approvedAt: DateTime.parse(json['approvedAt']),
    );
  }
}
