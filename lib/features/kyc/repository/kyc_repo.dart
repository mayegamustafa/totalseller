import 'package:seller_management/main.export.dart';

class KycRepo with ApiHandler {
  final _dio = DioClient(useEvent: false);

  FutureResponse<KYCLog> submitKYC(QMap formData) async {
    final data = await apiCallHandlerBase(
      call: () => _dio.post(Endpoints.kycApplication, data: formData),
      mapper: (map) => KYCLog.fromMap(map['log']),
    );
    return data;
  }

  FutureResponse<List<KYCLog>> kycLogs() async {
    final data = await apiCallHandlerBase(
      call: () => _dio.get(Endpoints.kycLog),
      mapper: (map) => List<KYCLog>.from(
        map['kyc_logs']?['data']?.map((x) => KYCLog.fromMap(x)) ?? [],
      ),
    );
    return data;
  }
}
