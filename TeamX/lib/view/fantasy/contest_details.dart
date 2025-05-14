import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../res/app_text_style.dart';
import '../../res/color.dart';
import '../../res/app_url.dart';
import 'complete_match_contest_details.dart';
import 'fantasy_points_system.dart';
import 'match_fantsay_page.dart';

/// Screen that displays detailed information about a fantasy sports contest
///
/// This screen shows:
/// 1. Contest overview and prize pool
/// 2. Team lineups and player statistics
/// 3. Match status and live updates
/// 4. User's team performance
/// 5. Leaderboard and rankings

class ContestDetailsScreen extends StatefulWidget {
  final String id;
  final dynamic contest; // fallback contest details if needed

  const ContestDetailsScreen(
      {Key? key, required this.id, required this.contest})
      : super(key: key);

  @override
  State<ContestDetailsScreen> createState() => _ContestDetailsScreenState();
}

class _ContestDetailsScreenState extends State<ContestDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isFree = true; // Example flag to show FREE or price

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Fetch contest details from the backend.
  // URL format: http://192.168.1.30:8080/contests/{contestId}
  Future<Map<String, dynamic>> _fetchContestDetails() async {
    final url = "http://192.168.1.30:8080/contests/" + widget.id;
    // Print the URL for debugging.
    print("Fetching contest details from: $url");
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print("Contest details response: " + response.body);
      final jsonData = jsonDecode(response.body);
      return jsonData; // Expected structure: { "id": ..., "data": [ { contest details } ] }
    } else {
      throw Exception("Failed to fetch contest details");
    }
  }

  // Fetch points data from the API endpoint.
  Future<List<Map<String, dynamic>>> _fetchPoints() async {
    final url = AppUrl.getPoints + '/contest/' + widget.id;
    print("Fetching points from: $url");
    final response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<dynamic> points = jsonData['points'];
      return points.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception("Failed to fetch points");
    }
  }

  // Build a fill bar showing the ratio of spots left to total spots.
  Container spotsFillBar(double width, int spotsLeft, int totalSpots) {
    final barWidth = width - 35; // Available width for the bar.
    final fraction =
        totalSpots > 0 ? ((totalSpots - spotsLeft) / totalSpots) : 0.0;
    final fillWidth = barWidth * fraction;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: barWidth,
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5),
      ),
      height: 5,
      child: Stack(
        children: [
          Container(
            width: fillWidth,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            height: 5,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchContestDetails(),
      builder: (context, contestSnapshot) {
        if (contestSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (contestSnapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                'Error: ${contestSnapshot.error}',
                style: AppTextStyles.primaryStyle(
                    16, Colors.black54, FontWeight.w500),
              ),
            ),
          );
        }
        // Extract contest details from fetched data.
        final contestDetails = contestSnapshot.data!;
        // Use the first element of "data" if available; otherwise fallback.
        final contestData = (contestDetails['data'] != null &&
                contestDetails['data'].isNotEmpty)
            ? contestDetails['data'][0] as Map<String, dynamic>
            : widget.contest;

        // Extract header values.
        final contestName = contestData['name'] ?? "Contest";
        final prizePool = contestData['prizePool'] ?? 0;
        final entryFee = contestData['entryFee'] ?? 0;
        final totalSpots = contestData['totalSpots'] ?? 0;
        final spotsLeft = contestData['spotsLeft'] ?? totalSpots;

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
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CompleteMatchContestDetails(),
                      ));
                    },
                    child: Text(
                      "Current Stats",
                      style: AppTextStyles.primaryStyle(
                          20.0, AppColors.white, FontWeight.w600),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/walletPage');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      // decoration: BoxDecoration(
                      //   border: Border.all(width: 1.75, color: Colors.white),
                      //   shape: BoxShape.circle,
                      // ),
                      child: Image.asset(
                        'assets/wallet.png',
                        color: Colors.white,
                        height: 32,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FantasyPointsSystem(),
                      ));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.75, color: Colors.white),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        "PTS",
                        style: AppTextStyles.terniaryStyle(
                            10.0, AppColors.white, FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              // Top contest info section using fetched contestData.
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 14, right: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Max Prize Pool",
                            style: AppTextStyles.primaryStyle(
                                14.0, Colors.black54, FontWeight.w500)),
                        const SizedBox(height: 2),
                        Text("\$${prizePool}",
                            style: AppTextStyles.terniaryStyle(
                                22.0, Colors.black, FontWeight.w700)),
                        spotsFillBar(width, spotsLeft, totalSpots),
                        Row(
                          children: [
                            Text("${spotsLeft} spots left",
                                style: AppTextStyles.primaryStyle(14.0,
                                    const Color(0x80191d88), FontWeight.w500)),
                            const Spacer(),
                            Text("$totalSpots spots",
                                style: AppTextStyles.primaryStyle(
                                    14.0, Colors.black54, FontWeight.w500)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MatchFantasyPage(
                                contestId: widget.id,
                                contest: contestData,
                              ),
                            ));
                          },
                          child: Container(
                            width: width,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 16),
                            decoration: BoxDecoration(
                              color: AppColors.green,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              isFree ? "FREE" : "\$${entryFee}",
                              style: AppTextStyles.terniaryStyle(
                                  18, Colors.white, FontWeight.w700),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      border: Border(
                        top: BorderSide(width: 0.5, color: Colors.white),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.black54, width: 1)),
                          child: const Icon(Icons.wine_bar_outlined,
                              color: Colors.black54, size: 11),
                        ),
                        Text("  45%",
                            style: AppTextStyles.primaryStyle(
                                12.0, Colors.black54, FontWeight.w500)),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.black54, width: 1)),
                          child: Text("M",
                              style: AppTextStyles.primaryStyle(
                                  11.0, Colors.black54, FontWeight.w500)),
                        ),
                        Text("  Upto 11",
                            style: AppTextStyles.primaryStyle(
                                12.0, Colors.black54, FontWeight.w500)),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.black54, width: 1)),
                          child: const Icon(Icons.currency_rupee,
                              color: Colors.black54, size: 11),
                        ),
                        Text("  Flexible",
                            style: AppTextStyles.primaryStyle(
                                12.0, Colors.black54, FontWeight.w500)),
                      ],
                    ),
                  ),
                ],
              ),
              // TabBar section.
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xfff8f8fe),
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
                      tabs: [
                        Tab(
                          height: 30.0,
                          child: Text(
                            "Winnings",
                            maxLines: 2,
                            style: AppTextStyles.terniaryStyle(
                                14, AppColors.black, FontWeight.w500),
                          ),
                        ),
                        // Tab(
                        //   height: 30.0,
                        //   child: Text(
                        //     "Leaderboard",
                        //     maxLines: 2,
                        //     style: AppTextStyles.terniaryStyle(14, AppColors.black, FontWeight.w500),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              // TabBarView for "Winnings" and "Leaderboard."
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Winnings Tab: Use FutureBuilder to display points.
                    FutureBuilder<List<Map<String, dynamic>>>(
                      future: _fetchPoints(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}',
                                  style: AppTextStyles.primaryStyle(
                                      16, Colors.black54, FontWeight.w500)));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(
                              child: Text('No points data available',
                                  style: AppTextStyles.primaryStyle(
                                      16, Colors.black54, FontWeight.w500)));
                        }
                        final pointsList = snapshot.data!;
                        final totalPoints = pointsList.fold<int>(
                          0,
                          (sum, item) => sum + (item['point'] as num).toInt(),
                        );
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              // Total Points Card.
                              Container(
                                padding: const EdgeInsets.all(16),
                                margin: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Points",
                                        style: AppTextStyles.primaryStyle(18,
                                            AppColors.black, FontWeight.bold)),
                                    Text("$totalPoints",
                                        style: AppTextStyles.terniaryStyle(
                                            18,
                                            AppColors.primaryColor,
                                            FontWeight.bold)),
                                  ],
                                ),
                              ),
                              // List of individual point items.
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: pointsList.length,
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                        height: 1, color: Colors.grey),
                                itemBuilder: (context, index) {
                                  final pointItem = pointsList[index];
                                  return ListTile(
                                    title: Text(
                                      pointItem['type'],
                                      style: AppTextStyles.primaryStyle(
                                          16, AppColors.black, FontWeight.w500),
                                    ),
                                    trailing: Text(
                                      "${pointItem['point']}",
                                      style: AppTextStyles.terniaryStyle(
                                          16,
                                          AppColors.primaryColor,
                                          FontWeight.bold),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    // Leaderboard Tab: Placeholder content.
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Center(
                              child: Text("Leaderboard content goes here",
                                  style: AppTextStyles.primaryStyle(
                                      16, Colors.black54, FontWeight.w500))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
