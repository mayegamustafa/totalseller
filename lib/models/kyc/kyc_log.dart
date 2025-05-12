import 'package:flutter/material.dart';
import 'package:seller_management/main.export.dart';

class KYCLog {
  const KYCLog({
    required this.id,
    required this.readableTime,
    required this.date,
    required this.status,
    required this.kyc,
    required this.feedback,
  });

  final String date;
  final int id;
  final KYCData kyc;
  final String readableTime;
  final String? feedback;
  final int status;

  factory KYCLog.fromMap(Map<String, dynamic> map) {
    return KYCLog(
      id: map.parseInt('id'),
      readableTime: map['human_readable_time'],
      date: map['date_time'],
      status: map.parseInt('status'),
      kyc: KYCData.fromMap(map['kyc_data']),
      feedback: map['feedback'],
    );
  }

  (String, Color) get statusConfig => switch (status) {
        1 => ('APPROVED', Colors.green),
        2 => ('REQUESTED', Colors.blue),
        3 => ('HOLD', Colors.orange),
        4 => ('REJECTED', Colors.red),
        _ => ('N/A', Colors.red),
      };
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'readable_time': readableTime,
      'date_time': date,
      'status': status,
      'kyc_data': kyc.toMap(),
      'feedback': feedback,
    };
  }
}

class KYCData {
  const KYCData({
    required this.data,
    required this.files,
  });
  final QMap data;
  final QMap files;

  factory KYCData.fromMap(Map<String, dynamic> map) {
    final data = <String, String>{};
    map.forEach((key, value) {
      if (key != 'files') data[key] = value.toString();
    });

    return KYCData(data: data, files: map['files'] ?? {});
  }

  Map<String, dynamic> toMap() {
    return {...data, 'files': files};
  }
}
