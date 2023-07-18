class PrediksiModel {
  PrediksiBeratSekarang? prediksiBeratSekarang;
  HariTarget? hariTarget;
  List<RegressionLine>? regressionLine;

  PrediksiModel(
      {this.prediksiBeratSekarang, this.hariTarget, this.regressionLine});

  PrediksiModel.fromJson(Map<String, dynamic> json) {
    prediksiBeratSekarang = json['prediksi_berat_sekarang'] != null
        ? PrediksiBeratSekarang.fromJson(json['prediksi_berat_sekarang'])
        : null;
    hariTarget = json['hari_target'] != null
        ? HariTarget.fromJson(json['hari_target'])
        : null;
    if (json['regression_line'] != null) {
      regressionLine = <RegressionLine>[];
      json['regression_line'].forEach((v) {
        regressionLine!.add(RegressionLine.fromJson(v));
      });
    }
  }
}

class PrediksiBeratSekarang {
  String? tanggal;
  double? berat;

  PrediksiBeratSekarang({this.tanggal, this.berat});

  PrediksiBeratSekarang.fromJson(Map<String, dynamic> json) {
    tanggal = json['tanggal'];
    berat = double.parse(json['berat'].toString());
  }
}

class HariTarget {
  String? tanggal;
  int? hari;

  HariTarget({this.tanggal, this.hari});

  HariTarget.fromJson(Map<String, dynamic> json) {
    tanggal = json['tanggal'];
    hari = json['hari'];
  }
}

class RegressionLine {
  String? hari;
  double? berat;

  RegressionLine({this.hari, this.berat});

  RegressionLine.fromJson(Map<String, dynamic> json) {
    hari = json['hari'];
    berat = double.parse(json['berat'].toString());
  }
}
