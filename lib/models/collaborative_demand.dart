class CollaborativeDemand {
  int collaborativeDemandId;
  int collaborativeDemandDetailId;
  String customerCode;
  String customerName;
  String cityName;
  String distributionChannel;
  String productCode;
  String productName;
  String shippingPointName;
  double quantity;
  String? userEmail;
  int? userId;
  int yearMonth;
  DateTime collaborationEndDate;
  int id;
  String? demandType;
  int demandTypeId;
  String? eventType;
  int eventTypeId;
  dynamic product;
  int productId;
  dynamic shippingPoint;
  int shippingPointId;
  dynamic status;
  int statusId;
  dynamic collaborativeDemandComponentsDetails;
  dynamic collaborativeDemandComponentsDetailsDTO;
  dynamic userCollaborativeDemands;
  dynamic collaborativeDemandUsers;
  int collaborativeDemandUsersNumber;

  CollaborativeDemand({
    required this.collaborativeDemandId,
    required this.collaborativeDemandDetailId,
    required this.customerCode,
    required this.customerName,
    required this.cityName,
    required this.distributionChannel,
    required this.productCode,
    required this.productName,
    required this.shippingPointName,
    required this.quantity,
    this.userEmail,
    this.userId,
    required this.yearMonth,
    required this.collaborationEndDate,
    required this.id,
    this.demandType,
    required this.demandTypeId,
    this.eventType,
    required this.eventTypeId,
    this.product,
    required this.productId,
    this.shippingPoint,
    required this.shippingPointId,
    this.status,
    required this.statusId,
    this.collaborativeDemandComponentsDetails,
    this.collaborativeDemandComponentsDetailsDTO,
    this.userCollaborativeDemands,
    this.collaborativeDemandUsers,
    required this.collaborativeDemandUsersNumber,
  });

  factory CollaborativeDemand.fromJson(Map<String, dynamic> json) {
    return CollaborativeDemand(
      collaborativeDemandId: json['collaborativeDemandId'],
      collaborativeDemandDetailId: json['collaborativeDemandDetailId'],
      customerCode: json['customerCode'],
      customerName: json['customerName'],
      cityName: json['cityName'],
      distributionChannel: json['distributionChannel'],
      productCode: json['productCode'],
      productName: json['productName'],
      shippingPointName: json['shippingPointName'],
      quantity: json['quantity'].toDouble(),
      userEmail: json['userEmail'],
      userId: json['userId'],
      yearMonth: json['yearMonth'],
      collaborationEndDate: DateTime.parse(json['collaborationEndDate']),
      id: json['id'],
      demandType: json['demandType'],
      demandTypeId: json['demandTypeId'],
      eventType: json['eventType'],
      eventTypeId: json['eventTypeId'],
      product: json['product'],
      productId: json['productId'],
      shippingPoint: json['shippingPoint'],
      shippingPointId: json['shippingPointId'],
      status: json['status'],
      statusId: json['statusId'],
      collaborativeDemandComponentsDetails: json['collaborativeDemandComponentsDetails'],
      collaborativeDemandComponentsDetailsDTO: json['collaborativeDemandComponentsDetailsDTO'],
      userCollaborativeDemands: json['userCollaborativeDemands'],
      collaborativeDemandUsers: json['collaborativeDemandUsers'],
      collaborativeDemandUsersNumber: json['collaborativeDemandUsersNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'collaborativeDemandId': collaborativeDemandId,
      'collaborativeDemandDetailId': collaborativeDemandDetailId,
      'customerCode': customerCode,
      'customerName': customerName,
      'cityName': cityName,
      'distributionChannel': distributionChannel,
      'productCode': productCode,
      'productName': productName,
      'shippingPointName': shippingPointName,
      'quantity': quantity,
      'userEmail': userEmail,
      'userId': userId,
      'yearMonth': yearMonth,
      'collaborationEndDate': collaborationEndDate.toIso8601String(),
      'id': id,
      'demandType': demandType,
      'demandTypeId': demandTypeId,
      'eventType': eventType,
      'eventTypeId': eventTypeId,
      'product': product,
      'productId': productId,
      'shippingPoint': shippingPoint,
      'shippingPointId': shippingPointId,
      'status': status,
      'statusId': statusId,
      'collaborativeDemandComponentsDetails': collaborativeDemandComponentsDetails,
      'collaborativeDemandComponentsDetailsDTO': collaborativeDemandComponentsDetailsDTO,
      'userCollaborativeDemands': userCollaborativeDemands,
      'collaborativeDemandUsers': collaborativeDemandUsers,
      'collaborativeDemandUsersNumber': collaborativeDemandUsersNumber,
    };
  }
}
