import 'package:flutter/material.dart';
import 'package:teamx/view/Fantasy/widgets/all_contest_card.dart';

import '../../res/app_text_style.dart';
import '../../res/color.dart';

class ViewAllContest extends StatefulWidget {
  final List<Map<String, dynamic>> contest;
  final String contestType;
  const ViewAllContest({Key? key, required this.contest, required this.contestType}) : super(key: key);

  @override
  State<ViewAllContest> createState() => _ViewAllContestState();
}

class _ViewAllContestState extends State<ViewAllContest> {
  @override
  Widget build(BuildContext context) {
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
              Text("IND vs PAK",
                  style: AppTextStyles.primaryStyle(
                      20.0, AppColors.white, FontWeight.w600)),
              Spacer(),
              Image.asset(
                color: Colors.white,
                'assets/wallet.png',
                height: 32,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Text(widget.contestType,
                      style: AppTextStyles.primaryStyle(
                          20.0, AppColors.black, FontWeight.w700)),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.contest.length,
              itemBuilder: (BuildContext context, int index) {
                return AllContestCrad(
                  id: widget.contest[index]['id'] ?? '',
                  prize: widget.contest[index]['prize'] ?? 0,
                  entry: widget.contest[index]['entry'] ?? 0,
                  totalSpots: widget.contest[index]['totalSpots'] ?? 0,
                  filledSpots: widget.contest[index]['filled'] ?? 0,
                  isFree: widget.contest[index]['isFree'] ?? false,
                  matchName: widget.contest[index]['matchName'] ?? '',
                  venue: widget.contest[index]['venue'] ?? '',
                  date: widget.contest[index]['date'] ?? '',
                  status: widget.contest[index]['status'] ?? '',
                  teamInfo: widget.contest[index]['teamInfo'] ?? [],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}