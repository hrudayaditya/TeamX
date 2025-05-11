import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teamx/view/Fantasy/complete_match_contest_details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../res/app_url.dart';

import '../../res/app_text_style.dart';
import '../../res/color.dart';
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

  List<dynamic> contests = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    fetchContests();
  }

  Future<void> fetchContests() async {
    final response = await http.get(Uri.parse(AppUrl.listContest));
    if (response.statusCode == 200) {
      setState(() {
        contests = jsonDecode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load contests')),
      );
    }
  }

  List<Map<String, dynamic>> getFreeContests() {
    return contests
        .where((c) => (c['data'][0]['entryFee'] ?? 0) == 0)
        .map((c) => c['data'][0] as Map<String, dynamic>)
        .toList();
  }

  List<Map<String, dynamic>> getMultiplierContests() {
    return contests
        .where((c) => (c['data'][0]['entryFee'] ?? 0) > 0)
        .map((c) => c['data'][0] as Map<String, dynamic>)
        .toList();
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
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CompleteMatchContestDetails(),
                  ));
                },
                child: Text("Contests",
                    style: AppTextStyles.primaryStyle(
                        20.0, AppColors.white, FontWeight.w600)),
              ),
              Spacer(),
              // Add wallet or other icons if needed
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: AppColors.primaryColor,
            labelColor: AppColors.primaryColor,
            dividerColor: Colors.transparent,
            indicatorWeight: 4,
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
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // --- CONTESTS TAB ---
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (getFreeContests().isNotEmpty)
                              ExpansionTile(
                                initiallyExpanded: true,
                                title: Text(
                                  "Free Contests",
                                  style: AppTextStyles.primaryStyle(16, Colors.black, FontWeight.bold),
                                ),
                                children: getFreeContests()
                                    .map((match) => AllContestCrad(
                                          prize: match['prizePool'] ?? 0,
                                          entry: match['entryFee'] ?? 0,
                                          totalSpots: match['totalSpots'] ?? 0,
                                          filledSpots: (match['totalSpots'] ?? 0) - (match['spotsLeft'] ?? 0),
                                          isFree: (match['entryFee'] ?? 0) == 0,
                                        ))
                                    .toList(),
                              ),
                            if (getMultiplierContests().isNotEmpty)
                              ExpansionTile(
                                initiallyExpanded: true,
                                title: Text(
                                  "Multiplier Contests",
                                  style: AppTextStyles.primaryStyle(16, Colors.black, FontWeight.bold),
                                ),
                                children: getMultiplierContests()
                                    .map((match) => AllContestCrad(
                                          prize: match['prizePool'] ?? 0,
                                          entry: match['entryFee'] ?? 0,
                                          totalSpots: match['totalSpots'] ?? 0,
                                          filledSpots: (match['totalSpots'] ?? 0) - (match['spotsLeft'] ?? 0),
                                          isFree: (match['entryFee'] ?? 0) == 0,
                                        ))
                                    .toList(),
                              ),
                            // Add more collapsible sections as needed
                          ],
                        ),
                      ),
                // --- MY CONTESTS TAB ---
                buildMyContest(width),
                // --- MY TEAMS TAB ---
                myTeams(width),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Dummy implementations for other tabs
  Column buildMyContest(double width) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return MyContestCard(
                prize: 850,
                entry: 15,
                teams: [
                  {'captain': 'F kay', 'viceCaptain': 'F Mac'},
                  {'captain': 'F ackay', 'viceCaptain': 'Mackay'},
                ],
                totalSpots: 2500,
                filledSpots: 800,
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