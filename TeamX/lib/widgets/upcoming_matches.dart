import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teamx/model/match_model.dart';
import 'package:teamx/res/app_text_style.dart';
import 'package:teamx/res/color.dart';
import 'package:teamx/widgets/timer_match_card.dart';
import 'package:teamx/widgets/toggle_switch_reminder.dart';

import '../cards/glassmorphism_card.dart';
import '../view/Fantasy/contest_screen.dart';

enum MatchStatus {
  pastMatch,
  liveMatch,
  upcomingMatch,
}

class UpcomingMatches extends StatefulWidget {
  final BuildContext context;
  final MatchListModel? matchListModel;
  final String matchType;
  const UpcomingMatches({
    Key? key,
    required this.context,
    required this.matchListModel,
    required this.matchType,
  }) : super(key: key);

  @override
  State<UpcomingMatches> createState() => _UpcomingMatchesState();
}

class _UpcomingMatchesState extends State<UpcomingMatches> {
  int upcomingCount = 0;
  int liveCount = 0;
  int completedCount = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < widget.matchListModel!.matches.length; i++) {
      if (widget.matchListModel!.matches[i].getBattingFirstTeam() == null) {
        continue;
      }
      if (widget.matchListModel!.matches[i].status == 1) {
        upcomingCount++;
      }
      if (widget.matchListModel!.matches[i].status == 2) {
        completedCount++;
      }
      if (widget.matchListModel!.matches[i].status == 3) {
        liveCount++;
      }
      if (widget.matchListModel!.matches[i].status == 4) {
        completedCount++;
      }
    }
    if (widget.matchType == "upcoming" && upcomingCount == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sports_cricket,
              size: 100,
              color: Colors.lightBlue,
            ),
            const SizedBox(height: 16),
            const Text(
              'There are no upcoming matches, cricket is on a break',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }
    if (widget.matchType == "live" && liveCount == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.stadium,
              size: 100,
              color: Colors.lightBlue,
            ),
            const SizedBox(height: 16),
            const Text(
              'No live matches!! Take trades on upcoming matches ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }
    if (widget.matchType == "completed" && completedCount == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.stadium, size: 80, color: Colors.lightBlue),
            const SizedBox(height: 16),
            const Text(
              'Check out live and upcoming matches',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.matchListModel!.matches.length,
            itemBuilder: (BuildContext context, int index) {
              if (widget.matchListModel!.matches[index].getBattingFirstTeam() ==
                  null) {
                return const SizedBox(
                  height: 0.0,
                  width: 0.0,
                );
              }
              if (widget.matchListModel!.matches[index].status == 1 &&
                  widget.matchType == "upcoming") {
                return matchCard(
                    widget.matchListModel!.matches[index], widget.matchType);
              } else if (widget.matchListModel!.matches[index].status == 2 &&
                  widget.matchType == "completed") {
                return matchCard(
                    widget.matchListModel!.matches[index], widget.matchType);
              } else if (widget.matchListModel!.matches[index].status == 3 &&
                  widget.matchType == "live") {
                return matchCard(
                    widget.matchListModel!.matches[index], widget.matchType);
              } else if (widget.matchListModel!.matches[index].status == 4 &&
                  widget.matchType == "completed") {
                return matchCard(
                    widget.matchListModel!.matches[index], widget.matchType);
              }
              // if(widget.matchType=="upcoming" && widget.matchListModel!.matches![index].matchType)
              return const SizedBox(
                height: 0.0,
                width: 0.0,
              );
            },
          ),
        )
      ],
    );
  }

  Widget matchCard(Matches matches, String statusPasses) {
    var width = MediaQuery.of(context).size.width;
    // TODO: change start time
    // DateTime startTime = DateTime.parse(DateTime.now().toString());
    // startTime.subtract(const Duration(hours: 1));
    String? dateString = matches.startTime;
    DateTime startTime = DateTime.parse(dateString);
    String? dateStringEnd = matches.endTime;
    DateTime endTime = DateTime.parse(dateStringEnd!);

    DateTime now = DateTime.now();
    Duration difference = startTime.difference(now);

    // Convert to IST
    Duration offset = Duration(hours: 5, minutes: 30);
    MatchStatus status;
    if (now.isBefore(startTime)) {
      status = MatchStatus.upcomingMatch;
    } else if (matches.status % 2 == 0) {
      status = MatchStatus.pastMatch;
    } else {
      status = MatchStatus.liveMatch;
    }
    startTime = startTime.add(offset);
    return GestureDetector(
      // onTap: () {
      // Navigator.pushNamed(context, RoutesName.matchScreen, arguments: {
      //   'mid': matches.mid,
      // });
      // },
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(
            builder: (context) => ContestScreen()
        ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        decoration: BoxDecoration(
            color: Color(0xfff8f8fe),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                width: 1.5,
                color: Colors.white
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 2,
                  blurRadius: 20
              )
            ]
        ),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 16.0, top: 5.0, bottom: 8.0),
                  width: width * 0.50,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.05),
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(35.0),
                      topLeft: Radius.circular(11),
                    ),

                  ),
                  child: Text(
                    matches.tournamentAbbr,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.primaryStyle(
                        12.0, AppColors.black, FontWeight.normal),
                  ),
                ),
                const Spacer(),
                if (matches.isPlayingXIPopulated)
                  const Icon(
                    Icons.flag,
                    size: 15.0,
                    color: Colors.grey,
                  ),
                const SizedBox(
                  width: 5.0,
                ),
                if (matches.isPlayingXIPopulated)
                  Text(
                    "Lineups out",
                    style: AppTextStyles.primaryStyle(
                        12.0, AppColors.green, FontWeight.normal),
                  ),
                const SizedBox(
                  width: 10.0,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "${matches.shortName}.  ${matches.subtitle}",
                    style: GoogleFonts.assistant(
                        fontSize: 12.0,color: AppColors.black,fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              children: [
                                ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.2),
                                      BlendMode.dstIn),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 30.0,
                                    child: Image.network(
                                      // color: Colors
                                      //     .grey, // Image url is hardcoded, we have to take url from matches data;
                                      matches.getBattingFirstTeam()!.logo,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return const CircularProgressIndicator();
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                      const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: -1,
                                  bottom: 12,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 20.0,
                                    child: Image.network(
                                      // Image url is hardcoded, we have to take url from matches data;
                                      matches.getBattingFirstTeam()!.logo,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return const CircularProgressIndicator();
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                      const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            if (status == MatchStatus.liveMatch)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${matches.innings1.runs}/${matches.innings1.wickets}",
                                    style: AppTextStyles.primaryStyle(12.0,
                                        AppColors.black, FontWeight.normal),
                                  ),
                                  Text(
                                    "${matches.innings1.overs}.${matches.innings1.balls} overs",
                                    style: AppTextStyles.primaryStyle(12.0,
                                        AppColors.black, FontWeight.normal),
                                  ),
                                ],
                              )
                          ],
                        ),
                        if (status == MatchStatus.upcomingMatch)
                          Center(
                              child: CountdownWidget(
                                duration: difference,
                                startTime: startTime,
                              )),
                        if (status == MatchStatus.pastMatch)
                          Center(
                            child: Text(
                              matches.result.toString(),
                              style: AppTextStyles.primaryStyle(
                                  12.0, Colors.grey[700]!, FontWeight.normal),
                            ),
                          ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (status == MatchStatus.liveMatch)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${matches.innings2.runs}/${matches.innings2.wickets}",
                                    style: AppTextStyles.primaryStyle(12.0,
                                        AppColors.black, FontWeight.normal),
                                  ),
                                  Text(
                                    "${matches.innings2.overs}.${matches.innings2.balls} overs",
                                    style: AppTextStyles.primaryStyle(12.0,
                                        AppColors.black, FontWeight.normal),
                                  ),
                                ],
                              ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Stack(
                              children: [
                                ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.2),
                                      BlendMode.dstIn),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 30.0,
                                    child: Image.network(
                                      // color: Colors
                                      //     .grey, // Image url is hardcoded, we have to take url from matches data;
                                      matches.getBowlingFirstTeam()!.logo,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return const CircularProgressIndicator();
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                      const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  bottom: 12,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 20.0,
                                    child: Image.network(
                                      // Image url is hardcoded, we have to take url from matches data;
                                      matches.getBowlingFirstTeam()!.logo,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return const CircularProgressIndicator();
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                      const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ]),
                  if (status == MatchStatus.pastMatch) const SizedBox(),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        matches.getBattingFirstTeam()!.abbreviation,
                        style: AppTextStyles.terniaryStyle(
                            10.0, Colors.black54, FontWeight.w600),
                      ),
                      const Spacer(),
                      Text(
                        matches.getBowlingFirstTeam()!.abbreviation,
                        style: AppTextStyles.terniaryStyle(
                            10.0, Colors.black54, FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                    ],
                  ),
                  if (status == MatchStatus.liveMatch)
                    Center(
                        child: Text(matches.equation?.toString() ??
                            " This equation is not found")),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Divider(
                    thickness: 0.2,
                    color: Colors.black26,
                  ),
                  Row(
                    children: [
                      Glassmorphism(
                        blur: 10,
                        opacity: 0.5,
                        radius: 6,
                        border: 1,
                        color: Color(0xffceddff),
                        child: Padding(
                          padding: EdgeInsets.only(left: 6.0, right: 6.0, top: 2.75, bottom: 2.75),
                          child: Text(
                            "${matches.numInstruments} Events are live",
                            style: AppTextStyles.secondaryStyle(
                                10.0, AppColors.black, FontWeight.normal),
                          ),
                        ),
                      ),
                      // Container(
                      //   padding: const EdgeInsets.only(
                      //       top: 4.0, bottom: 4.0, right: 8.0, left: 8.0),
                      //   decoration: BoxDecoration(
                      //       border: Border.all(width: 0.3, color: Colors.grey),
                      //       borderRadius: BorderRadius.circular(8.0),
                      //       gradient: const LinearGradient(
                      //         begin: Alignment.topRight,
                      //         end: Alignment.bottomLeft,
                      //         stops: [
                      //           0.1,
                      //           0.4,
                      //           0.6,
                      //           0.9,
                      //         ],
                      //         colors: [
                      //           Color.fromARGB(255, 249, 248, 231),
                      //           Color.fromARGB(255, 247, 242, 193),
                      //           Color.fromARGB(255, 240, 231, 149),
                      //           Color.fromARGB(255, 245, 233, 97),
                      //         ],
                      //       )),
                      //   child: Text(
                      //     "${matches.numInstruments} Events are live",
                      //     style: AppTextStyles.primaryStyle(
                      //         12.0, AppColors.black, FontWeight.normal),
                      //   ),
                      // ),
                      const Spacer(),
                      // TODO: uncomment for set reminder part
                      // GestureDetector(
                      //     onTap: () {
                      //       _openBottomSheet(context);
                      //     },
                      //     child: Container(
                      //         padding:
                      //             const EdgeInsets.only(left: 5.0, right: 5.0),
                      //         decoration: BoxDecoration(
                      //             border: Border.all(
                      //                 width: 0.5, color: Colors.grey),
                      //             borderRadius: BorderRadius.circular(10.0)),
                      //         child: Icon(
                      //           size: 20.0,
                      //           Icons.notification_add_outlined,
                      //           color: Colors.grey[700],
                      //         )))
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    // borderRadius:const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(Icons.cancel_outlined),
                          ),
                          const Expanded(
                            child: Center(
                              child: Text(
                                "Set Reminders",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Lineup Announcement (if available)",
                        style:
                        TextStyle(fontSize: 12.0, color: Colors.grey[700]),
                      )
                    ],
                  )),
              const Padding(
                padding: EdgeInsets.only(right: 8.0, left: 8.0),
                child: Row(
                  children: [
                    Text(
                      "Match - PRB VS PRS",
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    SwitchScreen()
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 8.0, left: 8.0),
                child: Row(
                  children: [
                    Text(
                      "Tour -ECS Czeha T10",
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    SwitchScreen()
                  ],
                ),
              )
              // Additional content for the bottom sheet can be added here.
              // For this example, we leave it empty.
            ],
          ),
        );
      },
    );
  }
}