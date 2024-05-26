class Product {
  late int id;
  late String name;
  late String code;
  late double conversionFactor;
  late int categoryId;
  late int measurementUnitId;
  late int segmentId;

  Product({
    required this.id,
    required this.name,
    required this.code,
    required this.conversionFactor,
    required this.categoryId,
    required this.measurementUnitId,
    required this.segmentId,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    conversionFactor = json['conversionFactor'];
    categoryId = json['categoryId'];
    measurementUnitId = json['measurementUnitId'];
    segmentId = json['segmentId'];
  }
}

class Status {
  late int id;
  late String name;

  Status({
    required this.id,
    required this.name,
  });

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class Customer {
  late int id;
  late String name;
  late String code;
  late int distributionChannelId;
  late int shippingPointsNumber;

  Customer({
    required this.id,
    required this.name,
    required this.code,
    required this.distributionChannelId,
    required this.shippingPointsNumber,
  });

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    distributionChannelId = json['distributionChannelId'];
    shippingPointsNumber = json['shippingPointsNumber'];
  }
}

class City {
  late int id;
  late String name;

  City({
    required this.id,
    required this.name,
  });

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class CollaborativeDemandGrouped {
  late Product product;
  late Customer customer;
  late City city;
  late int collaborativeDemandId;
  late String statusName;
  late int initialPeriod;
  late int finalPeriod;

  CollaborativeDemandGrouped({
    required this.product,
    required this.customer,
    required this.city,
    required this.statusName,
    required this.collaborativeDemandId,
    required this.finalPeriod,
    required this.initialPeriod
  });


  List<CollaborativeDemandGrouped> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => CollaborativeDemandGrouped.fromJson(json)).toList();
  }

  CollaborativeDemandGrouped.fromJson(Map<String, dynamic> json) {
    product = Product.fromJson(json['product']) ;
    customer = Customer.fromJson(json['customer']);
    city = City.fromJson(json['city']) ;
    statusName =json['statusName'] ;
    collaborativeDemandId = json['collaborativeDemandId'];
    finalPeriod = json['finalPeriod'];
    initialPeriod = json['initialPeriod'];
  }

}
