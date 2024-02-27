import 'package:aquae_florentis/presentation/providers/navigation-provider.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/screens/dashboard-screen/dahsboard-drawer.dart';
import 'package:aquae_florentis/presentation/utilities/responsive.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bottom-navigation-bar.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.light,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      child: Scaffold(
        backgroundColor: ColorManager.tertiary,
        resizeToAvoidBottomInset: false,
        extendBody: true,
        key: drawerKey,
        drawer: Responsive.isTablet(context) ? const DashboardPage() : null,
        body: ResponsiveRowColumn(
          layout: Responsive.isMobile(context)
              ? ResponsiveRowColumnType.COLUMN
              : ResponsiveRowColumnType.ROW,
          children: children()
              .map((child) => ResponsiveRowColumnItem(child: child))
              .toList(),
        ),
        bottomNavigationBar:
            Responsive.isMobile(context) ? const BottomBar() : null,
      ),
    );
  }

  List<Widget> children() {
    return [
      if (Responsive.isDesktop(context)) const DashboardSide(),
      Expanded(
          flex: 5, child: navigationItems[ref.watch(navigationProvider)].page)
    ];
  }
}
