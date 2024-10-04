class CBModel {
  int? id;
  String? code;
  String? ccy;
  String? ccyNmRU;
  String? ccyNmUZ;
  String? ccyNmUZC;
  String? ccyNmEN;
  String? nominal;
  String? rate;
  String? diff;
  String? date;

  CBModel(
      {this.id,
      this.code,
      this.ccy,
      this.ccyNmRU,
      this.ccyNmUZ,
      this.ccyNmUZC,
      this.ccyNmEN,
      this.nominal,
      this.rate,
      this.diff,
      this.date});

  CBModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['Code'];
    ccy = json['Ccy'];
    ccyNmRU = json['CcyNm_RU'];
    ccyNmUZ = json['CcyNm_UZ'];
    ccyNmUZC = json['CcyNm_UZC'];
    ccyNmEN = json['CcyNm_EN'];
    nominal = json['Nominal'];
    rate = json['Rate'];
    diff = json['Diff'];
    date = json['Date'];
  }
}

class Quote {
  final String text;
  final String from;

  Quote({required this.text, required this.from});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      text: json['text'],
      from: json['from'],
    );
  }
}
