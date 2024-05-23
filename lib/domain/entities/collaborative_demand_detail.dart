class CollaborativeDemandDetail {
  late int id;
  late double quantity;
  late int yearMonth;
  late int collaborativeDemandId;
  late String customerName;
  late String productName;
  late String cityName;

  CollaborativeDemandDetail({
    required this.id,
    required this.quantity,
    required this.yearMonth,
    required this.collaborativeDemandId,
    required this.customerName,
    required this.productName,
    required this.cityName
  });

  List<CollaborativeDemandDetail> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => CollaborativeDemandDetail.fromJson(json)).toList();
  }

  CollaborativeDemandDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'] ;
    quantity = json['quantity'] ;
    yearMonth = json['yearMonth'] ;
    collaborativeDemandId = json['collaborativeDemandId'];
    customerName = json['customerName'] ;
    productName = json['productName'] ;
    cityName = json['cityName'] ;
  }

}