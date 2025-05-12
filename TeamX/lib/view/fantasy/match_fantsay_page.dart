import 'package:auto_size_text/auto_size_text.dart';
import 'package:borders/borders.dart';
import 'package:flutter/material.dart';
import 'package:teamx/view/Fantasy/chosse_captain_and_vice_captian.dart';
import 'package:teamx/view/Fantasy/preview_players.dart';
import 'package:teamx/view/Fantasy/widgets/team_and_player_info.dart';

import '../../cards/glassmorphism_card.dart';
import '../../res/app_text_style.dart';
import '../../res/color.dart';
import '../../widgets/upcoming_matches.dart';

class MatchFantasyPage extends StatefulWidget {
  final String contestId;
  const MatchFantasyPage({Key? key, required this.contestId}) : super(key: key);

  @override
  State<MatchFantasyPage> createState() => _MatchFantasyPageState();
}

class _MatchFantasyPageState extends State<MatchFantasyPage>
    with SingleTickerProviderStateMixin {
  int count = 9;
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
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
          title: Text("Create Team",
              style: AppTextStyles.primaryStyle(
                  20.0, AppColors.white, FontWeight.w600)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChooseCaptainAndViceCaptain(
              batsmen: ['S Gill', 'R Sharma', 'V Kohli'],
              bowlers: [
                'MD Siraj',
                'Y Cahal',
                'P Cummins',
                'J Bumrah',
              ],
              allRounders: ['G Maxwell', 'R Jadeja'],
              wicketkeeper: ['K L Rahul', 'Q Decock'],
            ),
          ));
        },
        child: Container(
          height: 40,
          width: 130,
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
                Icons.remove_red_eye_outlined,
                color: Colors.white,
                size: 18,
              ),
              Text(" PREVIEW",
                  style: AppTextStyles.primaryStyle(
                      16.0, AppColors.white, FontWeight.w700)),
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
                Text(
                  "Maximum 10 Players from a team",
                  style: AppTextStyles.primaryStyle(
                      14.0, AppColors.white, FontWeight.w600),
                ),


                TeamAndPlayerInfo(),


                playersCounterBar(width),
              ],
            ),
          ),
          // ---- End of top Blue Container -----

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
                if (index == 3) {}
              },
              tabs: [
                Tab(
                  height: 30.0,
                  child: Text(
                    "WK",
                    maxLines: 2,
                    style: AppTextStyles.terniaryStyle(
                        14, AppColors.black, FontWeight.w500),
                  ),
                ),
                Tab(
                    height: 30.0,
                    child: Text(
                      "BAT",
                      style: AppTextStyles.terniaryStyle(
                          14, AppColors.black, FontWeight.w500),
                      maxLines: 2,
                    )),
                Tab(
                  height: 30.0,
                  child: Text(
                    "AR",
                    style: AppTextStyles.terniaryStyle(
                        14, AppColors.black, FontWeight.w500),
                    maxLines: 2,
                  ),
                ),
                Tab(
                  height: 30.0,
                  child: Text(
                    "BOWL",
                    style: AppTextStyles.terniaryStyle(
                        14, AppColors.black, FontWeight.w500),
                    maxLines: 2,
                  ),
                )
              ],
            ),
          ),

          const SizedBox(
            height: 5.0,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Select 1 - 8 Wicket Keepers",
                        style: AppTextStyles.terniaryStyle(
                            15, AppColors.black, FontWeight.w500),
                        maxLines: 2,
                      ),
                    ),
                    topBarPlayerTile(width),
                    buildPlayerTile(
                      width,
                      count,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Select 1 - 8 Batsman",
                        style: AppTextStyles.terniaryStyle(
                            15, AppColors.black, FontWeight.w500),
                        maxLines: 2,
                      ),
                    ),
                    topBarPlayerTile(width),
                    buildPlayerTile(width, 10),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Select 1 - 8 All Rounders",
                        style: AppTextStyles.terniaryStyle(
                            15, AppColors.black, FontWeight.w500),
                        maxLines: 2,
                      ),
                    ),
                    topBarPlayerTile(width),
                    buildPlayerTile(width, 5),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Select 1 - 8 Bowlers",
                        style: AppTextStyles.terniaryStyle(
                            15, AppColors.black, FontWeight.w500),
                        maxLines: 2,
                      ),
                    ),
                    topBarPlayerTile(width),
                    buildPlayerTile(width, 6),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }



  Container playersCounterBar(double width) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      width: width - 28,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: width - 65,
            height: 15.0,
            child: Row(
              children: List.generate(11, (index) {
                if (index < count) {
                  return Expanded(
                    child: Container(
                      alignment: Alignment.topCenter,
                      // width: 30,
                      decoration: ShapeDecoration(
                        color: Color(0xffE80F88),
                        shape: TrapeziumBorder(
                          side: const BorderSide(
                            color: Color(0xffE80F88),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(0),
                          borderOffset: const BorderOffset.diagonal(
                            tlbr: Offset(-6, 0),
                          ),
                        ),
                      ),
                      child: Text(
                        index == count - 1 ? count.toString() : "",
                        style: AppTextStyles.terniaryStyle(
                            10, Colors.white, FontWeight.w600),
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(
                      // width: 20,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: TrapeziumBorder(
                          side: const BorderSide(
                            color: Color(0xffE80F88),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(0),
                          borderOffset: const BorderOffset.diagonal(
                            tlbr: Offset(-6, 0),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              }),
            ),
          ),
          SizedBox(
            width: 13,
          ),
          Icon(
            Icons.remove_circle_outline_rounded,
            size: 24,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  Container topBarPlayerTile(double width) {
    return Container(
      color: Colors.white.withOpacity(0.5),
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Spacer(),
          Container(
            width: width * 0.25,
            margin: EdgeInsets.only(right: 16),
            padding: EdgeInsets.only(top: 1, bottom: 1, left: 1, right: 8),
            decoration: BoxDecoration(
                color: Color(0xfff8f8fe),
                border: Border.all(width: 1.5, color: Colors.white),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 2,
                      blurRadius: 20)
                ]),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: AppColors.cardBlue.withOpacity(0.2),
                      shape: BoxShape.circle),
                  margin: EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.edit_outlined,
                    size: 14,
                    color: AppColors.cardBlue,
                  ),
                ),
                AutoSizeText(
                  "POINTS",
                  minFontSize: 10,
                  maxFontSize: 14,
                  style: AppTextStyles.primaryStyle(
                      14, Colors.black54, FontWeight.w500),
                ),
              ],
            ),
          ),
          SizedBox(
            width: width * .15,
            child: Center(
              child: AutoSizeText(
                "CREDITS",
                minFontSize: 10,
                maxFontSize: 14,
                style: AppTextStyles.primaryStyle(
                    14, AppColors.black, FontWeight.w500),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Expanded buildPlayerTile(double width, int count) {
    return Expanded(
      child: ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            // margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.only(left: 4, top: 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white, width: 1),
              ),
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/cricket-player.png',
                  width: width * 0.125,
                ),
                SizedBox(width: 8),
                SizedBox(
                  width: width * 0.4,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'A Rossington',
                      style: AppTextStyles.terniaryStyle(
                          14, Colors.black, FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.2,
                  child: Center(
                    child: Text(
                      '120',
                      style: AppTextStyles.terniaryStyle(
                          14, Colors.black54, FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(
                  width: width * .135,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '7.5',
                      style: AppTextStyles.terniaryStyle(
                          14, Colors.black, FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  width: 7,
                ),
                Icon(
                  Icons.add_circle_outline_rounded,
                  color: AppColors.green,
                  size: 20,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class MyContestCard extends StatelessWidget {
  final String id;
  final int prize;
  final int entry;
  final int totalSpots;
  final int filledSpots;
  final List<Map<String, String>> teams;
  final bool isFinished;
  MyContestCard({
    super.key,
    required this.id,
    required this.prize,
    required this.entry,
    required this.totalSpots,
    required this.filledSpots,
    required this.teams,
    required this.isFinished,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MatchFantasyPage(contestId: id),
        ));
      },
      child: Container(
        child: Text(
          entry == 0 ? "FREE" : "\$${entry}",
          style: AppTextStyles.terniaryStyle(
              18, Colors.white, FontWeight.w700),
        ),
      ),
    );
  }
}