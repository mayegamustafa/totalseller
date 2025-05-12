// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class TR {
  TR();

  static TR? _current;

  static TR get current {
    assert(_current != null,
        'No instance of TR was loaded. Try to initialize the TR delegate before accessing TR.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<TR> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = TR();
      TR._current = instance;

      return instance;
    });
  }

  static TR of(BuildContext context) {
    final instance = TR.maybeOf(context);
    assert(instance != null,
        'No instance of TR present in the widget tree. Did you add TR.delegate in localizationsDelegates?');
    return instance!;
  }

  static TR? maybeOf(BuildContext context) {
    return Localizations.of<TR>(context, TR);
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Seller Center`
  String get seller_center {
    return Intl.message(
      'Seller Center',
      name: 'seller_center',
      desc: '',
      args: [],
    );
  }

  /// `Product`
  String get Product {
    return Intl.message(
      'Product',
      name: 'Product',
      desc: '',
      args: [],
    );
  }

  /// `Add Product`
  String get add_product {
    return Intl.message(
      'Add Product',
      name: 'add_product',
      desc: '',
      args: [],
    );
  }

  /// `Diversify Your Inventory, Elevate Your Store!`
  String get add_product_title {
    return Intl.message(
      'Diversify Your Inventory, Elevate Your Store!',
      name: 'add_product_title',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Order Overview`
  String get monthly_order_overview {
    return Intl.message(
      'Monthly Order Overview',
      name: 'monthly_order_overview',
      desc: '',
      args: [],
    );
  }

  /// `All Order Overview`
  String get all_order_overview {
    return Intl.message(
      'All Order Overview',
      name: 'all_order_overview',
      desc: '',
      args: [],
    );
  }

  /// `All Transaction Log`
  String get all_transaction_log {
    return Intl.message(
      'All Transaction Log',
      name: 'all_transaction_log',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Deposit`
  String get deposit {
    return Intl.message(
      'Deposit',
      name: 'deposit',
      desc: '',
      args: [],
    );
  }

  /// `Transaction id`
  String get transId {
    return Intl.message(
      'Transaction id',
      name: 'transId',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Ongoing Campaign`
  String get ongoing_campaign {
    return Intl.message(
      'Ongoing Campaign',
      name: 'ongoing_campaign',
      desc: '',
      args: [],
    );
  }

  /// `Store Performance`
  String get store_performance {
    return Intl.message(
      'Store Performance',
      name: 'store_performance',
      desc: '',
      args: [],
    );
  }

  /// `Manage Order`
  String get manage_order {
    return Intl.message(
      'Manage Order',
      name: 'manage_order',
      desc: '',
      args: [],
    );
  }

  /// `Physical Order`
  String get physical_order {
    return Intl.message(
      'Physical Order',
      name: 'physical_order',
      desc: '',
      args: [],
    );
  }

  /// `Digital Order`
  String get digital_order {
    return Intl.message(
      'Digital Order',
      name: 'digital_order',
      desc: '',
      args: [],
    );
  }

  /// `All Order`
  String get all_order {
    return Intl.message(
      'All Order',
      name: 'all_order',
      desc: '',
      args: [],
    );
  }

  /// `Placed`
  String get placed {
    return Intl.message(
      'Placed',
      name: 'placed',
      desc: '',
      args: [],
    );
  }

  /// `Confirmed`
  String get confirmed {
    return Intl.message(
      'Confirmed',
      name: 'confirmed',
      desc: '',
      args: [],
    );
  }

  /// `Processing`
  String get processing {
    return Intl.message(
      'Processing',
      name: 'processing',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get delivered {
    return Intl.message(
      'Delivered',
      name: 'delivered',
      desc: '',
      args: [],
    );
  }

  /// `Manage Product`
  String get manage_product {
    return Intl.message(
      'Manage Product',
      name: 'manage_product',
      desc: '',
      args: [],
    );
  }

  /// `In-house Product`
  String get in_house_product {
    return Intl.message(
      'In-house Product',
      name: 'in_house_product',
      desc: '',
      args: [],
    );
  }

  /// `All Product`
  String get all_product {
    return Intl.message(
      'All Product',
      name: 'all_product',
      desc: '',
      args: [],
    );
  }

  /// `Trashed Product`
  String get trashed_product {
    return Intl.message(
      'Trashed Product',
      name: 'trashed_product',
      desc: '',
      args: [],
    );
  }

  /// `Refuse Product`
  String get refuse_product {
    return Intl.message(
      'Refuse Product',
      name: 'refuse_product',
      desc: '',
      args: [],
    );
  }

  /// `Approved Product`
  String get approved_product {
    return Intl.message(
      'Approved Product',
      name: 'approved_product',
      desc: '',
      args: [],
    );
  }

  /// `New Product`
  String get new_product {
    return Intl.message(
      'New Product',
      name: 'new_product',
      desc: '',
      args: [],
    );
  }

  /// `Massage`
  String get massage {
    return Intl.message(
      'Massage',
      name: 'massage',
      desc: '',
      args: [],
    );
  }

  /// `Create Ticket`
  String get create_ticket {
    return Intl.message(
      'Create Ticket',
      name: 'create_ticket',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Seller Profile`
  String get seller_profile {
    return Intl.message(
      'Seller Profile',
      name: 'seller_profile',
      desc: '',
      args: [],
    );
  }

  /// `Store Information`
  String get store_info {
    return Intl.message(
      'Store Information',
      name: 'store_info',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw`
  String get withdraw {
    return Intl.message(
      'Withdraw',
      name: 'withdraw',
      desc: '',
      args: [],
    );
  }

  /// `Subscription Plan`
  String get subscription_plan {
    return Intl.message(
      'Subscription Plan',
      name: 'subscription_plan',
      desc: '',
      args: [],
    );
  }

  /// `Account Settlement`
  String get account_settlement {
    return Intl.message(
      'Account Settlement',
      name: 'account_settlement',
      desc: '',
      args: [],
    );
  }

  /// `Ticket`
  String get ticket {
    return Intl.message(
      'Ticket',
      name: 'ticket',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Currency`
  String get currency {
    return Intl.message(
      'Currency',
      name: 'currency',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get user_name {
    return Intl.message(
      'Username',
      name: 'user_name',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get state {
    return Intl.message(
      'State',
      name: 'state',
      desc: '',
      args: [],
    );
  }

  /// `Zip Code`
  String get zip_code {
    return Intl.message(
      'Zip Code',
      name: 'zip_code',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Shop Logo`
  String get shop_logo {
    return Intl.message(
      'Shop Logo',
      name: 'shop_logo',
      desc: '',
      args: [],
    );
  }

  /// `Site Logo`
  String get site_logo {
    return Intl.message(
      'Site Logo',
      name: 'site_logo',
      desc: '',
      args: [],
    );
  }

  /// `Site Logo Icon`
  String get site_logo_icon {
    return Intl.message(
      'Site Logo Icon',
      name: 'site_logo_icon',
      desc: '',
      args: [],
    );
  }

  /// `Feature Image`
  String get feature_image {
    return Intl.message(
      'Feature Image',
      name: 'feature_image',
      desc: '',
      args: [],
    );
  }

  /// `Store Name`
  String get store_name {
    return Intl.message(
      'Store Name',
      name: 'store_name',
      desc: '',
      args: [],
    );
  }

  /// `Whatsapp Order`
  String get whatsapp_order {
    return Intl.message(
      'Whatsapp Order',
      name: 'whatsapp_order',
      desc: '',
      args: [],
    );
  }

  /// `Whatsapp Number`
  String get whatsapp_number {
    return Intl.message(
      'Whatsapp Number',
      name: 'whatsapp_number',
      desc: '',
      args: [],
    );
  }

  /// `Short Details`
  String get short_details {
    return Intl.message(
      'Short Details',
      name: 'short_details',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw Now`
  String get withdraw_now {
    return Intl.message(
      'Withdraw Now',
      name: 'withdraw_now',
      desc: '',
      args: [],
    );
  }

  /// `All Withdraw List`
  String get all_withdraw {
    return Intl.message(
      'All Withdraw List',
      name: 'all_withdraw',
      desc: '',
      args: [],
    );
  }

  /// `To withdraw your balance, click the 'Withdraw Now' button below`
  String get withdraw_title {
    return Intl.message(
      'To withdraw your balance, click the \'Withdraw Now\' button below',
      name: 'withdraw_title',
      desc: '',
      args: [],
    );
  }

  /// `Receivable`
  String get receivable {
    return Intl.message(
      'Receivable',
      name: 'receivable',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw Method`
  String get withdraw_method {
    return Intl.message(
      'Withdraw Method',
      name: 'withdraw_method',
      desc: '',
      args: [],
    );
  }

  /// `All Withdraw Method`
  String get all_withdraw_method {
    return Intl.message(
      'All Withdraw Method',
      name: 'all_withdraw_method',
      desc: '',
      args: [],
    );
  }

  /// `To get withdrawal information, first select a withdrawal method from the list below.`
  String get withdraw_method_title {
    return Intl.message(
      'To get withdrawal information, first select a withdrawal method from the list below.',
      name: 'withdraw_method_title',
      desc: '',
      args: [],
    );
  }

  /// `Subscription`
  String get subscription {
    return Intl.message(
      'Subscription',
      name: 'subscription',
      desc: '',
      args: [],
    );
  }

  /// `Plan Update`
  String get plan_update {
    return Intl.message(
      'Plan Update',
      name: 'plan_update',
      desc: '',
      args: [],
    );
  }

  /// `Plan`
  String get plan {
    return Intl.message(
      'Plan',
      name: 'plan',
      desc: '',
      args: [],
    );
  }

  /// `Subscription History`
  String get subscription_history {
    return Intl.message(
      'Subscription History',
      name: 'subscription_history',
      desc: '',
      args: [],
    );
  }

  /// `Total Product`
  String get total_product {
    return Intl.message(
      'Total Product',
      name: 'total_product',
      desc: '',
      args: [],
    );
  }

  /// `Expire Date`
  String get expire_date {
    return Intl.message(
      'Expire Date',
      name: 'expire_date',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Renew`
  String get renew {
    return Intl.message(
      'Renew',
      name: 'renew',
      desc: '',
      args: [],
    );
  }

  /// `Total Balance`
  String get total_balance {
    return Intl.message(
      'Total Balance',
      name: 'total_balance',
      desc: '',
      args: [],
    );
  }

  /// `Search by date`
  String get search_by_date {
    return Intl.message(
      'Search by date',
      name: 'search_by_date',
      desc: '',
      args: [],
    );
  }

  /// `Search by TRX ID`
  String get search_by_trx_id {
    return Intl.message(
      'Search by TRX ID',
      name: 'search_by_trx_id',
      desc: '',
      args: [],
    );
  }

  /// `Post Balance`
  String get post_balance {
    return Intl.message(
      'Post Balance',
      name: 'post_balance',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Selected Language`
  String get selected_language {
    return Intl.message(
      'Selected Language',
      name: 'selected_language',
      desc: '',
      args: [],
    );
  }

  /// `Selected Currency`
  String get selected_currency {
    return Intl.message(
      'Selected Currency',
      name: 'selected_currency',
      desc: '',
      args: [],
    );
  }

  /// `All Currency`
  String get all_currency {
    return Intl.message(
      'All Currency',
      name: 'all_currency',
      desc: '',
      args: [],
    );
  }

  /// `ALl Language`
  String get all_language {
    return Intl.message(
      'ALl Language',
      name: 'all_language',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Total Withdraw`
  String get total_withdraw {
    return Intl.message(
      'Total Withdraw',
      name: 'total_withdraw',
      desc: '',
      args: [],
    );
  }

  /// `Physical Product`
  String get physical_product {
    return Intl.message(
      'Physical Product',
      name: 'physical_product',
      desc: '',
      args: [],
    );
  }

  /// `Digital Product`
  String get digital_product {
    return Intl.message(
      'Digital Product',
      name: 'digital_product',
      desc: '',
      args: [],
    );
  }

  /// `Total Order`
  String get total_order {
    return Intl.message(
      'Total Order',
      name: 'total_order',
      desc: '',
      args: [],
    );
  }

  /// `Delivered Order`
  String get delivered_order {
    return Intl.message(
      'Delivered Order',
      name: 'delivered_order',
      desc: '',
      args: [],
    );
  }

  /// `Shipped Orders`
  String get shipped_order {
    return Intl.message(
      'Shipped Orders',
      name: 'shipped_order',
      desc: '',
      args: [],
    );
  }

  /// `Canceled Orders`
  String get canceled_order {
    return Intl.message(
      'Canceled Orders',
      name: 'canceled_order',
      desc: '',
      args: [],
    );
  }

  /// `Total Ticket`
  String get total_ticket {
    return Intl.message(
      'Total Ticket',
      name: 'total_ticket',
      desc: '',
      args: [],
    );
  }

  /// `Support Ticket`
  String get support_ticket {
    return Intl.message(
      'Support Ticket',
      name: 'support_ticket',
      desc: '',
      args: [],
    );
  }

  /// `SUPPORT TICKET CREATE`
  String get support_ticket_create {
    return Intl.message(
      'SUPPORT TICKET CREATE',
      name: 'support_ticket_create',
      desc: '',
      args: [],
    );
  }

  /// `Subject`
  String get subject {
    return Intl.message(
      'Subject',
      name: 'subject',
      desc: '',
      args: [],
    );
  }

  /// `Enter Massage`
  String get enter_massage {
    return Intl.message(
      'Enter Massage',
      name: 'enter_massage',
      desc: '',
      args: [],
    );
  }

  /// `Priority`
  String get priority {
    return Intl.message(
      'Priority',
      name: 'priority',
      desc: '',
      args: [],
    );
  }

  /// `Select Priority`
  String get select_priority {
    return Intl.message(
      'Select Priority',
      name: 'select_priority',
      desc: '',
      args: [],
    );
  }

  /// `Select File`
  String get select_file {
    return Intl.message(
      'Select File',
      name: 'select_file',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Rate`
  String get cancel_rate {
    return Intl.message(
      'Cancel Rate',
      name: 'cancel_rate',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Rate`
  String get delivery_rate {
    return Intl.message(
      'Delivery Rate',
      name: 'delivery_rate',
      desc: '',
      args: [],
    );
  }

  /// `Physical Order Rate`
  String get physical_order_rate {
    return Intl.message(
      'Physical Order Rate',
      name: 'physical_order_rate',
      desc: '',
      args: [],
    );
  }

  /// `Digital Order Rate`
  String get digital_order_rate {
    return Intl.message(
      'Digital Order Rate',
      name: 'digital_order_rate',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Please Sign in to continue`
  String get please_sign_in {
    return Intl.message(
      'Please Sign in to continue',
      name: 'please_sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgot_password {
    return Intl.message(
      'Forgot Password',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Create an Account`
  String get create_an_account {
    return Intl.message(
      'Create an Account',
      name: 'create_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Do not have account`
  String get do_not_have_account {
    return Intl.message(
      'Do not have account',
      name: 'do_not_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get reset_password {
    return Intl.message(
      'Reset Password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Regain Access, Reset Your Password Now`
  String get regain_access {
    return Intl.message(
      'Regain Access, Reset Your Password Now',
      name: 'regain_access',
      desc: '',
      args: [],
    );
  }

  /// `Enter Gmail Account`
  String get enter_gmail_account {
    return Intl.message(
      'Enter Gmail Account',
      name: 'enter_gmail_account',
      desc: '',
      args: [],
    );
  }

  /// `Verify Mail`
  String get verify_mail {
    return Intl.message(
      'Verify Mail',
      name: 'verify_mail',
      desc: '',
      args: [],
    );
  }

  /// `Enter OTP`
  String get enter_otp {
    return Intl.message(
      'Enter OTP',
      name: 'enter_otp',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get create_account {
    return Intl.message(
      'Create Account',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Please fill the input here`
  String get please_fill_the_input {
    return Intl.message(
      'Please fill the input here',
      name: 'please_fill_the_input',
      desc: '',
      args: [],
    );
  }

  /// `Enter Username`
  String get enter_user_name {
    return Intl.message(
      'Enter Username',
      name: 'enter_user_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter Email`
  String get enter_email {
    return Intl.message(
      'Enter Email',
      name: 'enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Enter Password`
  String get enter_password {
    return Intl.message(
      'Enter Password',
      name: 'enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up {
    return Intl.message(
      'Sign Up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Already have a account`
  String get already_have_account {
    return Intl.message(
      'Already have a account',
      name: 'already_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Search via name`
  String get search_via_name {
    return Intl.message(
      'Search via name',
      name: 'search_via_name',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get note {
    return Intl.message(
      'Note',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `Product Title`
  String get product_title {
    return Intl.message(
      'Product Title',
      name: 'product_title',
      desc: '',
      args: [],
    );
  }

  /// `Method`
  String get method {
    return Intl.message(
      'Method',
      name: 'method',
      desc: '',
      args: [],
    );
  }

  /// `Enter Product Title`
  String get enter_product_title {
    return Intl.message(
      'Enter Product Title',
      name: 'enter_product_title',
      desc: '',
      args: [],
    );
  }

  /// `Product Basic Information`
  String get product_basic_info {
    return Intl.message(
      'Product Basic Information',
      name: 'product_basic_info',
      desc: '',
      args: [],
    );
  }

  /// `Add Basic Information`
  String get add_basic_info {
    return Intl.message(
      'Add Basic Information',
      name: 'add_basic_info',
      desc: '',
      args: [],
    );
  }

  /// `Regular Price`
  String get regular_price {
    return Intl.message(
      'Regular Price',
      name: 'regular_price',
      desc: '',
      args: [],
    );
  }

  /// `Product Price`
  String get product_price {
    return Intl.message(
      'Product Price',
      name: 'product_price',
      desc: '',
      args: [],
    );
  }

  /// `Discount Percentage(%)`
  String get discount_percentage {
    return Intl.message(
      'Discount Percentage(%)',
      name: 'discount_percentage',
      desc: '',
      args: [],
    );
  }

  /// `Purchase Quantity (Min)`
  String get purchase_quantity_min {
    return Intl.message(
      'Purchase Quantity (Min)',
      name: 'purchase_quantity_min',
      desc: '',
      args: [],
    );
  }

  /// `Min Qty should be more then 0`
  String get min_qty_should_be {
    return Intl.message(
      'Min Qty should be more then 0',
      name: 'min_qty_should_be',
      desc: '',
      args: [],
    );
  }

  /// `Purchase Quantity (Max)`
  String get purchase_quantity_max {
    return Intl.message(
      'Purchase Quantity (Max)',
      name: 'purchase_quantity_max',
      desc: '',
      args: [],
    );
  }

  /// `Max Qty unlimited number`
  String get max_qty_unlimited {
    return Intl.message(
      'Max Qty unlimited number',
      name: 'max_qty_unlimited',
      desc: '',
      args: [],
    );
  }

  /// `Short Description`
  String get short_description {
    return Intl.message(
      'Short Description',
      name: 'short_description',
      desc: '',
      args: [],
    );
  }

  /// `Product Description`
  String get product_description {
    return Intl.message(
      'Product Description',
      name: 'product_description',
      desc: '',
      args: [],
    );
  }

  /// `Product Gallery`
  String get product_gallery {
    return Intl.message(
      'Product Gallery',
      name: 'product_gallery',
      desc: '',
      args: [],
    );
  }

  /// `Thumbnail Image`
  String get thumbnail_image {
    return Intl.message(
      'Thumbnail Image',
      name: 'thumbnail_image',
      desc: '',
      args: [],
    );
  }

  /// `Gallery Image`
  String get gallery_image {
    return Intl.message(
      'Gallery Image',
      name: 'gallery_image',
      desc: '',
      args: [],
    );
  }

  /// `Upload Your File`
  String get upload_your_file {
    return Intl.message(
      'Upload Your File',
      name: 'upload_your_file',
      desc: '',
      args: [],
    );
  }

  /// `Image Size Should be`
  String get image_size_should_be {
    return Intl.message(
      'Image Size Should be',
      name: 'image_size_should_be',
      desc: '',
      args: [],
    );
  }

  /// `Product Attribute`
  String get product_attribute {
    return Intl.message(
      'Product Attribute',
      name: 'product_attribute',
      desc: '',
      args: [],
    );
  }

  /// `Attribute`
  String get attribute {
    return Intl.message(
      'Attribute',
      name: 'attribute',
      desc: '',
      args: [],
    );
  }

  /// `Select Item`
  String get select_item {
    return Intl.message(
      'Select Item',
      name: 'select_item',
      desc: '',
      args: [],
    );
  }

  /// `Product Categories`
  String get product_categories {
    return Intl.message(
      'Product Categories',
      name: 'product_categories',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Sub Categories`
  String get sub_categories {
    return Intl.message(
      'Sub Categories',
      name: 'sub_categories',
      desc: '',
      args: [],
    );
  }

  /// `Add a Categories First`
  String get add_a_categories_first {
    return Intl.message(
      'Add a Categories First',
      name: 'add_a_categories_first',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Product Brand`
  String get product_brand {
    return Intl.message(
      'Product Brand',
      name: 'product_brand',
      desc: '',
      args: [],
    );
  }

  /// `Brand`
  String get brand {
    return Intl.message(
      'Brand',
      name: 'brand',
      desc: '',
      args: [],
    );
  }

  /// `Product Shipping`
  String get product_shipping {
    return Intl.message(
      'Product Shipping',
      name: 'product_shipping',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Area/Zone/Country`
  String get shipping_area {
    return Intl.message(
      'Shipping Area/Zone/Country',
      name: 'shipping_area',
      desc: '',
      args: [],
    );
  }

  /// `Product Warranty Policy`
  String get product_warranty_policy {
    return Intl.message(
      'Product Warranty Policy',
      name: 'product_warranty_policy',
      desc: '',
      args: [],
    );
  }

  /// `Enter Warranty Policy`
  String get enter_warranty_policy {
    return Intl.message(
      'Enter Warranty Policy',
      name: 'enter_warranty_policy',
      desc: '',
      args: [],
    );
  }

  /// `Add Warranty Policy of Product`
  String get add_warranty_policy {
    return Intl.message(
      'Add Warranty Policy of Product',
      name: 'add_warranty_policy',
      desc: '',
      args: [],
    );
  }

  /// `Meta Data`
  String get meta_data {
    return Intl.message(
      'Meta Data',
      name: 'meta_data',
      desc: '',
      args: [],
    );
  }

  /// `Meta Title`
  String get meta_title {
    return Intl.message(
      'Meta Title',
      name: 'meta_title',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Type Keywords`
  String get type_keywords {
    return Intl.message(
      'Type Keywords',
      name: 'type_keywords',
      desc: '',
      args: [],
    );
  }

  /// `Meta Description`
  String get meta_description {
    return Intl.message(
      'Meta Description',
      name: 'meta_description',
      desc: '',
      args: [],
    );
  }

  /// `Add Physical Product`
  String get add_physical_product {
    return Intl.message(
      'Add Physical Product',
      name: 'add_physical_product',
      desc: '',
      args: [],
    );
  }

  /// `Add Digital Product`
  String get add_digital_product {
    return Intl.message(
      'Add Digital Product',
      name: 'add_digital_product',
      desc: '',
      args: [],
    );
  }

  /// `Enter Product Description`
  String get enter_product_description {
    return Intl.message(
      'Enter Product Description',
      name: 'enter_product_description',
      desc: '',
      args: [],
    );
  }

  /// `Product Stock`
  String get product_stock {
    return Intl.message(
      'Product Stock',
      name: 'product_stock',
      desc: '',
      args: [],
    );
  }

  /// `Add New Attribute`
  String get add_new_attribute {
    return Intl.message(
      'Add New Attribute',
      name: 'add_new_attribute',
      desc: '',
      args: [],
    );
  }

  /// `Attribute Name`
  String get attribute_name {
    return Intl.message(
      'Attribute Name',
      name: 'attribute_name',
      desc: '',
      args: [],
    );
  }

  /// `Attribute Price`
  String get attribute_price {
    return Intl.message(
      'Attribute Price',
      name: 'attribute_price',
      desc: '',
      args: [],
    );
  }

  /// `Update Product`
  String get update_product {
    return Intl.message(
      'Update Product',
      name: 'update_product',
      desc: '',
      args: [],
    );
  }

  /// `Product Details`
  String get product_details {
    return Intl.message(
      'Product Details',
      name: 'product_details',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Placed order`
  String get placed_order {
    return Intl.message(
      'Placed order',
      name: 'placed_order',
      desc: '',
      args: [],
    );
  }

  /// `Digital Product Attribute List`
  String get digital_product_attribute_list {
    return Intl.message(
      'Digital Product Attribute List',
      name: 'digital_product_attribute_list',
      desc: '',
      args: [],
    );
  }

  /// `Add Attribute`
  String get add_attribute {
    return Intl.message(
      'Add Attribute',
      name: 'add_attribute',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Enter Attribute name`
  String get enter_attribute_name {
    return Intl.message(
      'Enter Attribute name',
      name: 'enter_attribute_name',
      desc: '',
      args: [],
    );
  }

  /// `Action`
  String get action {
    return Intl.message(
      'Action',
      name: 'action',
      desc: '',
      args: [],
    );
  }

  /// `Enter Attribute Price`
  String get enter_attribute_price {
    return Intl.message(
      'Enter Attribute Price',
      name: 'enter_attribute_price',
      desc: '',
      args: [],
    );
  }

  /// `Enter Short Description`
  String get enter_short_description {
    return Intl.message(
      'Enter Short Description',
      name: 'enter_short_description',
      desc: '',
      args: [],
    );
  }

  /// `Search via order id, customer name, email`
  String get search_via_order_id_customer_name {
    return Intl.message(
      'Search via order id, customer name, email',
      name: 'search_via_order_id_customer_name',
      desc: '',
      args: [],
    );
  }

  /// `Customer Information`
  String get customer_info {
    return Intl.message(
      'Customer Information',
      name: 'customer_info',
      desc: '',
      args: [],
    );
  }

  /// `Order Placement`
  String get order_placement {
    return Intl.message(
      'Order Placement',
      name: 'order_placement',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get order_details {
    return Intl.message(
      'Order Details',
      name: 'order_details',
      desc: '',
      args: [],
    );
  }

  /// `Street name`
  String get street_name {
    return Intl.message(
      'Street name',
      name: 'street_name',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get payment_method {
    return Intl.message(
      'Payment Method',
      name: 'payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Payment Status`
  String get payment_status {
    return Intl.message(
      'Payment Status',
      name: 'payment_status',
      desc: '',
      args: [],
    );
  }

  /// `Sub Total:`
  String get sub_total {
    return Intl.message(
      'Sub Total:',
      name: 'sub_total',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Charge`
  String get shipping_charge {
    return Intl.message(
      'Shipping Charge',
      name: 'shipping_charge',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Download Invoice`
  String get download_invoice {
    return Intl.message(
      'Download Invoice',
      name: 'download_invoice',
      desc: '',
      args: [],
    );
  }

  /// `Payment Note`
  String get payment_note {
    return Intl.message(
      'Payment Note',
      name: 'payment_note',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Note`
  String get delivery_note {
    return Intl.message(
      'Delivery Note',
      name: 'delivery_note',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Status`
  String get delivery_status {
    return Intl.message(
      'Delivery Status',
      name: 'delivery_status',
      desc: '',
      args: [],
    );
  }

  /// `Write Short Note`
  String get write_short_note {
    return Intl.message(
      'Write Short Note',
      name: 'write_short_note',
      desc: '',
      args: [],
    );
  }

  /// `Upload Product`
  String get upload_product {
    return Intl.message(
      'Upload Product',
      name: 'upload_product',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `No Categories Found`
  String get no_categories_found {
    return Intl.message(
      'No Categories Found',
      name: 'no_categories_found',
      desc: '',
      args: [],
    );
  }

  /// `No Sub Categories Found`
  String get no_sub_categories_found {
    return Intl.message(
      'No Sub Categories Found',
      name: 'no_sub_categories_found',
      desc: '',
      args: [],
    );
  }

  /// `No Brand Found`
  String get no_brand_found {
    return Intl.message(
      'No Brand Found',
      name: 'no_brand_found',
      desc: '',
      args: [],
    );
  }

  /// `No Shipping Delivery Provider Found`
  String get no_shipping_delivery_provider_found {
    return Intl.message(
      'No Shipping Delivery Provider Found',
      name: 'no_shipping_delivery_provider_found',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Update Digital Product`
  String get update_digital_product {
    return Intl.message(
      'Update Digital Product',
      name: 'update_digital_product',
      desc: '',
      args: [],
    );
  }

  /// `Meta Keywords`
  String get meta_keyword {
    return Intl.message(
      'Meta Keywords',
      name: 'meta_keyword',
      desc: '',
      args: [],
    );
  }

  /// `Enter meta title`
  String get enter_meta_title {
    return Intl.message(
      'Enter meta title',
      name: 'enter_meta_title',
      desc: '',
      args: [],
    );
  }

  /// `You do not have any product subscription. Subscribe to add product.`
  String get do_not_have_any_subscription {
    return Intl.message(
      'You do not have any product subscription. Subscribe to add product.',
      name: 'do_not_have_any_subscription',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe Now`
  String get subscribe_now {
    return Intl.message(
      'Subscribe Now',
      name: 'subscribe_now',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Order ID Copied`
  String get order_id_copied {
    return Intl.message(
      'Order ID Copied',
      name: 'order_id_copied',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number Copied`
  String get phone_number_copied {
    return Intl.message(
      'Phone Number Copied',
      name: 'phone_number_copied',
      desc: '',
      args: [],
    );
  }

  /// `Ship and Bill to`
  String get ship_and_bill_to {
    return Intl.message(
      'Ship and Bill to',
      name: 'ship_and_bill_to',
      desc: '',
      args: [],
    );
  }

  /// `Customer Name`
  String get customer_name {
    return Intl.message(
      'Customer Name',
      name: 'customer_name',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Status First`
  String get please_select_status_first {
    return Intl.message(
      'Please Select Status First',
      name: 'please_select_status_first',
      desc: '',
      args: [],
    );
  }

  /// `Stock`
  String get stock {
    return Intl.message(
      'Stock',
      name: 'stock',
      desc: '',
      args: [],
    );
  }

  /// `Out Of Stock`
  String get out_of_stock {
    return Intl.message(
      'Out Of Stock',
      name: 'out_of_stock',
      desc: '',
      args: [],
    );
  }

  /// `This product is currently out of stock`
  String get this_product_out_of_stock {
    return Intl.message(
      'This product is currently out of stock',
      name: 'this_product_out_of_stock',
      desc: '',
      args: [],
    );
  }

  /// `Edit Stock`
  String get edit_stock {
    return Intl.message(
      'Edit Stock',
      name: 'edit_stock',
      desc: '',
      args: [],
    );
  }

  /// `Restore`
  String get restore {
    return Intl.message(
      'Restore',
      name: 'restore',
      desc: '',
      args: [],
    );
  }

  /// `Restore this product?`
  String get restore_this_product {
    return Intl.message(
      'Restore this product?',
      name: 'restore_this_product',
      desc: '',
      args: [],
    );
  }

  /// `You are permanently deleting this product.\n Are you sure?`
  String get you_are_permanently_deleting_product {
    return Intl.message(
      'You are permanently deleting this product.\n Are you sure?',
      name: 'you_are_permanently_deleting_product',
      desc: '',
      args: [],
    );
  }

  /// `Really want to delete this product?`
  String get really_want_to_delete_this_product {
    return Intl.message(
      'Really want to delete this product?',
      name: 'really_want_to_delete_this_product',
      desc: '',
      args: [],
    );
  }

  /// `Really want to delete this Attribute?`
  String get really_want_to_delete_this_attribute {
    return Intl.message(
      'Really want to delete this Attribute?',
      name: 'really_want_to_delete_this_attribute',
      desc: '',
      args: [],
    );
  }

  /// `Enter Subject`
  String get enter_subject {
    return Intl.message(
      'Enter Subject',
      name: 'enter_subject',
      desc: '',
      args: [],
    );
  }

  /// `Write Massage`
  String get write_massage {
    return Intl.message(
      'Write Massage',
      name: 'write_massage',
      desc: '',
      args: [],
    );
  }

  /// `This ticket is closed`
  String get this_ticket_is_closed {
    return Intl.message(
      'This ticket is closed',
      name: 'this_ticket_is_closed',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Name`
  String get enter_your_name {
    return Intl.message(
      'Enter Your Name',
      name: 'enter_your_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get enter_phone_number {
    return Intl.message(
      'Enter your phone number',
      name: 'enter_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Enter Address`
  String get enter_address {
    return Intl.message(
      'Enter Address',
      name: 'enter_address',
      desc: '',
      args: [],
    );
  }

  /// `Enter City`
  String get enter_city {
    return Intl.message(
      'Enter City',
      name: 'enter_city',
      desc: '',
      args: [],
    );
  }

  /// `Enter State`
  String get enter_state {
    return Intl.message(
      'Enter State',
      name: 'enter_state',
      desc: '',
      args: [],
    );
  }

  /// `Enter Zip Code`
  String get enter_zip_code {
    return Intl.message(
      'Enter Zip Code',
      name: 'enter_zip_code',
      desc: '',
      args: [],
    );
  }

  /// `Shop Phone`
  String get shop_phone {
    return Intl.message(
      'Shop Phone',
      name: 'shop_phone',
      desc: '',
      args: [],
    );
  }

  /// `Shop Email`
  String get shop_email {
    return Intl.message(
      'Shop Email',
      name: 'shop_email',
      desc: '',
      args: [],
    );
  }

  /// `Shop Short Description`
  String get shop_short_des {
    return Intl.message(
      'Shop Short Description',
      name: 'shop_short_des',
      desc: '',
      args: [],
    );
  }

  /// `Shop Address`
  String get shop_address {
    return Intl.message(
      'Shop Address',
      name: 'shop_address',
      desc: '',
      args: [],
    );
  }

  /// `The number that you want to receive whatsapp order message (enter number with your country code)`
  String get whatsapp_tooltip {
    return Intl.message(
      'The number that you want to receive whatsapp order message (enter number with your country code)',
      name: 'whatsapp_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Method Details`
  String get method_details {
    return Intl.message(
      'Method Details',
      name: 'method_details',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw Limit`
  String get withdraw_limit {
    return Intl.message(
      'Withdraw Limit',
      name: 'withdraw_limit',
      desc: '',
      args: [],
    );
  }

  /// `Charge`
  String get charge {
    return Intl.message(
      'Charge',
      name: 'charge',
      desc: '',
      args: [],
    );
  }

  /// `Processing Time`
  String get processing_time {
    return Intl.message(
      'Processing Time',
      name: 'processing_time',
      desc: '',
      args: [],
    );
  }

  /// `Enter Amount`
  String get enter_amount {
    return Intl.message(
      'Enter Amount',
      name: 'enter_amount',
      desc: '',
      args: [],
    );
  }

  /// `Amount is too low`
  String get amount_is_too_low {
    return Intl.message(
      'Amount is too low',
      name: 'amount_is_too_low',
      desc: '',
      args: [],
    );
  }

  /// `Amount exceeds max limit`
  String get amount_exceeds_max_limit {
    return Intl.message(
      'Amount exceeds max limit',
      name: 'amount_exceeds_max_limit',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get duration {
    return Intl.message(
      'Duration',
      name: 'duration',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe`
  String get subscribe {
    return Intl.message(
      'Subscribe',
      name: 'subscribe',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get sign_in {
    return Intl.message(
      'Sign In',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get new_password {
    return Intl.message(
      'New Password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter New Password`
  String get enter_new_password {
    return Intl.message(
      'Enter New Password',
      name: 'enter_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter Confirm Password`
  String get enter_confirm_password {
    return Intl.message(
      'Enter Confirm Password',
      name: 'enter_confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade`
  String get upgrade {
    return Intl.message(
      'Upgrade',
      name: 'upgrade',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to`
  String get are_you_want_to {
    return Intl.message(
      'Are you sure you want to',
      name: 'are_you_want_to',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw Information`
  String get withdraw_Info {
    return Intl.message(
      'Withdraw Information',
      name: 'withdraw_Info',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get view_all {
    return Intl.message(
      'View All',
      name: 'view_all',
      desc: '',
      args: [],
    );
  }

  /// `Item`
  String get item {
    return Intl.message(
      'Item',
      name: 'item',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message(
      'or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get exit {
    return Intl.message(
      'Exit',
      name: 'exit',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get previous {
    return Intl.message(
      'Previous',
      name: 'previous',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure ?`
  String get areYouSure {
    return Intl.message(
      'Are you sure ?',
      name: 'areYouSure',
      desc: '',
      args: [],
    );
  }

  /// `Required`
  String get required {
    return Intl.message(
      'Required',
      name: 'required',
      desc: '',
      args: [],
    );
  }

  /// `Add Custom Data`
  String get addCustomData {
    return Intl.message(
      'Add Custom Data',
      name: 'addCustomData',
      desc: '',
      args: [],
    );
  }

  /// `Added`
  String get added {
    return Intl.message(
      'Added',
      name: 'added',
      desc: '',
      args: [],
    );
  }

  /// `Field name{data}`
  String fieldName(Object data) {
    return Intl.message(
      'Field name$data',
      name: 'fieldName',
      desc: '',
      args: [data],
    );
  }

  /// `Field label{data}`
  String fieldLabel(Object data) {
    return Intl.message(
      'Field label$data',
      name: 'fieldLabel',
      desc: '',
      args: [data],
    );
  }

  /// `Field type{data}`
  String fieldType(Object data) {
    return Intl.message(
      'Field type$data',
      name: 'fieldType',
      desc: '',
      args: [data],
    );
  }

  /// `Required field{data}`
  String requiredField(Object data) {
    return Intl.message(
      'Required field$data',
      name: 'requiredField',
      desc: '',
      args: [data],
    );
  }

  /// `Field options{data}`
  String field_options(Object data) {
    return Intl.message(
      'Field options$data',
      name: 'field_options',
      desc: '',
      args: [data],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get currentPassword {
    return Intl.message(
      'Current Password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Campaign`
  String get campaign {
    return Intl.message(
      'Campaign',
      name: 'campaign',
      desc: '',
      args: [],
    );
  }

  /// `Deposit Method`
  String get depositMethod {
    return Intl.message(
      'Deposit Method',
      name: 'depositMethod',
      desc: '',
      args: [],
    );
  }

  /// `KYC Logs`
  String get kycLogs {
    return Intl.message(
      'KYC Logs',
      name: 'kycLogs',
      desc: '',
      args: [],
    );
  }

  /// `KYC Details`
  String get kycDetails {
    return Intl.message(
      'KYC Details',
      name: 'kycDetails',
      desc: '',
      args: [],
    );
  }

  /// `Go to Home`
  String get goToHome {
    return Intl.message(
      'Go to Home',
      name: 'goToHome',
      desc: '',
      args: [],
    );
  }

  /// `KYC VERIFICATION`
  String get kycVerification {
    return Intl.message(
      'KYC VERIFICATION',
      name: 'kycVerification',
      desc: '',
      args: [],
    );
  }

  /// `Please apply for KYC verification`
  String get kycVerificationMsg {
    return Intl.message(
      'Please apply for KYC verification',
      name: 'kycVerificationMsg',
      desc: '',
      args: [],
    );
  }

  /// `View KYC Logs`
  String get viewKycLogs {
    return Intl.message(
      'View KYC Logs',
      name: 'viewKycLogs',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get chat {
    return Intl.message(
      'Chat',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `Not Required`
  String get notRequired {
    return Intl.message(
      'Not Required',
      name: 'notRequired',
      desc: '',
      args: [],
    );
  }

  /// `Attribute Value`
  String get attributeValue {
    return Intl.message(
      'Attribute Value',
      name: 'attributeValue',
      desc: '',
      args: [],
    );
  }

  /// `Attribute Values`
  String get attributeValues {
    return Intl.message(
      'Attribute Values',
      name: 'attributeValues',
      desc: '',
      args: [],
    );
  }

  /// `Add Value`
  String get addValue {
    return Intl.message(
      'Add Value',
      name: 'addValue',
      desc: '',
      args: [],
    );
  }

  /// `Add new`
  String get addNew {
    return Intl.message(
      'Add new',
      name: 'addNew',
      desc: '',
      args: [],
    );
  }

  /// `Attribute Name`
  String get attributeName {
    return Intl.message(
      'Attribute Name',
      name: 'attributeName',
      desc: '',
      args: [],
    );
  }

  /// `Enter attribute name`
  String get enterAttributeName {
    return Intl.message(
      'Enter attribute name',
      name: 'enterAttributeName',
      desc: '',
      args: [],
    );
  }

  /// `Enter attribute price`
  String get enterAttributePrice {
    return Intl.message(
      'Enter attribute price',
      name: 'enterAttributePrice',
      desc: '',
      args: [],
    );
  }

  /// `Inactive`
  String get inactive {
    return Intl.message(
      'Inactive',
      name: 'inactive',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Update Attribute`
  String get updateAttribute {
    return Intl.message(
      'Update Attribute',
      name: 'updateAttribute',
      desc: '',
      args: [],
    );
  }

  /// `Add Attribute`
  String get addAttribute {
    return Intl.message(
      'Add Attribute',
      name: 'addAttribute',
      desc: '',
      args: [],
    );
  }

  /// `Tax information`
  String get taxInformation {
    return Intl.message(
      'Tax information',
      name: 'taxInformation',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get copy {
    return Intl.message(
      'Copy',
      name: 'copy',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw Request`
  String get withdrawRequest {
    return Intl.message(
      'Withdraw Request',
      name: 'withdrawRequest',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong while requesting withdraw`
  String get requestWithdrawErr {
    return Intl.message(
      'Something went wrong while requesting withdraw',
      name: 'requestWithdrawErr',
      desc: '',
      args: [],
    );
  }

  /// `WITHDRAW PREVIEW`
  String get withdrawPreview {
    return Intl.message(
      'WITHDRAW PREVIEW',
      name: 'withdrawPreview',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw Method`
  String get withdrawMethod {
    return Intl.message(
      'Withdraw Method',
      name: 'withdrawMethod',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw Amount`
  String get withdrawAmount {
    return Intl.message(
      'Withdraw Amount',
      name: 'withdrawAmount',
      desc: '',
      args: [],
    );
  }

  /// `Conversion rate`
  String get conversionRate {
    return Intl.message(
      'Conversion rate',
      name: 'conversionRate',
      desc: '',
      args: [],
    );
  }

  /// `Final Amount`
  String get finalAmount {
    return Intl.message(
      'Final Amount',
      name: 'finalAmount',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Product`
  String get product {
    return Intl.message(
      'Product',
      name: 'product',
      desc: '',
      args: [],
    );
  }

  /// `Verify KYC`
  String get verifyKyc {
    return Intl.message(
      'Verify KYC',
      name: 'verifyKyc',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe Now`
  String get subscribeNow {
    return Intl.message(
      'Subscribe Now',
      name: 'subscribeNow',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe to add product`
  String get subscribeToAddProduct {
    return Intl.message(
      'Subscribe to add product',
      name: 'subscribeToAddProduct',
      desc: '',
      args: [],
    );
  }

  /// `Create Ticket`
  String get createTicket {
    return Intl.message(
      'Create Ticket',
      name: 'createTicket',
      desc: '',
      args: [],
    );
  }

  /// `Your shop is not active`
  String get yourShopIsNotActive {
    return Intl.message(
      'Your shop is not active',
      name: 'yourShopIsNotActive',
      desc: '',
      args: [],
    );
  }

  /// `Please contact your admin`
  String get contactAdmin {
    return Intl.message(
      'Please contact your admin',
      name: 'contactAdmin',
      desc: '',
      args: [],
    );
  }

  /// `Your shop is banned`
  String get yourShopIsBanned {
    return Intl.message(
      'Your shop is banned',
      name: 'yourShopIsBanned',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<TR> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'az'),
      Locale.fromSubtags(languageCode: 'bn'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'id'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ur'),
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<TR> load(Locale locale) => TR.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
