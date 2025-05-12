import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:seller_management/main.export.dart';

class RemoteDB extends Database with ApiHandler {
  final _dio = locate<DioClient>();

  FutureResponse<PagedItem<T>> pagedItemFromUrl<T>(
    String url,
    String key,
    T Function(QMap map) mapper,
  ) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get(url),
      mapper: (map) => PagedItem<T>.fromMap(map[key], mapper),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<({String msg, Seller seller})>> updateStoreInfo(
    QMap formData,
    Map<String, File> partFiles,
  ) async {
    final body = formData;
    for (var MapEntry(:key, :value) in partFiles.entries) {
      body[key] = await MultipartFile.fromFile(value.path);
    }

    final data = await apiCallHandler(
      call: () => _dio.post(Endpoints.shopUpdate, data: body),
      mapper: (map) => BaseResponse.fromMap(
        map,
        (map) => (
          msg: map['message'].toString(),
          seller: Seller.fromMap(map['seller'])
        ),
      ),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<({String msg, Seller seller})>> updateSellerProfile(
      QMap formData, File? file) async {
    final body = {...formData};

    if (file != null) {
      body['image'] = await MultipartFile.fromFile(file.path);
    }

    final data = await apiCallHandler(
      call: () => _dio.post(Endpoints.profileUpdate, data: body),
      mapper: (map) => BaseResponse.fromMap(
        map,
        (map) => (
          msg: map['message'].toString(),
          seller: Seller.fromMap(map['seller'])
        ),
      ),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<({String msg, WithdrawData data})>> requestWithdraw(
    String method,
    String amount,
  ) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.post(
        Endpoints.withdrawRequest,
        data: {'id': method, 'amount': amount},
      ),
      mapper: (map) => (
        msg: '${map['message']}',
        data: WithdrawData.fromMap(map['withdraw'])
      ),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<String>> storeDigitalProduct(QMap formData) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.post(
        Endpoints.digitalProductStore,
        data: formData,
      ),
      mapper: (map) => map['message'].toString(),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<String>> updateDigitalProduct(
    String id,
    QMap formData,
  ) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.post(
        Endpoints.digitalProductUpdate,
        data: {'uid': id, ...formData},
      ),
      mapper: (map) => map['message'].toString(),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<String>> storePhysicalProduct(QMap formData) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.post(
        Endpoints.physicalProductStore,
        data: formData,
      ),
      mapper: (map) => map['message'].toString(),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<String>> updatePhysicalProduct(
    String id,
    QMap formData,
  ) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.post(
        Endpoints.physicalProductUpdate,
        data: {'uid': id, ...formData},
      ),
      mapper: (map) => map['message'].toString(),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<ProductModel>> attributeDelete(String id) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get(Endpoints.attributeDelete(id)),
      mapper: (map) => ProductModel.fromMap(map['product']),
    );
    return data;
  }

  @override
  FutureReport<BaseResponse<ProductModel>> attributeValueDelete(
      String id) async {
    final data = await apiCallHandler(
      call: () => _dio.get(Endpoints.attributeValueDelete(id)),
      mapper: (map) => BaseResponse.fromMap(
        map,
        (map) => ProductModel.fromMap(
          map['product'],
        ),
      ),
    );
    return data;
  }

  @override
  FutureReport<BaseResponse<AuthConfig>> authConfig() async {
    final data = await apiCallHandler(
      call: () => _dio.get(Endpoints.authConfig),
      mapper: (map) => BaseResponse.fromMap(
        map,
        (map) => AuthConfig.fromMap(map),
      ),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<AppSettings>> config() async {
    final data = await apiCallHandler(
      call: () => _dio.get(Endpoints.config),
      mapper: (map) => BaseResponse.fromMap(
        map,
        (map) => AppSettings.fromMap(map),
      ),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<TicketData>> createTicket(QMap formData) async {
    final data = await apiCallHandler(
      call: () => _dio.post(Endpoints.ticketStore, data: formData),
      mapper: (map) => BaseResponse.fromMap(
        map,
        (map) => TicketData.fromMap(map),
      ),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<String>> verifyEmail(String email) async {
    final data = await apiCallHandler(
      call: () => _dio.post(Endpoints.verifyEmail, data: {'email': email}),
      mapper: (map) => BaseResponse.fromMap(
        map,
        (map) => (map['message'] as String?) ?? 'Reset code sent your email',
      ),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<String>> verifyOTP(QMap formData) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.post(Endpoints.verifyOTP, data: formData),
      mapper: (map) =>
          (map['message'] as String?) ?? 'Reset code sent your email',
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<String>> resetPassword(QMap formData) async {
    final data = await apiCallHandler(
      call: () => _dio.post(Endpoints.resetPassword, data: formData),
      mapper: (map) => BaseResponse.fromMap(
        map,
        (map) => (map['message'] as String?) ?? 'Password Change Successfully',
      ),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<PagedItem<CampaignModel>>> getCampaign([
    String? url,
  ]) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get(url ?? Endpoints.campaign),
      mapper: (map) =>
          PagedItem.fromMap(map['campaigns'], CampaignModel.fromMap),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<Dashboard>> getDashboard() async {
    final data = await apiCallHandler(
      call: () => _dio.get(Endpoints.dashboard),
      mapper: (map) => BaseResponse.fromMap(
        map,
        (map) => Dashboard.fromMap(map),
      ),
    );
    return data;
  }

  @override
  FutureReport<BaseResponse<PagedItem<OrderModel>>> getDigitalOrder({
    DateTimeRange? dateRange,
    String search = '',
    String status = '',
  }) async {
    final start = dateRange?.start.formatDate('yyyy-MM-dd');
    final end = dateRange?.end.formatDate('yyyy-MM-dd');
    final date = dateRange == null ? '' : '$start+to+$end';
    final data = await apiCallHandlerBase(
      call: () => _dio.get(
        '${Endpoints.digitalOrder}?search=$search&date=$date&status=$status',
      ),
      mapper: (map) => PagedItem.fromMap(map['orders'], OrderModel.fromMap),
    );
    return data;
  }

  @override
  FutureReport<BaseResponse<PagedItem<ProductModel>>> getDigitalProduct(
    String status,
    String search,
  ) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get(
        Endpoints.digitalProduct,
        queryParameters: {'status': status, 'search': search},
      ),
      mapper: (map) => PagedItem.fromMap(map['products'], ProductModel.fromMap),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<String>> getDownload({
    required String id,
    required String massageId,
    required String ticketNo,
  }) async {
    final body = {
      'id': id,
      'support_message_id': massageId,
      'ticket_number': ticketNo,
    };

    final data = await apiCallHandler(
      call: () => _dio.post(Endpoints.fileDownload, data: body),
      mapper: (map) => BaseResponse.fromMap(
        map,
        (map) => map['url'] as String,
      ),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<OrderModel>> getOrderDetails(String id) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get(Endpoints.orderDetails(id)),
      mapper: (map) => OrderModel.fromMap(map['order']),
    );
    return data;
  }

  @override
  FutureReport<BaseResponse<PagedItem<OrderModel>>> getPhysicalOrder({
    DateTimeRange? dateRange,
    String search = '',
    String status = '',
  }) async {
    final start = dateRange?.start.formatDate('yyyy-MM-dd');
    final end = dateRange?.end.formatDate('yyyy-MM-dd');
    final date = dateRange == null ? '' : '$start+to+$end';

    final data = await apiCallHandlerBase(
      call: () => _dio.get(
        '${Endpoints.physicalOrder}?search=$search&date=$date&status=$status',
      ),
      mapper: (map) => PagedItem.fromMap(map['orders'], OrderModel.fromMap),
    );
    return data;
  }

  @override
  FutureReport<BaseResponse<PagedItem<OrderModel>>> orderFromUrl(
    String url,
  ) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get(url),
      mapper: (map) => PagedItem.fromMap(map['orders'], OrderModel.fromMap),
    );
    return data;
  }

  @override
  FutureReport<BaseResponse<PagedItem<ProductModel>>> getPhysicalProduct(
    String search,
    String status,
  ) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get(
        Endpoints.physicalProduct,
        queryParameters: {'status': status, 'search': search},
      ),
      mapper: (map) => PagedItem.fromMap(map['products'], ProductModel.fromMap),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<PagedItem<ProductModel>>> getProductByUrl(
    String url,
  ) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get(url),
      mapper: (map) => PagedItem.fromMap(map['products'], ProductModel.fromMap),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<Seller>> getStoreInfo() async {
    final data = await apiCallHandler(
      call: () => _dio.get(Endpoints.shop),
      mapper: (map) => BaseResponse.fromMap(
        map,
        (map) => Seller.fromMap(map['seller']),
      ),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<PagedItem<SubscriptionInfo>>> getSubscriptionList({
    String date = '',
  }) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get('${Endpoints.subscriptionList}?date=$date'),
      mapper: (map) =>
          PagedItem.fromMap(map['subscriptions'], SubscriptionInfo.fromMap),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<PagedItem<SubscriptionInfo>>>
      getSubscriptionListFromUrl(
    String url,
  ) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get(url),
      mapper: (map) =>
          PagedItem.fromMap(map['subscriptions'], SubscriptionInfo.fromMap),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<List<SubscriptionPlan>>>
      getSubscriptionPlan() async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get(Endpoints.subscriptionPlan),
      mapper: (map) => List<SubscriptionPlan>.from(
        map['plans']?['data']?.map((x) => SubscriptionPlan.fromMap(x)) ?? [],
      ),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<PagedItem<TransactionData>>> getTransactionList({
    String date = '',
    String search = '',
  }) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get(
        '${Endpoints.transactions}?search=$search&date=$date',
      ),
      mapper: (map) => PagedItem<TransactionData>.fromMap(
        map['transaction'],
        (map) => TransactionData.fromMap(map),
      ),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<PagedItem<TransactionData>>> transactionsFromUrl(
    String url,
  ) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get(url),
      mapper: (map) =>
          PagedItem.fromMap(map['transaction'], TransactionData.fromMap),
    );
    return data;
  }

  @override
  FutureResponse<String> login({
    required String username,
    required String password,
  }) async {
    final body = {'username': username, 'password': password};

    final data = await apiCallHandlerBase(
      call: () => _dio.post(Endpoints.login, data: body),
      mapper: (map) => (map)['access_token'] as String,
    );
    return data;
  }

  @override
  FutureReport<BaseResponse<String>> orderStatusUpdate({
    required String orderId,
    required String status,
    String note = '',
  }) async {
    final body = {
      'order_number': orderId,
      'status': status,
      'delivery_note': note,
    };

    final data = await apiCallHandlerBase(
      call: () => _dio.post(Endpoints.orderStatusUpdate, data: body),
      mapper: (map) => map['message'].toString(),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<ProductModel>> digitalAttributeStore({
    required String uid,
    required QMap formData,
  }) async {
    final body = {'uid': uid, ...formData};

    final data = await apiCallHandlerBase(
      call: () => _dio.post(Endpoints.digitalProductAttributeStore, data: body),
      mapper: (map) => ProductModel.fromMap(map['product']),
    );
    return data;
  }

  @override
  FutureReport<BaseResponse<ProductModel>> digitalAttributeUpdate({
    required String uid,
    required QMap formData,
  }) async {
    final body = {'uid': uid, ...formData};

    final data = await apiCallHandlerBase(
      call: () =>
          _dio.post(Endpoints.digitalProductAttributeUpdate, data: body),
      mapper: (map) => ProductModel.fromMap(map['product']),
    );
    return data;
  }

  @override
  FutureReport<BaseResponse<ProductModel>> productAttributeValueStore({
    required String uid,
    required QMap formaData,
  }) async {
    final body = {'uid': uid, ...formaData};

    final data = await apiCallHandlerBase(
      call: () => _dio.post(Endpoints.attributeValueStore, data: body),
      mapper: (map) {
        return ProductModel.fromMap(map['product']);
      },
    );
    return data;
  }

  @override
  FutureReport<BaseResponse<ProductModel>> productAttributeValueUpdate({
    required String uid,
    required String valueUid,
    required QMap formaData,
  }) async {
    final body = {'uid': uid, 'value_uid': valueUid, ...formaData};

    final data = await apiCallHandlerBase(
      call: () => _dio.post(Endpoints.attributeValueUpdate, data: body),
      mapper: (map) {
        return ProductModel.fromMap(map['product']);
      },
    );
    return data;
  }

  @override
  FutureReport<BaseResponse<String>> deleteGalleryImage(String id) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get(Endpoints.galleryDelete(id)),
      mapper: (map) =>
          map['message']?.toString() ?? 'Image deleted successfully',
    );
    return data;
  }

  @override
  FutureReport<BaseResponse<String>> productDelete(String id) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get(Endpoints.productDelete(id)),
      mapper: (map) =>
          map['message']?.toString() ?? 'Product deleted successfully',
    );
    return data;
  }

  @override
  FutureReport<BaseResponse<String>> deletePermanently(String id) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get(Endpoints.productPermanentDelete(id)),
      mapper: (map) =>
          map['message']?.toString() ?? 'Product deleted successfully',
    );
    return data;
  }

  @override
  FutureReport<BaseResponse<String>> productRestore(String id) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get(Endpoints.productRestore(id)),
      mapper: (map) =>
          map['message']?.toString() ?? 'Product restored successfully',
    );
    return data;
  }

  @override
  FutureReport<BaseResponse<ProductModel>> productDetails(String id) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get(Endpoints.productDetails(id)),
      mapper: (map) => ProductModel.fromMap(map['product']),
    );

    return data;
  }

  @override
  FutureResponse<String> register(QMap formData) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.post(Endpoints.register, data: formData),
      mapper: (map) => (map)['access_token'] as String,
    );
    return data;
  }

