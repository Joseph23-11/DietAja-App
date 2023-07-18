class WeightData {
  final String date;
  final double berat;
  final double initialBerat;
  double reduction;

  WeightData({
    required this.date,
    required this.berat,
    required this.initialBerat,
    double? reduction,
  }) : reduction = reduction ?? 0.0;
}
