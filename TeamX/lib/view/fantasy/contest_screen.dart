import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teamx/view/Fantasy/complete_match_contest_details.dart';
import 'package:teamx/view/Fantasy/view_all_contest.dart';

import '../../res/app_text_style.dart';
import '../../res/color.dart';
import '../Fantasy/fantasy_points_system.dart';
import 'match_fantsay_page.dart';
import 'widgets/all_contest_card.dart';
import 'widgets/my_contest_card.dart';
import 'widgets/my_teams_card.dart';

class ContestScreen extends StatefulWidget {
  const ContestScreen({Key? key}) : super(key: key);

  @override
  State<ContestScreen> createState() => _ContestScreenState();
}

class _ContestScreenState extends State<ContestScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int teamCount = 0;
  int prizePool = 850;
  int entry = 15;
  int totalSpots = 2500;
  int filledSpots = 800;
  List<Map<String, String>> teams = [
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
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
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
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CompleteMatchContestDetails(),
                  ));
                },
                child: Text("USA vs AUS",
                    style: AppTextStyles.primaryStyle(
                        20.0, AppColors.white, FontWeight.w600)),
              ),
              Spacer(),

              Image.asset(
                color: Colors.white,
                'assets/wallet.png',
                height: 32,
              ),

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
                color: Color(0xfff8f8fe),
                border: Border.all(width: 1.5, color: Colors.white),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 2,
                      blurRadius: 20)
                ]),
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.primaryColor,
              labelColor: AppColors.primaryColor,
              dividerColor: Colors.transparent,
              indicatorWeight: 4,
              onTap: (index) {
                if (index == 0) {}
                if (index == 1) {}
                if (index == 2) {}
              },
              tabs: [
                Tab(
                  height: 30.0,
                  child: Text(
                    "CONTESTS",
                    maxLines: 2,
                    style: AppTextStyles.terniaryStyle(
                        12, AppColors.black, FontWeight.w500),
                  ),
                ),
                Tab(
                    height: 30.0,
                    child: Text(
                      "MY CONTESTS",
                      style: AppTextStyles.terniaryStyle(
                          12, AppColors.black, FontWeight.w500),
                      maxLines: 2,
                    )),
                Tab(
                  height: 30.0,
                  child: Text(
                    "MY TEAMS",
                    style: AppTextStyles.terniaryStyle(
                        12, AppColors.black, FontWeight.w500),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                AllContests(width),
                buildMyContest(width),
                teamCount == 0
                    ? Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20.0),
                      Image.asset(
                        'assets/compass.png',
                        height: 100.0,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "You haven't Created any teams yet!",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.terniaryStyle(
                            14.0, AppColors.black, FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Create now and stay on the rise",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.terniaryStyle(
                            12.5, Colors.black54, FontWeight.w600),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 40,
                        width: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Color(0xff191D88),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 2,
                                  blurRadius: 20,
                                  offset: Offset(0, 5))
                            ]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.wine_bar_outlined,
                              color: Colors.white,
                              size: 18,
                            ),
                            Text(" Create One",
                                style: AppTextStyles.primaryStyle(16.0,
                                    AppColors.white, FontWeight.w700)),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                    : myTeams(width),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget AllContests(double width) {
    return SingleChildScrollView(
      child: Column(
        children: [
          freeContests(),


          Container(
            color: Colors.white,
            height: 8,
          ),
          multiplierContest(),



          Container(
            color: Colors.white,
            height: 8,
          ),

          comeBackContest(),
        ],
      ),
    );
  }

  Column freeContests() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ViewAllContest(
                  contest: [
                    {
                      'entry': 25,
                      'prize': 15000,
                      'isFree': true,
                      'totalSpots': 850,
                      'filled': 100,
                    },
                    {
                      'entry': 25,
                      'prize': 15000,
                      'isFree': true,
                      'totalSpots': 850,
                      'filled': 100,
                    },
                    {
                      'entry': 25,
                      'prize': 15000,
                      'isFree': true,
                      'totalSpots': 850,
                      'filled': 100,
                    }
                  ],
                  contestType: 'Free Contests',
                )));
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Compete for FREE",
                        style: AppTextStyles.primaryStyle(
                            20.0, AppColors.black, FontWeight.w700)),
                    Text("Up to \$15 Free entry's just for you!",
                        style: AppTextStyles.primaryStyle(
                            14.0, Colors.black54, FontWeight.w500)),
                  ],
                ),
                Spacer(),
                Text("View All  >",
                    style: AppTextStyles.terniaryStyle(
                        15.0, Colors.black87, FontWeight.w600)),
              ],
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return AllContestCrad(
              prize: 25000,
              entry: 25,
              totalSpots: 2500,
              filledSpots: 300,
              isFree: true,
            );
          },
        ),
      ],
    );
  }

  Column multiplierContest() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ViewAllContest(
                  contest: [
                    {
                      'entry': 25,
                      'prize': 15000,
                      'isFree': false,
                      'totalSpots': 850,
                      'filled': 100,
                    },
                    {
                      'entry': 25,
                      'prize': 15000,
                      'isFree': false,
                      'totalSpots': 850,
                      'filled': 100,
                    },
                    {
                      'entry': 25,
                      'prize': 15000,
                      'isFree': false,
                      'totalSpots': 850,
                      'filled': 100,
                    }
                  ],
                  contestType: 'Multiplier Contests',
                )));
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Text("Multiplier Contests",
                    style: AppTextStyles.primaryStyle(
                        20.0, AppColors.black, FontWeight.w700)),
                Spacer(),
                Text("View All  >",
                    style: AppTextStyles.terniaryStyle(
                        15.0, Colors.black87, FontWeight.w600)),
              ],
            ),
          ),
        ),

        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return AllContestCrad(
              prize: 25000,
              entry: 50,
              isFree: false,
              totalSpots: 2500,
              filledSpots: 300,
            );
          },
        ),
      ],
    );
  }

  Widget comeBackContest() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ViewAllContest(
                  contest: [
                    {
                      'entry': 25,
                      'prize': 15000,
                      'isFree': false,
                      'totalSpots': 850,
                      'filled': 100,
                    },
                    {
                      'entry': 25,
                      'prize': 15000,
                      'isFree': false,
                      'totalSpots': 850,
                      'filled': 100,
                    },
                    {
                      'entry': 25,
                      'prize': 15000,
                      'isFree': false,
                      'totalSpots': 850,
                      'filled': 100,
                    }
                  ],
                  contestType: 'Comeback Contests',
                )));
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Text("Comeback Contests",
                    style: AppTextStyles.primaryStyle(
                        20.0, AppColors.black, FontWeight.w700)),
                Spacer(),
                Text("View All  >",
                    style: AppTextStyles.terniaryStyle(
                        15.0, Colors.black87, FontWeight.w600)),
              ],
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return AllContestCrad(
              prize: 25000,
              entry: 50,
              isFree: false,
              totalSpots: 2500,
              filledSpots: 300,
            );
          },
        ),
      ],
    );
  }

  Column buildMyContest(double width) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return MyContestCard(
                prize: prizePool,
                entry: entry,
                teams: teams,
                totalSpots: totalSpots,
                filledSpots: filledSpots,
                isFinished: false,
              );
            },
          ),
        ),
      ],
    );
  }

  Column myTeams(double width) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return MyTeamsCard();
            },
          ),
        ),
      ],
    );
  }
}