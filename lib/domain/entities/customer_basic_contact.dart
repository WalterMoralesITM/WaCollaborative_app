class CustomerBasicContact {
  late String name;
  late String address;
  late String email;
  late String numberPhone;

  CustomerBasicContact({
    required this.name,
    required this.address,
    required this.email,
    required this.numberPhone,
  });


  List<CustomerBasicContact> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => CustomerBasicContact.fromJson(json)).toList();
  }

  CustomerBasicContact.fromJson(Map<String, dynamic> json) {
    name = json['name'] ;
    address = json['address'];
    email = json['email'] ;
    numberPhone = json['numberPhone'] ;
  }

}