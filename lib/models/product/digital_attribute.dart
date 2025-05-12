import 'package:seller_management/main.export.dart';

class DigitalAttribute {
  DigitalAttribute({
    required this.id,
    required this.uid,
    required this.name,
    required this.status,
    required this.price,
    required this.shortDetails,
    required this.values,
    required this.createdAt,
  });

  factory DigitalAttribute.fromMap(Map<String, dynamic> map) {
    return DigitalAttribute(
      id: map.parseInt('id'),
      uid: map['uid'],
      name: map['name'] ?? '',
      status: map['status'] ?? '',
      price: map.parseInt('price'),
      shortDetails: map['short_details'] ?? '',
      values: List<DigitalAttributeValue>.from(
        map['values']?['data']?.map((e) => DigitalAttributeValue.fromMap(e)) ??
            [],
      ),
      createdAt: map['created_at'] ?? '',
    );
  }

  final String createdAt;
  final int id;
  final String name;
  final int price;
  final String shortDetails;
  final String status;
  final String uid;
  final List<DigitalAttributeValue> values;

  bool get isActive => status.toLowerCase() == 'active';

  static List<DigitalAttribute> mapToList(Map<String, dynamic> map) {
    final data = map['digital_attributes']?['data'];
    if (data == null) return [];
    return List<DigitalAttribute>.from(
      data?.map((e) => DigitalAttribute.fromMap(e)),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'name': name,
      'status': status,
      'price': price,
      'short_details': shortDetails,
      'values': values.map((e) => e.toMap()).toList(),
      'created_at': createdAt
    };
  }
}

class DigitalAttributeValue {
  DigitalAttributeValue({
    required this.id,
    required this.uid,
    required this.value,
    required this.createdAt,
    required this.status,
    required this.name,
    required this.statusKey,
    required this.file,
  });

  factory DigitalAttributeValue.fromMap(Map<String, dynamic> map) {
    return DigitalAttributeValue(
      id: map.parseInt('id'),
      uid: map['uid'] ?? '',
      value: map['value'] ?? '',
      createdAt: map['created_at'] ?? '',
      status: map['status'] ?? '',
      name: map['name'] ?? '',
      statusKey: map.parseInt('status_key'),
      file: map['file'],
    );
  }

  final String createdAt;
  final String? file;
  final int id;
  final String name;
  final String status;
  final int statusKey;
  final String uid;
  final String value;

  bool get isActive => statusKey == 1;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'uid': uid});
    result.addAll({'value': value});
    result.addAll({'created_at': createdAt});
    result.addAll({'status': status});
    result.addAll({'name': name});
    result.addAll({'status_key': statusKey});
    result.addAll({'file': file});

    return result;
  }
}
