import 'package:seller_management/main.export.dart';

class DashboardRepo extends Repo {
  FutureReport<BaseResponse<Dashboard>> getDashboard() async {
    final data = await rdb.getDashboard();

    return data;
  }

  Dashboard? getDashSync() {
    return ldb.getDashboard();
  }

  Future<Dashboard?> saveDash(Dashboard dash) async {
    return ldb.getDashboard(dash);
  }
}
