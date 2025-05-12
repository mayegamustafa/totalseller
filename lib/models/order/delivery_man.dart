import 'package:seller_management/main.export.dart';

class DeliveryMan {
  DeliveryMan({
    required this.id,
    required this.fcmToken,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.phone,
    required this.phoneCode,
    required this.countryId,
    required this.balance,
    required this.orderBalance,
    required this.isBanned,
    required this.image,
    required this.address,
    required this.isKycVerified,
    required this.isOnline,
    required this.enablePushNotification,
    required this.lastLoginTime,
  });

  factory DeliveryMan.fromMap(Map<String, dynamic> map) {
    return DeliveryMan(
      id: map.parseInt('id'),
      fcmToken: map['fcm_token'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      phone: map['phone'] ?? '',
      phoneCode: map['phone_code'] ?? '',
      countryId: map.parseInt('country_id'),
      balance: map['balance'] ?? 0,
      orderBalance: map.parseNum('order_balance'),
      isBanned: map['is_banned'] ?? false,
      image: map['image'] ?? '',
      address: Address.fromMap(map['address']),
      isKycVerified: map['is_kyc_verified'] ?? false,
      isOnline: map['is_online'] ?? false,
      enablePushNotification: map['enable_push_notification'] ?? false,
      lastLoginTime: map['last_login_time'] ?? '',
    );
  }

  final Address address;
  final num balance;
  final int countryId;
  final String email;
  final bool enablePushNotification;
  final String fcmToken;
  final String firstName;
  final int id;
  final String image;
  final bool isBanned;
  final bool isKycVerified;
  final bool isOnline;
  final String lastLoginTime;
  final String lastName;
  final num orderBalance;
  final String phone;
  final String phoneCode;
  final String username;

  String get fullName => switch ((firstName, lastName)) {
        (String f, String l) when f.isNotEmpty && l.isNotEmpty => '$f $l',
        (String f, String l) when f.isNotEmpty && l.isEmpty => f,
        (String f, String l) when f.isEmpty && l.isNotEmpty => l,
        _ => username,
      };

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fcm_token': fcmToken,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'username': username,
      'phone': phone,
      'phone_code': phoneCode,
      'country_id': countryId,
      'balance': balance,
      'order_balance': orderBalance,
      'is_banned': isBanned,
      'image': image,
      'address': address.toMap(),
      'is_kyc_verified': isKycVerified,
      'is_online': isOnline,
      'enable_push_notification': enablePushNotification,
      'last_login_time': lastLoginTime,
    };
  }
}

class Address {
  Address({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      latitude: map.parseDouble('latitude'),
      longitude: map.parseDouble('longitude'),
      address: map['address'] ?? '',
    );
  }

  final String address;
  final double latitude;
  final double longitude;

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }
}
