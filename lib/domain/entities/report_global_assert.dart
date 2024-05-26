class ReportGlobalAssert {
  late double quantityProjected;
  late double quantitySale;
  late double percentage;

  ReportGlobalAssert({
    required this.quantityProjected,
    required this.quantitySale,
    required this.percentage
});


List<ReportGlobalAssert> listFromJson(List<dynamic> jsonList) {
  return jsonList.map((json) => ReportGlobalAssert.fromJson(json)).toList();
}

ReportGlobalAssert.fromJson(Map<String, dynamic> json) {
  quantityProjected = json['quantityProjected'];
  percentage = json['percentage'];
  quantitySale = json['quantitySale'];
}

}