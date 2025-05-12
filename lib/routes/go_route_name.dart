import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteNames {
  const RouteNames._();
  static const RouteName onboard = RouteName('/onboarding');
  static const RouteName shopNotActive = RouteName('/not_active');
  static const RouteName login = RouteName('/login');

  static const RouteName splash = RouteName('/splash');
  static const RouteName error = RouteName('/oops');
  static const RouteName notFound = RouteName('/404');

  /// query param 'status' : 's', 'w' or 'f'
  static const RouteName afterPayment = RouteName('/after-payment');

  // static const RouteName noKyc = RouteName('/no_kyc');
  static const RouteName verifyKyc = RouteName('/verify_kyc');
  static const RouteName kycLog = RouteName('kyc_log');
  static const RouteName kycLogs = RouteName('kyc_logs');

  static const RouteName maintenance = RouteName('/maintenance');
  static const RouteName invalidPurchase = RouteName('/invalid_purchase');
  static const RouteName panelNotActive = RouteName('/panel-not-active');
  static const RouteName noSUbscription = RouteName('/no-subscription');
  static const RouteName sellerBanned = RouteName('/seller-banned');

  static const RouteName home = RouteName('/home');
  static const RouteName tools = RouteName('/tools');

  static const RouteName data = RouteName('/data');
  static const RouteName messages = RouteName('/massages');
  static const RouteName profile = RouteName('/profile');
  static const RouteName order = RouteName('/order');
  static const RouteName product = RouteName('/product');

  //SUB ROUTE
  static const RouteName signUp = RouteName('sign-up');
  static const RouteName addProduct = RouteName('add-product');
  static const RouteName updatePass = RouteName('update-pass');
  static const RouteName productDetails = RouteName('product-details/:id');
  static const RouteName addDigitalProduct = RouteName('add-digital-product');
  // static const RouteName voucher = RouteName('voucher');
  static const RouteName orderDetails = RouteName('order-details/:id');
  static const RouteName tickets = RouteName('tickets');
  static const RouteName ticket = RouteName('ticket/:id');
  static const RouteName customerChats = RouteName('customer/chats');
  static const RouteName customerChat = RouteName('chat/:id');
  static const RouteName withdraw = RouteName('withdraw');
  static const RouteName withdrawNow = RouteName('withdraw-now');
  static const RouteName totalBalance = RouteName('total-balance');
  static const RouteName accountSettings = RouteName('account-settings');
  // static const RouteName changeAccount = RouteName('change-account');
  static const RouteName storeInformation = RouteName('store-information');
  static const RouteName subscription = RouteName('subscription');
  static const RouteName planUpdate = RouteName('plan-update');
  static const RouteName campaign = RouteName('campaign');
  static const RouteName editCampaign = RouteName('edit-campaign');
  static const RouteName dashLoading = RouteName('dash-loading');
  static const RouteName createTicket = RouteName('create-ticket');
  static const RouteName passwordReset = RouteName('password-reset');
  static const RouteName otpScreen = RouteName('otp-screen');
  static const RouteName newPassword = RouteName('new-password');
  static const RouteName language = RouteName('language');
  static const RouteName currency = RouteName('currency');
  static const RouteName deposit = RouteName('deposit');
  static const RouteName depositPayment = RouteName('payment');

  static const List<RouteName> nestedRoutes = [
    home,
    order,
    product,
    messages,
    profile
  ];
}

class RouteName {
  const RouteName(this.path, {String? name}) : _name = name;

  final String path;
  final String? _name;

  RouteName addQuery(Map<String, String> query) {
    final encoded = {
      for (final q in query.entries) q.key: Uri.encodeComponent(q.value)
    };

    final pathWithQuery = Uri(path: path, queryParameters: encoded).toString();
    return RouteName(pathWithQuery, name: _name);
  }

  String get name => _name ?? path.replaceFirst('/', '').replaceAll('/', '_');

  Future<T?> push<T extends Object?>(BuildContext context, {Object? extra}) =>
      context.push(path, extra: extra);

  Future<T?> pushNamed<T extends Object?>(
    BuildContext context, {
    Map<String, String> pathParams = const <String, String>{},
    Map<String, String> query = const <String, String>{},
    Object? extra,
  }) {
    return context.pushNamed(
      name,
      extra: extra,
      pathParameters: pathParams,
      queryParameters: query,
    );
  }

  void go(BuildContext context, {Object? extra}) =>
      context.go(path, extra: extra);

  void goNamed(
    BuildContext context, {
    Map<String, String> pathParams = const <String, String>{},
    Map<String, String> query = const <String, String>{},
    Object? extra,
  }) =>
      context.goNamed(
        name,
        pathParameters: pathParams,
        queryParameters: query,
        extra: extra,
      );
}
