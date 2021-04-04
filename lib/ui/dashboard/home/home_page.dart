import 'package:crowdfund_app/constants/app_config.dart';
import 'package:crowdfund_app/constants/app_size.dart';
import 'package:crowdfund_app/ui/dashboard/home/campaign/home_page_campaign_card.dart';
import 'package:crowdfund_app/widgets/sliver_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// TextEditingController for search field
  late TextEditingController _searchController;

  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: _pinned,
            floating: _floating,
            snap: _snap,
            title: Text(
              kAppName,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            actionsIconTheme:
                IconThemeData(color: Theme.of(context).iconTheme.color),
            actions: [
              IconButton(
                  icon: Icon(CupertinoIcons.chat_bubble_text), onPressed: () {})
            ],
            backgroundColor: Colors.white,
          ),
          SliverPadding(
            padding: EdgeInsets.all(kPadding),
            sliver: SliverText(
              child: Text(
                "Active campaign",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          CampaignSmallCard(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 100.0,
                  child: Center(
                    child: Text('$index', textScaleFactor: 5),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
