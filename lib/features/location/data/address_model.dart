class AddressModel {
  final int id;
  final String fullName;
  final String phone;
  final String email;
  final String state;
  final String city;
  final String area;
  final String? landmark;


  AddressModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.state,
    required this.city,
    required this.area,
   required this.landmark,
    
  });

  @override
  String toString() {
    return 'AddressModel(id: $id,firstName: $fullName, phone: $phone, email: $email, state: $state, city: $city, area: $area, landmark: $landmark,)';
  }
}

