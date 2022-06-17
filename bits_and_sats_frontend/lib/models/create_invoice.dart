class CreateInvoice {
  final String paymentHash;
  final String paymentRequest;

  CreateInvoice({required this.paymentHash, required this.paymentRequest});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'payment_hash': paymentHash,
      'payment_request': paymentRequest,
    };
  }

  factory CreateInvoice.fromMap(Map<String, dynamic> map) {
    return CreateInvoice(
      paymentHash: map['payment_hash'] as String,
      paymentRequest: map['payment_request'] as String,
    );
  }
}
