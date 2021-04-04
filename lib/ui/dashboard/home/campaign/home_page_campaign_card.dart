import 'package:crowdfund_app/constants/constants.dart';
import 'package:crowdfund_app/ui/dashboard/home/campaign/campaign_brief_card_page.dart';
import 'package:flutter/material.dart';

class CampaignSmallCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: AppConfig.screenHeight! * 0.6,
        child: ListView.builder(
            padding: EdgeInsets.only(
              left: kPadding,
            ),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(kSmallRadius),
                    child: Material(
                      shadowColor: Color(0x351F54c3),
                      elevation: 10,
                      child: CampaignItemPage(),
                    ),
                  ),
                )),
      ),
    );
  }
}