  @override
  FutureResponse<String> logout() async {
    final data = await apiCallHandlerBase(
      call: () => _dio.post(Endpoints.logout),
      mapper: (map) => map['message']?.toString() ?? 'Logout Successfully',
    );
    return data;
  }

  @override
  FutureReport<BaseResponse<String>> renewSubscription(String id) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get(Endpoints.renewSubscription(id)),
      mapper: (map) => (map['message'] as String?) ?? 'Subscription Renewed',
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<String>> storeWithdraw(
    String id,
    QMap formData,
  ) async {
    final body = {'id': id, ...formData};
    final data = await apiCallHandlerBase(
      call: () => _dio.post(Endpoints.withdrawStore, data: body),
      mapper: (map) => map['message'].toString(),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<String>> subscribeToPlan(String id) async {
    Logger(id);
    final data = await apiCallHandlerBase(
      call: () => _dio.post(Endpoints.subscribe, data: {'id': id}),
      mapper: (map) => (map['message'] as String?) ?? 'Subscribed',
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<String>> subscriptionUpdate(String id) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.post(Endpoints.subscriptionUpdate, data: {'id': id}),
      mapper: (map) => (map['message'] as String?) ?? 'Subscription Updated',
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<PagedItem<SupportTicket>>> ticketList(
      [String? url]) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get(url ?? Endpoints.ticket),
      mapper: (map) => PagedItem.fromMap(map['tickets'], SupportTicket.fromMap),
    );
    return data;
  }

  @override
  FutureReport<BaseResponse<TicketData>> ticketMassage(String id) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get(Endpoints.ticketMessage(id)),
      mapper: (map) => TicketData.fromMap(map),
    );
    return data;
  }

