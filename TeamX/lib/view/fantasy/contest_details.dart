import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/app_text_style.dart';
import '../../res/color.dart';
import 'complete_match_contest_details.dart';
import 'fantasy_points_system.dart';
import 'match_fantsay_page.dart';

class ContestDetailsScreen extends StatefulWidget {
  final String id;
  const ContestDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ContestDetailsScreen> createState() => _ContestDetailsScreenState();
}

class _ContestDetailsScreenState extends State<ContestDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isFree = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // You can use widget.id here for your API call
    // Example: fetchPlayersForContest(widget.id);
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
                child: Text("Contest ID: ${widget.id}",
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
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 8, left: 14, right: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Max Prize Pool",
                        style: AppTextStyles.primaryStyle(
                            14.0,
                            Colors.black54,
                            FontWeight.w500)),
                    SizedBox(
                      height: 2,
                    ),
                    Text("\$25,200",
                        style:
                        AppTextStyles.terniaryStyle(
                            22.0,
                            Colors.black,
                            FontWeight.w700)),
                    spotsFillBar(width),
                    Row(
                      children: [
                        Text("850 spots left",
                            style: AppTextStyles.primaryStyle(
                                14.0,
                                Color(0x80191d88),
                                FontWeight.w500)),
                        Spacer(),
                        Text("2500 spots",
                            style: AppTextStyles.primaryStyle(
                                14.0,
                                Colors.black54,
                                FontWeight.w500)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    MatchFantasyPage(contestId: widget.id)));
                      },
                      child: Container(
                        width: width,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            vertical: 6, horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppColors.green,
                          borderRadius:
                          BorderRadius.circular(4),
                        ),
                        child: Text(
                          isFree ? "FREE" : "\$${25}",
                          style:
                          AppTextStyles.terniaryStyle(
                              18,
                              Colors.white,
                              FontWeight.w700),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  border: Border(
                    top: BorderSide(
                        width: 0.5, color: Colors.white),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black54,
                            width: 1,
                          )),
                      child: Icon(
                        Icons.wine_bar_outlined,
                        color: Colors.black54,
                        size: 11,
                      ),
                    ),
                    Text("  45%",
                        style: AppTextStyles.primaryStyle(
                            12.0,
                            Colors.black54,
                            FontWeight.w500)),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black54,
                              width: 1,
                            )),
                        child: Text("M",
                            style: AppTextStyles.primaryStyle(
                                11.0,
                                Colors.black54,
                                FontWeight.w500))),
                    Text("  Upto 11",
                        style: AppTextStyles.primaryStyle(
                            12.0,
                            Colors.black54,
                            FontWeight.w500)),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black54,
                            width: 1,
                          )),
                      child: Icon(
                        Icons.currency_rupee,
                        color: Colors.black54,
                        size: 11,
                      ),
                    ),
                    Text("  Flexible",
                      style: AppTextStyles.primaryStyle(
                        12.0,
                        Colors.black54,
                        FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            ],
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
                  },
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
                    Tab(
                      height: 30.0,
                      child: Text(
                        "Leaderboard",
                        style: AppTextStyles.terniaryStyle(
                            14, AppColors.black, FontWeight.w500),
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
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: 25,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 0),
                            decoration: BoxDecoration(
                              color: index % 2 == 0 ? Colors.transparent : Color(0xfff8f8fe),
                            ),
                            height: 50,
                            child: Row(
                              children: [
                                Text(
                                  '# ${index + 1}',
                                  style: AppTextStyles.terniaryStyle(
                                    16, AppColors.black, FontWeight.w500,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '\$30,000',
                                  style: AppTextStyles.terniaryStyle(
                                    14, AppColors.black, FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [

                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container spotsFillBar(double width) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      width: width - 35,
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5),
      ),
      height: 5,
      child: Stack(
        children: [
          Container(
            width: width / 2,
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