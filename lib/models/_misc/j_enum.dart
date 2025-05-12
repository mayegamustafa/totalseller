import 'package:collection/collection.dart';
import 'package:seller_management/_core/_core.dart';

class JEnum {
  JEnum({required this.enumData});

  factory JEnum.fromMap(Map<String, dynamic> map) {
    final data = map..forEach((key, value) => map[key] = map.parseInt(key));

    return JEnum(enumData: Map<String, int>.from(data));
  }

  final Map<String, int> enumData;

  /// Gets the value of the enum from the enum code
  String operator [](int code) {
    return enumData.entries.firstWhereOrNull((e) => e.value == code)?.key ??
        'Unknown';
  }
}