  @override
  FutureReport<BaseResponse<TicketData>> ticketReply({
    required String ticketNumber,
    required String message,
    required List<File> files,
  }) async {
    final parts = <MultipartFile>[];
    for (var file in files) {
      parts.add(
        await MultipartFile.fromFile(file.path),
      );
    }
    final body = {
      'ticket_number': ticketNumber,
      'message': message,
      'file': parts,
    };

    final data = await apiCallHandlerBase(
      call: () => _dio.post(Endpoints.ticketReply, data: body),
      mapper: (map) => TicketData.fromMap(map),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<String>> updatePassword(QMap formData) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.post(Endpoints.passwordUpdate, data: formData),
      mapper: (map) => (map['message'] as String?) ?? 'Password Updated',
    );

    return data;
  }

  ///! withdraw

  @override
  FutureReport<BaseResponse<PagedItem<WithdrawData>>> withdrawList(
    String search,
    String date,
  ) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get(
        '${Endpoints.withdrawList}?search=$search&date=$date',
      ),
      mapper: (map) =>
          PagedItem.fromMap(map['withdraw_list'], WithdrawData.fromMap),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<PagedItem<WithdrawData>>> withdrawListFromUrl(
    String url,
  ) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get(url),
      mapper: (map) => PagedItem<WithdrawData>.fromMap(
        map['withdraw_list'],
        WithdrawData.fromMap,
      ),
    );

    return data;
  }

  @override
  FutureReport<BaseResponse<List<WithdrawMethod>>> withdrawMethods() async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get(Endpoints.withdrawMethods),
      mapper: (map) => List<WithdrawMethod>.from(
        map['methods']?['data']?.map((x) => WithdrawMethod.fromMap(x)) ?? [],
      ),
    );

    return data;
  }

  //! chat

  @override
  FutureResponse<List<Customer>> fetchChatList() async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get(Endpoints.chatList),
      mapper: (map) => List<Customer>.from(map['customers']?['data'].map(
        (x) => Customer.fromMap(x),
      )),
    );

    return data;
  }

  @override
  FutureResponse<CustomerMessageData> fetchChatMessage(String id) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get(Endpoints.chatMessage(id)),
      mapper: (map) => CustomerMessageData.fromMap(map),
    );

    return data;
  }

  @override
  FutureResponse<String> sendChatMessage(QMap formData) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.post(Endpoints.chatSendMessage, data: formData),
      mapper: (map) => map['message'].toString(),
    );

    return data;
  }

  //! fcm

  @override
  FutureResponse<String> updateFCMToken(String token) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.post(Endpoints.updateFCM, data: {'fcm_token': token}),
      mapper: (map) => '${map['message']}',
    );
    return data;
  }

//! KYC is on its repo

//! Deposit

  @override
  FutureResponse<PagedItem<DepositLog>> getDepositLogs(
    String trx,
    String date,
  ) async {
    final url = Uri(path: Endpoints.depositLogs, queryParameters: {
      if (trx.isNotEmpty) 'trx_code': trx,
      if (date.isNotEmpty) 'date': date
    });
    final data = await apiCallHandlerBase(
      call: () => _dio.get(url.toString()),
      mapper: (map) =>
          PagedItem.fromMap(map['deposit_logs'], DepositLog.fromMap),
    );

    return data;
  }

  @override
  FutureResponse<PostMeg<DepositLog>> makeDeposit(QMap form) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.post(Endpoints.makeDeposit, data: form),
      mapper: (map) {
        return PostMeg.fromMap(
          map,
          (m) => DepositLog.fromMap(
            m['log'] ?? m['payment_log'],
            m['payment_url'],
          ),
        );
      },
    );

    return data;
  }
}
