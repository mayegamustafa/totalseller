import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:seller_management/_core/_core.dart';

class KYCConfig {
  const KYCConfig({
    required this.labels,
    required this.placeholder,
    required this.name,
    required this.typeStr,
    required this.isRequired,
  });

  final String labels;
  final String placeholder;
  final String name;
  final String typeStr;
  final bool isRequired;

  KYCType get type => KYCType.fromValue(typeStr);

  factory KYCConfig.fromMap(Map<String, dynamic> map) {
    return KYCConfig(
      labels: map['labels'],
      placeholder: map['placeholder'],
      name: map['name'],
      typeStr: map['type'],
      isRequired: map.parseBool('required'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'labels': labels,
      'placeholder': placeholder,
      'name': name,
      'type': typeStr,
      'required': isRequired,
    };
  }
}

enum KYCType {
  text,
  email,
  date,
  textarea,
  file;

  factory KYCType.fromValue(String value) {
    return switch (value) {
      'email' => email,
      'date' => date,
      'textarea' => textarea,
      'file' => file,
      _ => text
    };
  }

  ({TextInputType type, TextInputAction action}) get input {
    switch (this) {
      case KYCType.email:
        return (type: TextInputType.emailAddress, action: TextInputAction.next);
      case KYCType.date:
        return (type: TextInputType.datetime, action: TextInputAction.next);
      case KYCType.textarea:
        return (type: TextInputType.multiline, action: TextInputAction.newline);
      default:
        return (type: TextInputType.text, action: TextInputAction.next);
    }
  }

  int get maxLines => switch (this) { KYCType.textarea => 3, _ => 1 };

  bool get readOnly =>
      switch (this) { KYCType.date => true, KYCType.file => true, _ => false };

  String? Function(String?) validator() {
    switch (this) {
      case KYCType.email:
        return FormBuilderValidators.email();
      default:
        return (_) => null;
    }
  }
}
