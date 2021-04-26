import 'package:crowdfund_app/_utils/safe_print.dart';
import 'package:crowdfund_app/constants/api_path.dart';
import 'package:crowdfund_app/models/campaign/campaign_model.dart';
import 'package:crowdfund_app/repository/campaign_repository/campaign_repository.dart';
import 'package:crowdfund_app/services/services.dart';
import 'package:dio/dio.dart';

class CampaignRepositoryImpl extends CampaignRepository {
  /// Http service
  HttpService _httpService = HttpFactory.create();

  @override
  Future<void> createCampaign({Campaign? campaign}) {
    var response;
    try {
      response = _httpService.post(
          url: ApiPath.createCampaign, queryParams: campaign!.toJson());
    } catch (e) {
      safePrint(e.toString());
    }
    return response;
  }
}
