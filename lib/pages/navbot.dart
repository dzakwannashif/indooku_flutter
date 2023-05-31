import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:floating_frosted_bottom_bar/floating_frosted_bottom_bar.dart';
import 'package:indooku_flutter/pages/explore.dart';
import 'package:indooku_flutter/pages/home.dart';
import 'package:indooku_flutter/pages/setting.dart';

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NavigationBarPage> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage>
    with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;

  final List<Color> colors = [
    Color(0xffE7A600),
    Color(0xffE7A600),
    Color(0xffE7A600),
  ];

  final List<Widget> pages = [
    HomePage(),
    Explorepage(),
    SettingsPage(),
  ];

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: pages.length, vsync: this);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FrostedBottomBar(
        bottomBarColor: Color(0xff2A2526),
        opacity: 1,
        sigmaX: 5,
        sigmaY: 5,
        borderRadius: BorderRadius.circular(500),
        duration: const Duration(milliseconds: 800),
        hideOnScroll: true,
        body: (context, controller) => TabBarView(
          controller: tabController,
          dragStartBehavior: DragStartBehavior.down,
          physics: const BouncingScrollPhysics(),
          children: pages,
        ),
        child: TabBar(
          indicatorColor: Color(0xffE7A600),
          indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
          controller: tabController,
          tabs: [
            TabsIcon(
              icons: Icons.home,
              color: currentPage == 0 ? colors[0] : Colors.white,
            ),
            TabsIcon(
              icons: Icons.explore_rounded,
              color: currentPage == 1 ? colors[1] : Colors.white,
            ),
            TabsIcon(
              icons: Icons.settings,
              color: currentPage == 2 ? colors[2] : Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

class TabsIcon extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  final IconData icons;

  const TabsIcon(
      {Key? key,
      this.color = Colors.white,
      this.height = 60,
      this.width = 50,
      required this.icons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Center(
        child: Icon(
          icons,
          color: color,
        ),
      ),
    );
  }
}
