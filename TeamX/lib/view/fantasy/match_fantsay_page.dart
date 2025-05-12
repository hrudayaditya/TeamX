import 'package:auto_size_text/auto_size_text.dart';
import 'package:borders/borders.dart';
import 'package:flutter/material.dart';
import 'package:teamx/view/Fantasy/chosse_captain_and_vice_captian.dart';
import 'package:teamx/view/Fantasy/preview_players.dart';
import 'package:teamx/view/Fantasy/widgets/team_and_player_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../cards/glassmorphism_card.dart';
import '../../res/app_text_style.dart';
import '../../res/color.dart';
import '../../widgets/upcoming_matches.dart';
import '../../res/app_url.dart';

class MatchFantasyPage extends StatefulWidget {
  final String contestId;
  const MatchFantasyPage({Key? key, required this.contestId}) : super(key: key);

  @override
  State<MatchFantasyPage> createState() => _MatchFantasyPageState();
}

class _MatchFantasyPageState extends State<MatchFantasyPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<dynamic> wicketKeepers = [];
  List<dynamic> batsmen = [];
  List<dynamic> allRounders = [];
  List<dynamic> bowlers = [];
  bool isLoading = true;

  int count = 9;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    fetchPlayers();
  }

  Future<void> fetchPlayers() async {
    final url = "${AppUrl.getPlayers}/${widget.contestId}";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> players = jsonDecode(response.body);
      setState(() {
        wicketKeepers = players.where((p) {
          final role = (p['role']?.toLowerCase() ?? '');
          return role == 'wk' || role.contains('wicket');
        }).toList();
        batsmen = players.where((p) {
          final role = (p['role']?.toLowerCase() ?? '');
          return role == 'batsman' || role == 'bat';
        }).toList();
        allRounders = players.where((p) {
          final role = (p['role']?.toLowerCase() ?? '');
          return role == 'allrounder' || role == 'all-rounder' || role.contains('all');
        }).toList();
        bowlers = players.where((p) {
          final role = (p['role']?.toLowerCase() ?? '');
          return role == 'bowler' || role == 'bowl';
        }).toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      // Optionally show error
    }
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
            color: Colors.white,
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
              batsmen: batsmen.map((p) => p['name'] as String).toList(),
              bowlers: bowlers.map((p) => p['name'] as String).toList(),
              allRounders: allRounders.map((p) => p['name'] as String).toList(),
              wicketkeeper: wicketKeepers.map((p) => p['name'] as String).toList(),
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
                // WK
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
                    Expanded(
                      child: isLoading
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: wicketKeepers.length,
                              itemBuilder: (context, index) =>
                                  playerTile(wicketKeepers[index], width),
                            ),
                    ),
                  ],
                ),
                // BAT
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
                    Expanded(
                      child: isLoading
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: batsmen.length,
                              itemBuilder: (context, index) =>
                                  playerTile(batsmen[index], width),
                            ),
                    ),
                  ],
                ),
                // AR
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
                    Expanded(
                      child: isLoading
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: allRounders.length,
                              itemBuilder: (context, index) =>
                                  playerTile(allRounders[index], width),
                            ),
                    ),
                  ],
                ),
                // BOWL
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
                    Expanded(
                      child: isLoading
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: bowlers.length,
                              itemBuilder: (context, index) =>
                                  playerTile(bowlers[index], width),
                            ),
                    ),
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
                AutoSizeText(
                  "Style",
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

  Widget playerTile(dynamic player, double width) {
    return Container(
      padding: EdgeInsets.only(left: 4, top: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white, width: 1),
        ),
      ),
      child: Row(
        children: [
          Image.network(
            player['playerImg'] ?? '',
            width: width * 0.125,
            errorBuilder: (_, __, ___) => Icon(Icons.person),
          ),
          SizedBox(width: 8),
          SizedBox(
            width: width * 0.4,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                player['name'] ?? '',
                style: AppTextStyles.terniaryStyle(
                    14, Colors.black, FontWeight.w500),
              ),
            ),
          ),
          SizedBox(
            width: width * 0.2,
            child: Center(
              child: Text(
                player['battingStyle'] ?? '',
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
                player['credit']?.toString() ?? '',
                style: AppTextStyles.terniaryStyle(
                    14, Colors.black, FontWeight.w600),
              ),
            ),
          ),
          SizedBox(width: 7),
          Icon(
            Icons.add_circle_outline_rounded,
            color: AppColors.green,
            size: 20,
          )
        ],
      ),
    );
  }
}