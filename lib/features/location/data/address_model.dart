class AddressModel {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String state;
  final String city;
  final String street;
  final String landmark;
  final String category;

  AddressModel({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.state,
    required this.city,
    required this.street,
    required this.landmark,
    required this.category,
  });

  @override
  String toString() {
    return 'AddressModel(firstName: $firstName, lastName: $lastName, phone: $phone, email: $email, state: $state, city: $city, street: $street, landmark: $landmark, category: $category)';
  }
}

