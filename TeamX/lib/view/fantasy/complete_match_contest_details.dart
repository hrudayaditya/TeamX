import 'package:flutter/material.dart';
import 'package:teamx/view/Fantasy/widgets/my_contest_card.dart';
import 'package:teamx/view/Fantasy/widgets/my_teams_card.dart';

import '../../res/app_text_style.dart';
import '../../res/color.dart';
import 'fantasy_points_system.dart';

class CompleteMatchContestDetails extends StatefulWidget {
  const CompleteMatchContestDetails({Key? key}) : super(key: key);

  @override
  State<CompleteMatchContestDetails> createState() => _CompleteMatchContestDetailsState();

}

class _CompleteMatchContestDetailsState extends State<CompleteMatchContestDetails>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;
  late final ScrollController scrollController1;
  late final ScrollController scrollController2;

  List playerStats = [
    {'name': 'A Rossington', 'points': 123, 'slected by': '45.99', 'captain selected': '2.77', 'vice captain selected': '2.77'},
    {'name': 'A Rossington', 'points': 123, 'slected by': '45.99', 'captain selected': '2.77', 'vice captain selected': '2.77'},
    {'name': 'A Rossington', 'points': 123, 'slected by': '45.99', 'captain selected': '2.77', 'vice captain selected': '2.77'},
    {'name': 'A Rossington', 'points': 123, 'slected by': '45.99', 'captain selected': '2.77', 'vice captain selected': '2.77'},
    {'name': 'A Rossington', 'points': 123, 'slected by': '45.99', 'captain selected': '2.77', 'vice captain selected': '2.77'},
    {'name': 'A Rossington', 'points': 123, 'slected by': '45.99', 'captain selected': '2.77', 'vice captain selected': '2.77'},
    {'name': 'A Rossington', 'points': 123, 'slected by': '45.99', 'captain selected': '2.77', 'vice captain selected': '2.77'},
    {'name': 'A Rossington', 'points': 123, 'slected by': '45.99', 'captain selected': '2.77', 'vice captain selected': '2.77'},
    {'name': 'A Rossington', 'points': 123, 'slected by': '45.99', 'captain selected': '2.77', 'vice captain selected': '2.77'},
    {'name': 'A Rossington', 'points': 123, 'slected by': '45.99', 'captain selected': '2.77', 'vice captain selected': '2.77'},
    {'name': 'A Rossington', 'points': 123, 'slected by': '45.99', 'captain selected': '2.77', 'vice captain selected': '2.77'},
    {'name': 'A Rossington', 'points': 123, 'slected by': '45.99', 'captain selected': '2.77', 'vice captain selected': '2.77'},
    {'name': 'A Rossington', 'points': 123, 'slected by': '45.99', 'captain selected': '2.77', 'vice captain selected': '2.77'},
    {'name': 'A Rossington', 'points': 123, 'slected by': '45.99', 'captain selected': '2.77', 'vice captain selected': '2.77'},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    scrollController1 = ScrollController();
    scrollController2 = ScrollController();

    scrollController1.addListener(() {
      if (scrollController1.offset != scrollController2.offset) {
        scrollController2.jumpTo(scrollController1.offset);
      }
    });
    scrollController2.addListener(() {
      if (scrollController1.offset != scrollController2.offset) {
        scrollController1.jumpTo(scrollController2.offset);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _controller.dispose;
    _tabController.dispose;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffeef0fc),
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          AppBar().preferredSize.height,
        ),
        child: AppBar(
          iconTheme: IconThemeData(
            size: 20,
            color: Colors.white, // Set the color you want here
          ),
          backgroundColor: Color(0xff191D88),
          elevation: 1.0,
          title: Row(
            children: [
              Text("CH-W vs CM-W",
                  style: AppTextStyles.primaryStyle(
                      16.0, AppColors.white, FontWeight.w600)),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FantasyPointsSystem(),
                  ));
                },
                child: Container(
                  margin: EdgeInsets.only(left: 6),
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1.75, color: Colors.white
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                      "PTS",
                      style: AppTextStyles.terniaryStyle(
                          10.0, AppColors.white, FontWeight.w700)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xff191D88),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.transparent,
                          ],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                      child: Text(
                        "Scores",
                        style: AppTextStyles.terniaryStyle(
                            16.0, AppColors.primaryColor, FontWeight.w700),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.white,
                          ],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        ),
                      ),
                    ),
                  ],
                ),


                Container(
                  margin: EdgeInsets.only(top: 10, left: 14, right: 14, bottom: 10),
                  height: 42.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.network(
                                'https://staticg.sportskeeda.com/skm/assets/team-logos/cricket/melbourne-stars.png?w=192',
                                height: 36,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'IND',
                                    style: AppTextStyles.primaryStyle(
                                      13.0,
                                      Colors.white70,
                                      FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '192/10',
                                        style: AppTextStyles.terniaryStyle(
                                          16.0,
                                          AppColors.white,
                                          FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(width: 4,),
                                      Text(
                                        '(20)',
                                        style: AppTextStyles.terniaryStyle(
                                          12.0,
                                          Colors.white54,
                                          FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        '|',
                        style: AppTextStyles.primaryStyle(
                          27.5,
                          Colors.white54,
                          FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'PAK',
                                style: AppTextStyles.primaryStyle(
                                  13.0,
                                  Colors.white70,
                                  FontWeight.w600,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '(20)',
                                    style: AppTextStyles.terniaryStyle(
                                      12.0,
                                      Colors.white54,
                                      FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 4,),
                                  Text(
                                    '187/9',
                                    style: AppTextStyles.terniaryStyle(
                                      16.0,
                                      AppColors.white,
                                      FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Image.network(
                            'https://staticg.sportskeeda.com/skm/assets/team-logos/cricket/sydney-sixers.png?w=192',
                            height: 36,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.circle,
                        size: 6,
                        color: AppColors.green,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        'Match Status',
                        style: AppTextStyles.terniaryStyle(
                          12.0,
                          AppColors.primaryColor,
                          FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5,),
                Text(
                  'IND Beat PAK by 12 Runs',
                  style: AppTextStyles.terniaryStyle(
                    12.0,
                    AppColors.white,
                    FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5,),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Color(0xfff8f8fe),
                border: Border.all(width: 1.5, color: Colors.white),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 2,
                      blurRadius: 20)
                ]),
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  indicatorColor: AppColors.primaryColor,
                  labelColor: AppColors.primaryColor,
                  dividerColor: Colors.transparent,
                  indicatorWeight: 4,
                  onTap: (index) {
                    if (index == 0) {}
                    if (index == 1) {}
                    if (index == 2) {}
                    if (index == 3) {}
                  },
                  tabs: [
                    Tab(
                      height: 30.0,
                      child: Text(
                        "MY CONTEST",
                        maxLines: 2,
                        style: AppTextStyles.terniaryStyle(
                            10, AppColors.black, FontWeight.w500),
                      ),
                    ),
                    Tab(
                        height: 30.0,
                        child: Text(
                          "MY TEAMS",
                          style: AppTextStyles.terniaryStyle(
                              10, AppColors.black, FontWeight.w500),
                          maxLines: 2,
                        )),
                    Tab(
                      height: 30.0,
                      child: Text(
                        "STATS",
                        style: AppTextStyles.terniaryStyle(
                            10, AppColors.black, FontWeight.w500),
                        maxLines: 2,
                      ),
                    ),
                    Tab(
                      height: 30.0,
                      child: Text(
                        "SCORECARD",
                        style: AppTextStyles.terniaryStyle(
                            10, AppColors.black, FontWeight.w500),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return MyContestCard(
                            prize: 2500,
                            entry: 15,
                            teams: [
                              {
                                'captain': 'F kay',
                                'viceCaptain': 'F Mac',
                              },
                              {
                                'captain': 'F ackay',
                                'viceCaptain': 'Mackay',
                              },
                              {
                                'captain': 'F May',
                                'viceCaptain': 'F y',
                              },
                            ],
                            totalSpots: 800,
                            filledSpots: 300,
                            isFinished: true,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return MyTeamsCard();
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 37.5,
                      child: ListView(
                        physics: ClampingScrollPhysics(),
                        controller: scrollController1,
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 16),
                            width: width * 0.44,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "PLAYERS",
                              style: AppTextStyles.primaryStyle(
                                  14, Colors.black54, FontWeight.w500),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: width * 0.225,
                            child: Text(
                              "POINTS",

                              style: AppTextStyles.primaryStyle(
                                  14, Colors.black54, FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: width * .225,
                            child: Center(
                              child: Text(
                                "%SEL BY",
                                style: AppTextStyles.primaryStyle(
                                    14, AppColors.black, FontWeight.w500),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * .225,
                            child: Center(
                              child: Text(
                                "%C BY",
                                style: AppTextStyles.primaryStyle(
                                    14, AppColors.black, FontWeight.w500),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * .225,
                            child: Center(
                              child: Text(
                                "%C BY",
                                style: AppTextStyles.primaryStyle(
                                    14, AppColors.black, FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: ListView(
                        controller: scrollController2,
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          SizedBox(
                            width: width * 1.35,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: playerStats.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: index % 2 == 0 ? Colors.transparent : Color(0xfff8f8fe),
                                  ),
                                  height: 50,
                                  child: Row(
                                    children: [
                                      SizedBox(width: width * 0.04,),
                                      Image.asset(
                                        'assets/cricket-player.png',
                                        width: width * 0.1,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 5),
                                        width: width * 0.3,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            playerStats[index]['name'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: AppTextStyles.terniaryStyle(
                                                12, Colors.black, FontWeight.w500),
                                          ),
                                        ),
                                      ),

                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 5),
                                        width: width * 0.225,
                                        alignment: Alignment.center,
                                        child: Text(
                                          playerStats[0]['points'].toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: AppTextStyles.terniaryStyle(
                                              13, Colors.black, FontWeight.w600),
                                        ),
                                      ),

                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 5),
                                        width: width * 0.225,
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${playerStats[0]['slected by']}%',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: AppTextStyles.terniaryStyle(
                                              13, Colors.black54, FontWeight.w500),
                                        ),
                                      ),

                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 5),
                                        width: width * 0.225,
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${playerStats[0]['captain selected']}%',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: AppTextStyles.terniaryStyle(
                                              13, Colors.black54, FontWeight.w500),
                                        ),
                                      ),

                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 5),
                                        width: width * 0.225,
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${playerStats[0]['vice captain selected']}%',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: AppTextStyles.terniaryStyle(
                                              13, Colors.black54, FontWeight.w500),
                                        ),
                                      ),

                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),


                Text('data'),
              ],
            ),
          ),


        ],
      ),
    );
  }
}