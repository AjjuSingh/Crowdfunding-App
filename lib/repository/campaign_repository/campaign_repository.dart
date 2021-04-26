import 'package:crowdfund_app/models/campaign/campaign_model.dart';

abstract class CampaignRepository {
  /// Get the list of crowdfunding campaigns
  Future<void> createCampaign({Campaign campaign});
}
