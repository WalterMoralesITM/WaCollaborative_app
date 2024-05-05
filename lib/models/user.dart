class User {
  String document;
  String firstName;
  String lastName;
  String address;
  String photo;
  int userType;
  City city;
  int cityId;
  String fullName;
  int? internalRoleId; // Puede ser nulo
  dynamic portfolioId;
  String id;
  String userName;
  String normalizedUserName;
  String email;
  String normalizedEmail;
  String phoneNumber;
  bool phoneNumberConfirmed;

  User({
    required this.document,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.photo,
    required this.userType,
    required this.city,
    required this.cityId,
    required this.fullName,
    this.internalRoleId,
    required this.portfolioId,
    required this.id,
    required this.userName,
    required this.normalizedUserName,
    required this.email,
    required this.normalizedEmail,
    required this.phoneNumber,
    required this.phoneNumberConfirmed,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      document: json['document'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      address: json['address'],
      photo: json['photo'],
      userType: json['userType'],
      city: City.fromJson(json['city']),
      cityId: json['cityId'],
      fullName: json['fullName'],
      internalRoleId: json['internalRoleId'],
      portfolioId: json['portfolioId'],
      id: json['id'],
      userName: json['userName'],
      normalizedUserName: json['normalizedUserName'],
      email: json['email'],
      normalizedEmail: json['normalizedEmail'],
      phoneNumber: json['phoneNumber'],
      phoneNumberConfirmed: json['phoneNumberConfirmed'],
    );
  }

}

class City {
  int id;
  String name;
  int stateUserId;
  StateUser stateUser;

  City({
    required this.id,
    required this.name,
    required this.stateUserId,
    required this.stateUser,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      stateUserId: json['stateId'],
      stateUser: StateUser.fromJson(json['state']),
    );
  }
}

class StateUser {
  int id;
  String name;
  int countryId;
  Country country;

  StateUser({
    required this.id,
    required this.name,
    required this.countryId,
    required this.country,
  });

  factory StateUser.fromJson(Map<String, dynamic> json) {
    return StateUser(
      id: json['id'],
      name: json['name'],
      countryId: json['countryId'],
      country: Country.fromJson(json['country']),
    );
  }
}

class Country {
  int id;
  String name;
  List<dynamic>? states; // Puede ser nulo
  int statesNumber;

  Country({
    required this.id,
    required this.name,
    required this.states,
    required this.statesNumber,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
      states: json['states'],
      statesNumber: json['statesNumber'],
    );
  }
}
