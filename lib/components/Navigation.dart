import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:pinotech_cloud/components/header.dart';
import 'package:pinotech_cloud/screens/FolderScreen.dart';
import 'package:pinotech_cloud/screens/PhotoScreen.dart';
import 'package:pinotech_cloud/screens/HomeScreen.dart';

class Navigation extends StatefulWidget {
  final void Function() logOut;

  const Navigation({Key? key, required this.logOut}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  late List<Widget> pages;

  int currentPage = 0;
  ValueNotifier<bool> viewShareNotifier = ValueNotifier<bool>(false);

  void goShare(int pageNumber) {
    setState(() {
      currentPage = pageNumber;
      viewShareNotifier.value = true;
    });
  }

  void altShare(bool value) {
    setState(() {
      viewShareNotifier.value = value;
    });
  }

  @override
  void initState() {
    super.initState();
    pages = [
      HomeScreen(logOut: widget.logOut, goShare: goShare),
      FolderScreen(viewShareNotifier: viewShareNotifier, altShare: altShare),
      const PhotoScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141414),
      body: Column(
        children: [
          Header(logOut: widget.logOut),
          Expanded(
            child: pages[currentPage],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFF222222),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: currentPage,
          backgroundColor: Colors.transparent,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          onDestinationSelected: (index) => setState(() {
            currentPage = index;
            if (index == 1) {
              viewShareNotifier.value = false;
            }
          }),
          indicatorColor: Colors.transparent,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          destinations: [
            NavigationDestination(
              icon: SvgPicture.asset(
                currentPage == 0 ? 'assets/filledHome.svg' : 'assets/home.svg',
                height: 30,
                width: 30,
                colorFilter: ColorFilter.mode(
                  currentPage == 0 ? Color(0xFF27FE75) : Colors.grey.shade400,
                  BlendMode.srcIn,
                ),
              ),
              label: "Home",
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                currentPage == 1
                    ? 'assets/filledFolder.svg'
                    : 'assets/folder.svg',
                height: 30,
                width: 30,
                colorFilter: ColorFilter.mode(
                  currentPage == 1 ? Color(0xFF27FE75) : Colors.grey.shade400,
                  BlendMode.srcIn,
                ),
              ),
              label: "Folder",
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                currentPage == 2
                    ? 'assets/filledPhoto.svg'
                    : 'assets/photo.svg',
                height: 30,
                width: 30,
                colorFilter: ColorFilter.mode(
                  currentPage == 2 ? Color(0xFF27FE75) : Colors.grey.shade400,
                  BlendMode.srcIn,
                ),
              ),
              label: "Photo",
            ),
          ],
        ),
      ),
    );
  }
}
