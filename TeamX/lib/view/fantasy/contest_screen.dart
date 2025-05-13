import 'dart:async';
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
  
  Timer? _contestTimer;

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

    // Set up periodic fetch for contests every 10 minutes.
    _contestTimer = Timer.periodic(const Duration(minutes: 10), (timer) {
      fetchContests();
    });
  }

  @override
  void dispose() {
    _contestTimer?.cancel();
    _tabController.dispose();
    super.dispose();
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
  
  Map<String, int> _countRoleStats(List<dynamic> players) {
    final Map<String, int> counts = {"WK": 0, "BAT": 0, "AR": 0, "BOWL": 0};
    for (var player in players) {
      final role = player['role'];
      if (role == "WK") {
        counts["WK"] = counts["WK"]! + 1;
      } else if (role == "Batsman") {
        counts["BAT"] = counts["BAT"]! + 1;
      } else if (role == "Allrounder") {
        counts["AR"] = counts["AR"]! + 1;
      } else if (role == "Bowler") {
        counts["BOWL"] = counts["BOWL"]! + 1;
      }
    }
    return counts;
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
    for (var contestEntry in myContests) {
      final contest = contestEntry['contest'] as Map<String, dynamic>;
      final contestData = (contest['data'] != null && contest['data'].isNotEmpty)
          ? contest['data'][0] as Map<String, dynamic>
          : {};
      final contestName = contestData['name'] ?? "Contest";
      // Get teams array.
      final teams = contestEntry['teams'] as List<dynamic>? ?? [];
      // Extract teamInfo if available.
      final teamInfo = contestData['teamInfo'] as List<dynamic>? ?? [];
      for (int i = 0; i < teams.length; i++) {
        final team = teams[i];
        final captain = team['captain']?['name'] ?? "N/A";
        final viceCaptain = team['viceCaptain']?['name'] ?? "N/A";
        final players = team['players'] as List<dynamic>? ?? [];
        final roleStats = _countRoleStats(players);
        // Choose team image from teamInfo (if available).
        String teamImg = "";
        if (teamInfo.isNotEmpty && teamInfo.length > i) {
          teamImg = teamInfo[i]['img'] ?? "";
        }
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
          const SizedBox(height: 50),
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
          backgroundColor: const Color.fromARGB(255, 72, 133, 190),
          elevation: 1.0,
          title: Row(
            children: [
              // Logoff button: clear secure storage values and navigate to login screen.
              IconButton(
                icon: const Icon(Icons.logout, color: Colors.white),
                onPressed: () async {
                  await Utils().secureStorage.write(key: 'jwt', value: '');
                  await Utils().secureStorage.write(key: 'email', value: '');
                  await Utils().secureStorage.write(key: 'username', value: '');
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login', // Ensure this route is defined in your main.dart
                    (route) => false,
                  );
                },
              ),
              const SizedBox(width: 8),
              Text("My TeamX", style: AppTextStyles.primaryStyle(20.0, AppColors.white, FontWeight.w600)),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.stars, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, '/fantasyPointsSystem');
                },
              ),
              IconButton(
                icon: Image.asset(
                  'assets/wallet.png', // Ensure this file exists and is properly listed in pubspec.yaml
                  width: 24,
                  height: 24,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/walletPage');
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Total count of contests displayed at the top
          Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Text(
              "Total Contests: ${contests.length}",
              style: AppTextStyles.primaryStyle(16, Colors.black, FontWeight.bold),
            ),
          ),
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
