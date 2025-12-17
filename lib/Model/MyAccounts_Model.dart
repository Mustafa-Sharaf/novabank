class AccountsModel {
  final int id;
  final String userId;
  final String userName;
  final int parentAccountId;
  final String state;
  final String type;
  final DateTime createdAt;
  final double balance;
  final List<AccountsModel> children;

  AccountsModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.parentAccountId,
    required this.state,
    required this.type,
    required this.createdAt,
    required this.balance,
    required this.children,
  });

  factory AccountsModel.fromJson(Map<String, dynamic> json) {
    return AccountsModel(
      id: json['id'],
      userId: json['userId'],
      userName: json['userName'] ?? '',
      parentAccountId: json['parentAccountId'],
      state: json['state'],
      type: json['type'],
      createdAt: DateTime.parse(json['createdAt']),
      balance: (json['balance'] ?? 0).toDouble(),
      children: (json['children'] as List<dynamic>)
          .map((e) => AccountsModel.fromJson(e))
          .toList(),
    );
  }
}
