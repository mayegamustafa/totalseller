import 'package:seller_management/models/_misc/pagination.dart';
import 'package:seller_management/models/base/base_response.dart';
import 'package:seller_management/models/campaign/campaign_model.dart';

import '../../../models/base/repo.dart';

class CampaignRepo extends Repo {
  FutureResponse<PagedItem<CampaignModel>> getCampaignList(
      [String? url]) async {
    final data = await rdb.getCampaign(url);
    return data;
  }
}
