import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/features/news/presentation/screens/feed_tab.dart';

class FeedActivity extends StatelessWidget {
  FeedActivity({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xff121212),
        appBar: _appBar(),
        drawer: Drawer(
          width: MediaQuery.of(context).size.width/1.5,
          backgroundColor: const Color(0xff1E1E1E),
        ),
        body: const TabBarView(
          children: [
            FeedPage(category: 'technology'),
            FeedPage(category: 'science'),
            FeedPage(category: 'sports'),
            FeedPage(category: 'business'),
          ],
        ),
      ),
    );
  }

  AppBar _appBar(){
    return AppBar(
      toolbarHeight: 60,
      backgroundColor: const Color(0xff1E1E1E),
      scrolledUnderElevation: 0,
      elevation: 0,
      leadingWidth: 60,
      leading: GestureDetector(
        onTap: () {
          scaffoldKey.currentState!.openDrawer();
        },
        child: Container(
          width: 28,
          height: 28,
          margin: const EdgeInsets.all(16),
          child: SvgPicture.asset('assets/icons/drawer.svg'),
        ),
      ),
      actions: [
        Container(
          width: 28,
          height: 28,
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: SvgPicture.asset('assets/icons/search.svg'),
        ),
        Container(
          width: 28,
          height: 28,
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: SvgPicture.asset('assets/icons/notification.svg'),
        ),
        Container(
          width: 28,
          height: 28,
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: SvgPicture.asset('assets/icons/profile.svg'),
        ),
      ],
      bottom: TabBar(
        indicatorColor: Colors.redAccent.shade400,
        indicatorWeight: 2,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
        labelPadding: EdgeInsets.zero,
        labelStyle: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        dividerHeight: 0,
        tabs: const [
          Tab(child: Text('Tech')),
          Tab(child: Text('Science')),
          Tab(child: Text('Sports')),
          Tab(child: Text('Business')),
        ],
      ),
    );
  }
}
