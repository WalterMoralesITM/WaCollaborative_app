class Product {
  late int id;
  late String name;
  late String code;
  late double conversionFactor;
  late int categoryId;
  late int measurementUnitId;
  late int segmentId;
  late int statusId;
  late Status status;

  Product({
    required this.id,
    required this.name,
    required this.code,
    required this.conversionFactor,
    required this.categoryId,
    required this.measurementUnitId,
    required this.segmentId,
    required this.statusId,
    required this.status,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    conversionFactor = json['conversionFactor'];
    categoryId = json['categoryId'];
    measurementUnitId = json['measurementUnitId'];
    segmentId = json['segmentId'];
    statusId = json['statusId'];
    status = Status.fromJson(json['status']) ;
  }
}

class Status {
  late int id;
  late String name;
  late int statusTypeId;

  Status({
    required this.id,
    required this.name,
    required this.statusTypeId,
  });

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    statusTypeId = json['statusTypeId'];
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
  late int stateId;

  City({
    required this.id,
    required this.name,
    required this.stateId,
  });

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    stateId = json['stateId'];
  }
}

class CollaborativeDemandGrouped {
  late Product product;
  late Customer customer;
  late City city;
  late Status status;
  late int collaborativeDemandId;

  CollaborativeDemandGrouped({
    required this.product,
    required this.customer,
    required this.city,
    required this.status,
    required this.collaborativeDemandId,
  });


  List<CollaborativeDemandGrouped> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => CollaborativeDemandGrouped.fromJson(json)).toList();
  }

  CollaborativeDemandGrouped.fromJson(Map<String, dynamic> json) {
    product = Product.fromJson(json['product']) ;
    customer = Customer.fromJson(json['customer']);
    city = City.fromJson(json['city']) ;
    status = Status.fromJson(json['status']) ;
    collaborativeDemandId = json['collaborativeDemandId'];
  }

}
