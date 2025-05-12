import 'package:flutter/material.dart';

import '../../res/app_text_style.dart';
import '../../res/color.dart';

class FantasyPointsSystem extends StatefulWidget {
  const FantasyPointsSystem({Key? key}) : super(key: key);

  @override
  State<FantasyPointsSystem> createState() => _FantasyPointsSystemState();
}

class _FantasyPointsSystemState extends State<FantasyPointsSystem>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;
  bool isExpanded = false;
  int formatIndex = 0;

  List t20Points = [
    [{'Type':'Run','Points':' +1 PTS'},{'Type':'Four Bonus','Points':' +2 PTS'},{'Type':'Six Bonus','Points':' +2 PTS'},{'Type':'Half Century Bonus','Points':'+8 PTS'},{'Type':'Century Bonus','Points':'+16 PTS'}],
    [{'Type':'Wicket(Excluding Run Out)','Points':'+25 PTS'},{'Type':'Maiden Over Bonus','Points':'+12 PTS'},{'Type':'3 Wicket Bonus','Points':'+4 PTS'},{'Type':'5 Wicket Bonus','Points':'+16 PTS'}, {'Type':'Maiden Over','Points':'+12 PTS'}],
    [{'Type':'Catch','Points':'+8 PTS'},{'Type':'3 Catch','Points':'+4 PTS'},{'Type':'Stumping','Points':'+12 PTS'},{'Type':'Run Out(Direct - Hit)','Points':'+12 PTS'}, {'Type':'Run Out(Not a direct - Hit)','Points':'+6 PTS'}],
    [{'Type':'Captain','Points':'2x'}, {'Type':'Vice Captain','Points':'1.5x'}]
  ];
  List t10Points = [
    [{'Type':'Run','Points':' +1 PTS'},{'Type':'Four Bonus','Points':' +1 PTS'},{'Type':'Six Bonus','Points':' +2 PTS'},{'Type':'30 Runs Bonus','Points':'+8 PTS'},{'Type':'Half Century Bonus','Points':'+16 PTS'}],
    [{'Type':'Wicket(Excluding Run Out)','Points':'+25 PTS'},{'Type':'2 Wicket Bonus','Points':'+8 PTS'},{'Type':'3 Wicket Bonus','Points':'+16 PTS'}, {'Type':'Maiden Over','Points':'+12 PTS'}],
    [{'Type':'Catch','Points':'+8 PTS'},{'Type':'3 Catch','Points':'+4 PTS'},{'Type':'Stumping','Points':'+12 PTS'},{'Type':'Run Out(Direct - Hit)','Points':'+12 PTS'}, {'Type':'Run Out(Not a direct - Hit)','Points':'+6 PTS'}],
    [{'Type':'Captain','Points':'2x'}, {'Type':'Vice Captain','Points':'1.5x'}]
  ];
  List odiPoints = [
    [{'Type':'Run','Points':' +1 PTS'},{'Type':'Four Bonus','Points':' +1 PTS'},{'Type':'Six Bonus','Points':' +2 PTS'},{'Type':'Half Century Bonus','Points':'+4 PTS'},{'Type':'Century Bonus','Points':'+8 PTS'}],
    [{'Type':'Wicket(Excluding Run Out)','Points':'+25 PTS'},{'Type':'4 Wicket Bonus','Points':'+4 PTS'},{'Type':'5 Wicket Bonus','Points':'+8 PTS'}, {'Type':'Maiden Over','Points':'+12 PTS'}],
    [{'Type':'Catch','Points':'+8 PTS'},{'Type':'3 Catch','Points':'+4 PTS'},{'Type':'Stumping','Points':'+12 PTS'},{'Type':'Run Out(Direct - Hit)','Points':'+12 PTS'}, {'Type':'Run Out(Not a direct - Hit)','Points':'+6 PTS'}],
    [{'Type':'Captain','Points':'2x'}, {'Type':'Vice Captain','Points':'1.5x'}]
  ];
  List testPoints = [
    [{'Type':'Run','Points':' +1 PTS'},{'Type':'Four Bonus','Points':' +1 PTS'},{'Type':'Six Bonus','Points':' +2 PTS'},{'Type':'Half Century Bonus','Points':'+4 PTS'},{'Type':'Century Bonus','Points':'+8 PTS'}],
    [{'Type':'Wicket(Excluding Run Out)','Points':'+16 PTS'},{'Type':'4 Wicket Bonus','Points':'+4 PTS'},{'Type':'5 Wicket Bonus','Points':'+8 PTS'}],
    [{'Type':'Catch','Points':'+8 PTS'},{'Type':'Stumping','Points':'+12 PTS'},{'Type':'Run Out(Direct - Hit)','Points':'+12 PTS'}, {'Type':'Run Out(Not a direct - Hit)','Points':'+6 PTS'}],
    [{'Type':'Captain','Points':'2x'}, {'Type':'Vice Captain','Points':'1.5x'}]
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

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
            color: Colors.white, // Set the color you want here
          ),
          backgroundColor: Color.fromARGB(255, 72, 133, 190),
          elevation: 1.0,
          title: Text("POINTS SYSTEM",
              style: AppTextStyles.primaryStyle(
                  20.0, AppColors.white, FontWeight.w600)),
        ),
      ),
      body: Column(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Color(0xfff8f8fe),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 2,
                  blurRadius: 20,
                )
              ],
            ),
            child: Align(
              alignment: Alignment.topCenter,
              heightFactor: 0.5,
              child: Image.network(
                'https://media.gettyimages.com/id/166080748/vector/cricket-player-strikes-the-ball-for-six.jpg?s=612x612&w=gi&k=20&c=V-kwBs62Vum3JsjZTDYTsXeyvA1Q0-ECKwuq8m39hTg=',
              ),
            ),
          ),

          SizedBox(height: 4,),

          Row(
            children: [
              SizedBox(width: 10,),
              Text(
                formatIndex == 0 ? 'T20 Points System' :
                formatIndex == 1 ? 'T10 Points System' :
                formatIndex == 2 ? 'ODI Points System' : 'TEST Points System',
                style: AppTextStyles.terniaryStyle(
                    16, AppColors.black, FontWeight.w600),

              ),
            ],
          ),

          SizedBox(height: 4,),

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
                    if (index == 2) {}
                    if (index == 3) {}
                  },
                  tabs: [
                    Tab(
                      height: 30.0,
                      child: Text(
                        "BAT",
                        maxLines: 2,
                        style: AppTextStyles.terniaryStyle(
                            12, AppColors.black, FontWeight.w500),
                      ),
                    ),
                    Tab(
                        height: 30.0,
                        child: Text(
                          "BOWL",
                          style: AppTextStyles.terniaryStyle(
                              12, AppColors.black, FontWeight.w500),
                          maxLines: 2,
                        )),
                    Tab(
                      height: 30.0,
                      child: Text(
                        "FILED",
                        style: AppTextStyles.terniaryStyle(
                            12, AppColors.black, FontWeight.w500),
                        maxLines: 2,
                      ),
                    ),
                    Tab(
                      height: 30.0,
                      child: Text(
                        "ADD",
                        style: AppTextStyles.terniaryStyle(
                            12, AppColors.black, FontWeight.w500),
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
                      ListOfPointsCard(
                        pointsList: formatIndex == 0 ? t20Points[0] :
                        formatIndex == 1 ? t10Points[0] :
                        formatIndex == 2 ? odiPoints[0] : testPoints[0],
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ListOfPointsCard(
                        pointsList: formatIndex == 0 ? t20Points[1] :
                        formatIndex == 1 ? t10Points[1] :
                        formatIndex == 2 ? odiPoints[1] : testPoints[1],
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ListOfPointsCard(
                        pointsList: formatIndex == 0 ? t20Points[2] :
                        formatIndex == 1 ? t10Points[2] :
                        formatIndex == 2 ? odiPoints[2] : testPoints[2],
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ListOfPointsCard(
                        pointsList: formatIndex == 0 ? t20Points[3] :
                        formatIndex == 1 ? t10Points[3] :
                        formatIndex == 2 ? odiPoints[3] : testPoints[3],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: !isExpanded ? GestureDetector(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: Container(
          height: 40,
          width: 150,
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
              Text(
                formatIndex == 0 ? "  Format - T20" :
                formatIndex == 1 ? '  Format - T10' :
                formatIndex == 2 ? '  Format - ODI' : '  Format - TEST',
                style: AppTextStyles.primaryStyle(
                  16.0, AppColors.white, FontWeight.w700,
                ),
              ),
              Icon(Icons.arrow_drop_up_rounded,
                size: 22,
                color: Colors.white,)
            ],
          ),
        ),
      ) :
      Container(
        height: 138,
        width: 165,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color(0xff191D88),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 20,
                  offset: Offset(0, 5))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                  formatIndex = 0;
                });
              },
              child: Container(
                height: 35,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                          color: Colors.white,
                          width: 1,
                        )
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("FORMAT       T20",
                      style: AppTextStyles.primaryStyle(
                          16.0, AppColors.white, FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                  formatIndex = 1;
                });
              },
              child: Container(
                height: 35,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                          color: Colors.white,
                          width: 1,
                        )
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("FORMAT       T10",
                      style: AppTextStyles.primaryStyle(
                          16.0, AppColors.white, FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                  formatIndex = 2;
                });
              },
              child: Container(
                height: 35,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                          color: Colors.white,
                          width: 1,
                        )
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("FORMAT       ODI",
                      style: AppTextStyles.primaryStyle(
                          16.0, AppColors.white, FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                  formatIndex = 3;
                });
              },
              child: Container(
                height: 33,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("FORMAT      TEST",
                      style: AppTextStyles.primaryStyle(
                          16.0, AppColors.white, FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}

class ListOfPointsCard extends StatelessWidget {
  const ListOfPointsCard({
    super.key,
    required this.pointsList,
  });

  final List pointsList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: pointsList.length,
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
                pointsList[index]['Type'],
                style: AppTextStyles.terniaryStyle(
                  16, AppColors.black, FontWeight.w500,
                ),
              ),
              Spacer(),
              Text(
                pointsList[index]['Points'],
                style: AppTextStyles.terniaryStyle(
                  14, AppColors.green, FontWeight.w700,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}