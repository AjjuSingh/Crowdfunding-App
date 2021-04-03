import 'package:crowdfund_app/constants/constants.dart';
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
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Crowdfund Campaigns"),
        ),
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
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "Create a ${options[index]["text"]}")));
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (pos) {
              _onItemTapped(pos);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.campaign_rounded), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notification_important), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people_outline_rounded), label: "")
            ]));
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
      "widget": Placeholder()
    }
  ];
}
