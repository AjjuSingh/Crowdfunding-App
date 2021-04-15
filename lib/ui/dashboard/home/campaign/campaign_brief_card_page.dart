import 'package:crowdfund_app/constants/app_colors.dart';
import 'package:crowdfund_app/constants/app_config.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

/// This widget shows the short detail about campaign on home page
class CampaignItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConfig.screenWidth! * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBackground(),
          Padding(
            padding: kMaterialListPadding.copyWith(
                left: kDefaultPadding, right: kDefaultPadding),
            child: _buildType(context),
          ),
          Padding(
            padding: kMaterialListPadding.copyWith(
                left: kDefaultPadding, right: kDefaultPadding),
            child: _buildTitle(context),
          ),
          Expanded(
            child: Padding(
              padding: kMaterialListPadding.copyWith(
                  left: kDefaultPadding, right: kDefaultPadding),
              child: _buildDescripiton(context),
            ),
          ),
          Divider(),
          Padding(
            padding: kMaterialListPadding.copyWith(
                left: kDefaultPadding, right: kDefaultPadding),
            child: _buildFundTrackerWidget(context),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return SizedBox(
        height: AppConfig.screenHeight! * 0.18,
        child: Container(
          color: Colors.blueGrey,
        ));
  }

  Widget _buildType(BuildContext context) {
    return Text(
      "Technology",
      style:
          Theme.of(context).textTheme.bodyText1!.copyWith(color: kPrimaryColor),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text('''Winston - Take back Control of your  Online Space Program''',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontWeight: FontWeight.bold));
  }

  Widget _buildDescripiton(BuildContext context) {
    return Text(
        '''Plug n Play hardware filter that reclaims your use of the internet on Earth's global average surface temperature in 2020 tied with 2016 as the warmest year on record, according to an analysis by NASA.''' *
            2,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyText1!);
  }

  _buildFundTrackerWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("48%"), Text("2.5k \$")],
        ),
        SizedBox(
          height: 4,
        ),
        LinearPercentIndicator(
          linearStrokeCap: LinearStrokeCap.roundAll,
          animation: true,
          lineHeight: 4,
          animationDuration: 1500,
          percent: 0.48,
          progressColor: kPrimaryColor,
        ),
        SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.timelapse,
                  size: 18,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "14 days left",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.grey, fontSize: 12),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  "Collected",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.grey, fontSize: 12),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
