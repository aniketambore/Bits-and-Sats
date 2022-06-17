class Wallet {
  final String id;
  final String name;
  final int balance;

  Wallet({required this.id, required this.name, required this.balance});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'balance': balance,
    };
  }

  factory Wallet.fromMap(Map<String, dynamic> map) {
    return Wallet(
      id: map['id'] as String,
      name: map['name'] as String,
      balance: map['balance'] as int,
    );
  }
}
