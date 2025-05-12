import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:teamx/res/app_text_style.dart';
import 'package:teamx/res/color.dart';
import 'package:teamx/utils/utils.dart';
import 'widgets/all_contest_card.dart';
import 'widgets/my_contest_card.dart';
import 'widgets/my_teams_card.dart';
import 'contest_details.dart';
import '../../res/app_url.dart';

class ContestScreen extends StatefulWidget {
  const ContestScreen({Key? key}) : super(key: key);

  @override
  State<ContestScreen> createState() => _ContestScreenState();
}

class _ContestScreenState extends State<ContestScreen>
    with SingleTickerProviderStateMixin, RouteAware {
  late TabController _tabController;

  // For public contests (CONTESTS tab)
  List<dynamic> contests = [];
  bool isLoading = true;

  // For combined contest & team data for current user (MY CONTESTS and MY TEAMS tabs)
  List<dynamic> myContests = [];
  bool isMyContestsLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // When tab changes, re-fetch the appropriate data.
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        if (_tabController.index == 0) {
          fetchContests();
        } else if (_tabController.index == 1 || _tabController.index == 2) {
          fetchMyContests();
        }
      }
    });
    // Initial data load.
    fetchContests();
    fetchMyContests();
  }

  // Public contests GET request.
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
          const SnackBar(content: Text('Failed to load contests')));
    }
  }

  // GET request for combined contest and team list for current user.
  Future<void> fetchMyContests() async {
    try {
      final utils = Utils();
      final email = await utils.fetchDataSecure('email');
      final url = Uri.parse('${AppUrl.viewTeam}?userEmail=$email');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          myContests = jsonDecode(response.body);
          isMyContestsLoading = false;
        });
      } else {
        setState(() {
          isMyContestsLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to load your contests')));
      }
    } catch (e) {
      setState(() {
        isMyContestsLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  // For filtering public contests.
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

  // Build MY TEAMS tab using the fetched response data.
  Column buildMyTeams(double width) {
    List<Widget> teamCards = [];
    // Iterate through each contest entry.
    for (var contestEntry in myContests) {
      // Use the contest name as a basis for team title.
      final contest = contestEntry['contest'] as Map<String, dynamic>;
      final contestData = (contest['data'] != null && contest['data'].isNotEmpty)
          ? contest['data'][0] as Map<String, dynamic>
          : {};
      final contestName = contestData['name'] ?? "Contest";
      // Get teams array.
      final teams = contestEntry['teams'] as List<dynamic>? ?? [];
      for (int i = 0; i < teams.length; i++) {
        final team = teams[i];
        // Extract captain and viceCaptain names from the team details.
        final captain = team['captain']?['name'] ?? "N/A";
        final viceCaptain = team['viceCaptain']?['name'] ?? "N/A";
        // Since the API does not provide roleStats, we’ll use default values.
        final roleStats = {"WK": 0, "BAT": 0, "AR": 0, "BOWL": 0};
        // Build a team name by combining contest name and team index.
        final teamName = "$contestName (Team ${i + 1})";
        teamCards.add(MyTeamsCard(
          teamName: teamName,
          captain: captain,
          viceCaptain: viceCaptain,
          roleStats: roleStats,
        ));
      }
    }
    if (teamCards.isEmpty) {
      return Column(
        children: [
          SizedBox(height: 50),
          Center(child: Text("No teams found", style: AppTextStyles.primaryStyle(16, Colors.black, FontWeight.w600))),
        ],
      );
    }
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: teamCards,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffeef0fc),
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, AppBar().preferredSize.height),
        child: AppBar(
          iconTheme: const IconThemeData(size: 20, color: Colors.white),
          backgroundColor: const Color(0xff191D88),
          elevation: 1.0,
          title: Row(
            children: [
              Text("Contests", style: AppTextStyles.primaryStyle(20.0, AppColors.white, FontWeight.w600)),
              const Spacer(),
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
                child: Text("CONTESTS", maxLines: 2, style: AppTextStyles.terniaryStyle(12, AppColors.black, FontWeight.w500)),
              ),
              Tab(
                height: 30.0,
                child: Text("MY CONTESTS", maxLines: 2, style: AppTextStyles.terniaryStyle(12, AppColors.black, FontWeight.w500)),
              ),
              Tab(
                height: 30.0,
                child: Text("MY TEAMS", maxLines: 2, style: AppTextStyles.terniaryStyle(12, AppColors.black, FontWeight.w500)),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // CONTESTS TAB
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                        onRefresh: fetchContests,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (getFreeContests().isNotEmpty)
                                ExpansionTile(
                                  initiallyExpanded: true,
                                  title: Text("Free Contests", style: AppTextStyles.primaryStyle(16, Colors.black, FontWeight.bold)),
                                  children: getFreeContests().map((match) {
                                    final contestObj = contests.firstWhere(
                                      (c) => c['data'][0]['name'] == match['name'],
                                      orElse: () => null,
                                    );
                                    final contestId = contestObj != null ? contestObj['id'] : '';
                                    return AllContestCrad(
                                      id: contestId,
                                      prize: match['prizePool'] ?? 0,
                                      entry: match['entryFee'] ?? 0,
                                      totalSpots: match['totalSpots'] ?? 0,
                                      filledSpots: (match['totalSpots'] ?? 0) - (match['spotsLeft'] ?? 0),
                                      isFree: (match['entryFee'] ?? 0) == 0,
                                      matchName: match['name'] ?? '',
                                      venue: match['venue'] ?? '',
                                      date: match['date'] ?? '',
                                      status: match['status'] ?? '',
                                      teamInfo: match['teamInfo'] ?? [],
                                    );
                                  }).toList(),
                                ),
                              if (getMultiplierContests().isNotEmpty)
                                ExpansionTile(
                                  initiallyExpanded: true,
                                  title: Text("Multiplier Contests", style: AppTextStyles.primaryStyle(16, Colors.black, FontWeight.bold)),
                                  children: getMultiplierContests().map((match) {
                                    final contestObj = contests.firstWhere(
                                      (c) => c['data'][0]['name'] == match['name'],
                                      orElse: () => null,
                                    );
                                    final contestId = contestObj != null ? contestObj['id'] : '';
                                    return AllContestCrad(
                                      id: contestId,
                                      prize: match['prizePool'] ?? 0,
                                      entry: match['entryFee'] ?? 0,
                                      totalSpots: match['totalSpots'] ?? 0,
                                      filledSpots: (match['totalSpots'] ?? 0) - (match['spotsLeft'] ?? 0),
                                      isFree: (match['entryFee'] ?? 0) == 0,
                                      matchName: match['name'] ?? '',
                                      venue: match['venue'] ?? '',
                                      date: match['date'] ?? '',
                                      status: match['status'] ?? '',
                                      teamInfo: match['teamInfo'] ?? [],
                                    );
                                  }).toList(),
                                ),
                            ],
                          ),
                        ),
                      ),
                // MY CONTESTS TAB (using the GET response from fetchMyContests)
                isMyContestsLoading
                    ? const Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                        onRefresh: fetchMyContests,
                        child: SingleChildScrollView(
                          child: Column(
                            children: myContests.map((contestEntry) {
                              final contest = contestEntry['contest'] as Map<String, dynamic>;
                              final teams = contestEntry['teams'] as List<dynamic>;
                              final contestData = (contest['data'] != null && contest['data'].isNotEmpty)
                                  ? contest['data'][0] as Map<String, dynamic>
                                  : {};
                              final id = contest['id'] as String? ?? '';
                              final prize = contestData['prizePool'] as int? ?? 0;
                              final entryFee = contestData['entryFee'] as int? ?? 0;
                              final totalSpots = contestData['totalSpots'] as int? ?? 0;
                              final spotsLeft = contestData['spotsLeft'] as int? ?? totalSpots;
                              final filledSpots = totalSpots - spotsLeft;
                              final isFinished = (contestData['matchEnded'] as bool?) ?? false;
                              return MyContestCard(
                                id: id,
                                prize: prize,
                                entry: entryFee,
                                totalSpots: totalSpots,
                                filledSpots: filledSpots,
                                teams: teams.map<Map<String, String>>((t) {
                                  return {
                                    "captain": (t['captain']?['name'] ?? 'N/A').toString(),
                                    "viceCaptain": (t['viceCaptain']?['name'] ?? 'N/A').toString(),
                                  };
                                }).toList(),
                                isFinished: isFinished,
                                contest: contest,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                // MY TEAMS TAB (using the fetched myContests data)
                isMyContestsLoading
                    ? const Center(child: CircularProgressIndicator())
                    : buildMyTeams(width),
              ],
            ),
          ),
        ],
      ),
    );
  }
}