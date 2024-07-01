import 'package:flutter/material.dart';

import 'app_assets.dart';
import 'bottom_item.dart';

class Constants {
  static const String defaultFont = "Ubuntu";
  static const String notoSansGujarati = "NotoSansGujarati";
  static const double defaultBorderRadius = 15;
  static const int paginationLimit = 20;
  static const defaultAnimationDuration = Duration(milliseconds: 500);

  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static List<BottomNavItem> navItems = [
    BottomNavItem(
      name: "Home",
      icon: AppAssets.navHome,
      index: 0,
    ),
    BottomNavItem(
      name: "Search",
      icon: AppAssets.navSearch,
      index: 1,
    ),
    BottomNavItem(
      name: "Profile",
      icon: AppAssets.navProfile,
      index: 2,
    ),
  ];
}
