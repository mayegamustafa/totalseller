import 'package:flutter/material.dart';
import 'package:seller_management/main.export.dart';

class PaymentMethod {
  const PaymentMethod({
    required this.id,
    required this.percentCharge,
    required this.currency,
    required this.rate,
    required this.name,
    required this.uniqueCode,
    required this.parameters,
    required this.isManual,
    required this.image,
    required this.callbackUrl,
    required this.customParameters,
  });

  final int id;
  final num percentCharge;
  final Currency currency;
  final num rate;
  final String name;
  final String? uniqueCode;
  final QMap parameters;
  final List<CustomPayField> customParameters;
  final bool isManual;
  final String image;
  final String callbackUrl;

  String get currencyRate =>
      currency.rate.formate(useSymbol: false, currency: currency);

  factory PaymentMethod.fromMap(Map<String, dynamic> map) {
    final manual = map.parseBool('is_manual');
    return PaymentMethod(
      id: map.parseInt('id'),
      percentCharge: map.parseNum('percent_charge'),
      currency: Currency.fromMap(map['currency']),
      rate: map.parseNum('rate'),
      name: map['name'] ?? '',
      uniqueCode: map['unique_code'],
      isManual: manual,
      image: map['image'] ?? '',
      callbackUrl: map['callback_url'] ?? '',
      parameters: manual ? {} : map['payment_parameter'],
      customParameters: map['payment_parameter'] is List
          ? List<CustomPayField>.from(
              map['payment_parameter'].map((e) => CustomPayField.fromMap(e)))
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'percent_charge': percentCharge,
      'currency': currency.toMap(),
      'rate': rate,
      'name': name,
      'unique_code': uniqueCode,
      'payment_parameter': parameters.isEmpty
          ? customParameters.map((e) => e.toMap()).toList()
          : parameters,
      'is_manual': isManual,
      'image': image,
      'callback_url': callbackUrl,
    };
  }
}

class CustomPayField {
  const CustomPayField({
    required this.name,
    required this.typeString,
    required this.isRequired,
  });

  final String name;
  final String typeString;
  final bool isRequired;

  KPayFieldType get type => KPayFieldType.fromValue(typeString);

  factory CustomPayField.fromMap(Map<String, dynamic> map) {
    return CustomPayField(
      name: map['name'] ?? '',
      typeString: map['type'] ?? '',
      isRequired: map.parseBool('is_required'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': typeString,
      'is_required': isRequired,
    };
  }
}

enum KPayFieldType {
  text,
  textarea,
  email,
  date;

  factory KPayFieldType.fromValue(String value) {
    return switch (value) {
      'text' => KPayFieldType.text,
      'textarea' => KPayFieldType.textarea,
      'email' => KPayFieldType.email,
      'date' => KPayFieldType.date,
      _ => KPayFieldType.text,
    };
  }

  TextInputType get keyboardType => switch (this) {
        KPayFieldType.text => TextInputType.text,
        KPayFieldType.textarea => TextInputType.multiline,
        KPayFieldType.email => TextInputType.emailAddress,
        KPayFieldType.date => TextInputType.datetime,
      };

  bool get isText => this == KPayFieldType.text;
  bool get isTextArea => this == KPayFieldType.textarea;
  bool get isEmail => this == KPayFieldType.email;
  bool get isDate => this == KPayFieldType.date;
}
