class CollaborativeDemandSales {
  late String productName;
  late String customerName;
  late String cityName;
  late double quantitySaled;
  late int yearMonth;

CollaborativeDemandSales({
  required this.productName,
  required this.customerName,
  required this.cityName,
  required this.quantitySaled,
  required this.yearMonth,
});


List<CollaborativeDemandSales> listFromJson(List<dynamic> jsonList) {
  return jsonList.map((json) => CollaborativeDemandSales.fromJson(json)).toList();
}

CollaborativeDemandSales.fromJson(Map<String, dynamic> json) {
productName = json['productName'] ;
customerName = json['customerName'];
cityName = json['cityName'] ;
quantitySaled =json['quantitySaled'] ;
yearMonth = json['yearMonth'];
}

}