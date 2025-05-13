import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teamx/res/app_url.dart';
import 'package:teamx/utils/utils.dart';
import 'package:teamx/view/Fantasy/contest_details.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../res/app_text_style.dart';
import '../../../res/color.dart';
import '../match_fantsay_page.dart';

// You can add this helper function or import it from your wallet_service.dart file
Future<double> fetchWalletAmount() async {
  final utils = Utils();
  final email = await utils.fetchDataSecure('email');
  final url = "${AppUrl.wallet}?email=$email"; 
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return (data['wallet'] as num).toDouble();
  } else {
    throw Exception("Failed to fetch wallet amount: ${response.statusCode}");
  }
}

class AllContestCrad extends StatelessWidget {
  final String id;
  final int prize;
  final int entry;
  final int totalSpots;
  final int filledSpots;
  final bool isFree;
  final String matchName;
  final String venue;
  final String date;
  final String status;
  final List<dynamic> teamInfo;
  final VoidCallback? onDelete;  // Callback to refresh contests after deletion

  const AllContestCrad({
    super.key,
    required this.id,
    required this.prize,
    required this.entry,
    required this.totalSpots,
    required this.filledSpots,
    required this.isFree,
    required this.matchName,
    required this.venue,
    required this.date,
    required this.status,
    required this.teamInfo,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double percentFilled = totalSpots == 0 ? 0 : filledSpots / totalSpots;
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ContestDetailsScreen(
                  id: id,
                  contest: {
                    "id": id,
                    "prize": prize,
                    "entryFee": entry,
                    "totalSpots": totalSpots,
                    "filledSpots": filledSpots,
                    "isFree": isFree,
                    "matchName": matchName,
                    "venue": venue,
                    "date": date,
                    "status": status,
                    "teamInfo": teamInfo,
                  },
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [
                    Color(0xffd4dffc),
                    Color(0xbff0f3fe),
                    Color(0x80f0f3fe),
                    Color(0xfff0f3fe),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter),
              color: const Color(0xfff8f8fe),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1.5, color: Colors.white),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 2,
                    blurRadius: 20)
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Match Info Header ---
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      if (teamInfo.isNotEmpty)
                        Image.network(
                          teamInfo[0]['img'],
                          width: 32,
                          height: 32,
                          errorBuilder: (_, __, ___) => const Icon(Icons.sports_cricket),
                        ),
                      const SizedBox(width: 8),
                      const Text('vs', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      if (teamInfo.length > 1)
                        Image.network(
                          teamInfo[1]['img'],
                          width: 32,
                          height: 32,
                          errorBuilder: (_, __, ___) => const Icon(Icons.sports_cricket),
                        ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(matchName, style: AppTextStyles.primaryStyle(14, Colors.black, FontWeight.bold)),
                            Text(date, style: AppTextStyles.primaryStyle(12, Colors.grey, FontWeight.normal)),
                            Text(venue, style: AppTextStyles.primaryStyle(12, Colors.grey, FontWeight.normal)),
                            Text(status, style: AppTextStyles.primaryStyle(12, Colors.blueGrey, FontWeight.normal)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // --- Contest Info ---
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 14, right: 14),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Max Prize Pool", style: AppTextStyles.primaryStyle(14.0, Colors.black54, FontWeight.w500)),
                          const Spacer(),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Entry:   ',
                              style: AppTextStyles.primaryStyle(14.0, Colors.black54, FontWeight.w500),
                              children: <TextSpan>[
                                TextSpan(
                                  text: isFree ? "FREE" : "\$${entry}",
                                  style: GoogleFonts.poppins(
                                      color: Colors.green,
                                      decoration: isFree ? TextDecoration.lineThrough : TextDecoration.none,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text("\$${prize}", style: AppTextStyles.terniaryStyle(22.0, Colors.black, FontWeight.w700)),
                          const Spacer(),
                          GestureDetector(
                            onTap: () async {
                              if (!isFree) {
                                try {
                                  final double walletAmt = await fetchWalletAmount();
                                  if (walletAmt < entry) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Insufficient funds. Please add money to your wallet.")),
                                    );
                                    return;
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Error fetching wallet: $e")),
                                  );
                                  return;
                                }
                              }
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => MatchFantasyPage(
                                    contestId: id,
                                    contest: {
                                      "id": id,
                                      "prize": prize,
                                      "entryFee": entry,
                                      "totalSpots": totalSpots,
                                      "filledSpots": filledSpots,
                                      "isFree": isFree,
                                      "matchName": matchName,
                                      "venue": venue,
                                      "date": date,
                                      "status": status,
                                      "teamInfo": teamInfo,
                                    },
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                              decoration: BoxDecoration(
                                color: AppColors.green,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                isFree ? "FREE" : "\$${entry}",
                                style: AppTextStyles.terniaryStyle(18, Colors.white, FontWeight.w700),
                              ),
                            ),
                          ),
                        ],
                      ),
                      spotsFillBar(width, percentFilled),
                      Row(
                        children: [
                          Text("${totalSpots - filledSpots} spots left", style: AppTextStyles.primaryStyle(14.0, const Color(0x80191d88), FontWeight.w500)),
                          const Spacer(),
                          Text("$totalSpots spots", style: AppTextStyles.primaryStyle(14.0, Colors.black54, FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    border: const Border(
                      top: BorderSide(width: 0.5, color: Colors.white),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black54,
                              width: 1,
                            )),
                        child: const Icon(
                          Icons.wine_bar_outlined,
                          color: Colors.black54,
                          size: 11,
                        ),
                      ),
                      Text("  ${(percentFilled * 100).round()}%", style: AppTextStyles.primaryStyle(12.0, Colors.black54, FontWeight.w500)),
                      const SizedBox(width: 10),
                      Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black54,
                                width: 1,
                              )),
                          child: Text("M", style: AppTextStyles.primaryStyle(11.0, Colors.black54, FontWeight.w500))),
                      Text("  Upto 11", style: AppTextStyles.primaryStyle(12.0, Colors.black54, FontWeight.w500)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black54,
                              width: 1,
                            )),
                        child: const Icon(
                          Icons.currency_rupee,
                          color: Colors.black54,
                          size: 11,
                        ),
                      ),
                      Text("  Flexible", style: AppTextStyles.primaryStyle(12.0, Colors.black54, FontWeight.w500)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        // Admin deletion icon
        FutureBuilder<String?>(
          future: Utils().secureStorage.read(key: 'admin'),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data == "true") {
              return Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () async {
                    final url = "${AppUrl.listContest}/$id";
                    final response = await http.delete(Uri.parse(url));
                    if (response.statusCode == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Contest deleted successfully")),
                      );
                      // Refresh contest list via callback.
                      if (onDelete != null) onDelete!();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Failed to delete contest")),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: const Icon(Icons.close, color: Colors.white, size: 24),
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }

  Container spotsFillBar(double width, double percentFilled) {
    double barWidth = width - 35;
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
            width: barWidth * percentFilled,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            height: 5,
          )
        ],
      ),
    );
  }
}