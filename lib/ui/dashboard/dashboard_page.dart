import 'package:crowdfund_app/constants/constants.dart';
import 'package:crowdfund_app/routing/app_navigator.dart';
import 'package:crowdfund_app/ui/dashboard/home/campaign/create_campaign_page.dart';
import 'package:crowdfund_app/ui/dashboard/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Text(
      'Index 1: Crowdfund Campaigns',
      style: optionStyle,
    ),
    Text(
      'Index 2: Notifications',
      style: optionStyle,
    ),
    Text(
      'Index 3: Me',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: _widgetOptions.elementAt(_selectedIndex),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            showBarModalBottomSheet(
                context: context,
                builder: (context) {
                  return SizedBox(
                      height: AppConfig.screenHeight! * 0.6,
                      child: ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: kPadding),
                          itemCount: options.length,
                          itemBuilder: (context, index) {
                            return TextButton(
                              onPressed: () {
                                AppNavigator.push(
                                    context, options[index]["widget"]);
                              },
                              child: Row(
                                children: [
                                  Divider(
                                    indent: kSpacing1,
                                  ),
                                  options[index]["icon"],
                                  Divider(
                                    indent: kSpacing2,
                                  ),
                                  Text(
                                    options[index]["text"],
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  )
                                ],
                              ),
                            );
                          }));
                });
          },
          child: Icon(Icons.add_rounded),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
            shape: AutomaticNotchedShape(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14))),
            elevation: 20,
            color: Theme.of(context).scaffoldBackgroundColor,
            notchMargin: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Spacer(),
                IconButton(
                    icon: Icon(
                      Icons.home,
                      color: _selectedIndex == 0 ? kActiveIcon : kInactiveIcon,
                    ),
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    }),
                Spacer(
                  flex: 1,
                ),
                IconButton(
                    icon: Icon(Icons.search,
                        color:
                            _selectedIndex == 1 ? kActiveIcon : kInactiveIcon),
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    }),
                Spacer(
                  flex: 5,
                ),
                IconButton(
                    icon: Icon(Icons.notifications,
                        color:
                            _selectedIndex == 2 ? kActiveIcon : kInactiveIcon),
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                    }),
                Spacer(
                  flex: 1,
                ),
                IconButton(
                    icon: Icon(Icons.person,
                        color:
                            _selectedIndex == 3 ? kActiveIcon : kInactiveIcon),
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 3;
                      });
                    }),
                Spacer()
              ],
            )));
  }

  List<Map<String, dynamic>> options = [
    {
      "icon": Icon(
        Icons.add_a_photo_rounded,
        color: AppColors.black,
      ),
      "text": "Add a photo",
      "widget": Placeholder()
    },
    {
      "icon": Icon(
        Icons.video_call,
        color: AppColors.black,
      ),
      "text": "Take a video",
      "widget": Placeholder()
    },
    {
      "icon": Icon(
        Icons.campaign_rounded,
        color: AppColors.black,
      ),
      "text": "Start a campaign",
      "widget": CreateCampaignPage()
    }
  ];
}
