class PaymentResponse {
  final String? preimage;
  final String? paymentHash;

  PaymentResponse({this.preimage, this.paymentHash});
  // final Map<String, int> route;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'preimage': preimage,
      'paymentHash': paymentHash,
    };
  }

  factory PaymentResponse.fromMap(Map<String, dynamic> map) {
    return PaymentResponse(
      preimage: map['preimage'] as String,
      paymentHash: map['paymentHash'] as String,
    );
  }
}
