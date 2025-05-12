// import 'package:flutter/material.dart';
// import 'package:teamx/view/Fantasy/contest_screen.dart';
// import 'package:provider/provider.dart';

// import '../../cards/glassmorphism_card.dart';
// import '../../data/response/status.dart';
// import '../../res/app_text_style.dart';
// import '../../res/color.dart';
// import '../../view_model/matches_view_model.dart';
// import '../../widgets/upcoming_matches.dart';
// import '../Fantasy/match_fantsay_page.dart';

// class FantasyView extends StatefulWidget {
//   const FantasyView({Key? key}) : super(key: key);

//   @override
//   State<FantasyView> createState() => _FantasyViewState();
// }

// class _FantasyViewState extends State<FantasyView> {
//   @override
//   Widget build(BuildContext context) {
//     final matchesListviewModel =
//     Provider.of<MatchesListViewModel>(context, listen: false);
//     return ChangeNotifierProvider<MatchesListViewModel>.value(
//         value: matchesListviewModel,
//         child: Consumer<MatchesListViewModel>(
//           builder: (context, value, child) {
//             switch (value.matchesList.status) {
//               case Status.loading:
//                 return const Center(child: CircularProgressIndicator());
//               case Status.error:
//                 return Center(
//                   child: Text(value.matchesList.message.toString()),
//                 );
//               case Status.completed:
//                 return Container(
//                   margin: EdgeInsets.symmetric(horizontal: 8),
//                   color: Color(0xffeef0fc),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 5,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.of(context)
//                               .push(MaterialPageRoute(
//                             // builder: (context) => MatchFantasyPage()
//                               builder: (context) => ContestScreen()
//                           ));
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 8.0),
//                           child: Text(
//                             "Upcoming Matches",
//                             style: AppTextStyles.primaryStyle(
//                               20,
//                               Colors.black,
//                               FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       Expanded(
//                         child: UpcomingMatches(
//                           context: context,
//                           matchListModel: value.matchesList.data,
//                           matchType: "upcoming",
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               default:
//                 return Container();
//             }
//           },
//         ));
//   }
// }