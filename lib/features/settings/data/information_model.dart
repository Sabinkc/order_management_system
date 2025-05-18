class FaqModel {
  final String id;
  final String title;
  final String description;

  FaqModel({
    required this.id,
    required this.title,
    required this.description,
  });

  @override
  String toString() {
    return 'FaqModel(id: $id, title: $title, description: $description)';
  }
}

class PrivacyPolicyModel {
  final String id;
  final String title;
  final String description;

  PrivacyPolicyModel({
    required this.id,
    required this.title,
    required this.description,
  });

  @override
  String toString() {
    return 'PrivacyPolicyModel(id: $id, title: $title, description: $description)';
  }
}

class TermsOfConditionModel {
  final String id;
  final String title;
  final String description;

  TermsOfConditionModel({
    required this.id,
    required this.title,
    required this.description,
  });

  @override
  String toString() {
    return 'PrivacyPolicyModel(id: $id, title: $title, description: $description)';
  }
}

class ContactAndSupportModel {
  final String field;
  final String value;
  final String type;

  ContactAndSupportModel({
    required this.field,
    required this.value,
    required this.type,
  });

  @override
  String toString() {
    return 'PrivacyPolicyModel(field: $field, value: $value, type: $type)';
  }
}
