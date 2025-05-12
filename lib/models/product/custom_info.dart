import 'package:seller_management/main.export.dart';

class CustomInfo {
  const CustomInfo({
    required this.name,
    required this.type,
    required this.options,
    required this.isRequired,
    required this.id,
    required this.label,
  });

  final String name;
  final String label;
  final KFieldType type;
  final String? options;
  final bool isRequired;
  final String id;

  factory CustomInfo.fromMap(Map<String, dynamic> map, [String? id]) {
    return CustomInfo(
      name: map['data_name'] ?? '',
      isRequired: map.parseBool('data_required'),
      type: KFieldType.fromValue(map['type']),
      options: map['data_value'],
      id: id ?? map['data_name'] ?? '',
      label: map['data_label'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data_name': name,
      'data_required': isRequired ? '1' : '0',
      'type': type.name,
      'data_value': options,
      'data_label': label,
    };
  }
}

enum KFieldType {
  text,
  textarea,
  number,
  select;

  factory KFieldType.fromValue(String value) {
    return switch (value) {
      'textarea' => textarea,
      'number' => number,
      'select' => select,
      _ => text
    };
  }
}
