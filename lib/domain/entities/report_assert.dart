class ReportAssert {
  late int yearMonth;
  late double quantity;
  late double quantitySale;

  ReportAssert({
    required this.yearMonth,
    required this.quantity,
    required this.quantitySale

});


List<ReportAssert> listFromJson(List<dynamic> jsonList) {
  return jsonList.map((json) => ReportAssert.fromJson(json)).toList();
}

ReportAssert.fromJson(Map<String, dynamic> json) {
yearMonth = json['yearMonth'];
quantity = json['quantity'];
quantitySale = json['quantitySales'];
}

}