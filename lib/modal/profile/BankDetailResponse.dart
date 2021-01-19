class BankResponse {
  List<String> scalar = [];
  String message;

  BankResponse({this.scalar});

  BankResponse.fromJson(List<dynamic> json) {
    // scalar.add(json.map((key, value) => null));
    // for (int i = 0; i < json.length; i++) {
      json.forEach((value) {
        // print('111111112112121212121221');
        // print(value);
        scalar.add(value['scalar']);
      });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scalar'] = this.scalar;
    return data;
  }

  BankResponse.fromError(String errorValue) {
    this.message = errorValue;
  }
}
