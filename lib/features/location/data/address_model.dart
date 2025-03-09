class AddressModel {
  final String fullName;

  final String phone;
  final String email;
  final String state;
  final String city;
  final String street;
  final String landmark;


  AddressModel({
    required this.fullName,
    required this.phone,
    required this.email,
    required this.state,
    required this.city,
    required this.street,
    required this.landmark,
    
  });

  @override
  String toString() {
    return 'AddressModel(firstName: $fullName, phone: $phone, email: $email, state: $state, city: $city, street: $street, landmark: $landmark,)';
  }
}

