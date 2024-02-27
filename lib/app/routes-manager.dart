import 'package:aquae_florentis/presentation/screens/community-screen/all-comunities.dart';
import 'package:aquae_florentis/presentation/screens/community-screen/create-community.dart';
import 'package:aquae_florentis/presentation/screens/dashboard-screen/dashboard.dart';
import 'package:aquae_florentis/presentation/screens/intro-screen/onboarding-screen.dart';
import 'package:aquae_florentis/presentation/screens/login-screen/login-desktop-page.dart';
import 'package:aquae_florentis/presentation/screens/login-screen/login-screen.dart';
import 'package:aquae_florentis/presentation/screens/register-screen/register-desktop-page.dart';
import 'package:aquae_florentis/presentation/screens/register-screen/register-screen.dart';
import 'package:aquae_florentis/presentation/screens/splash-screen/splash-screen.dart';
import 'package:aquae_florentis/presentation/screens/work-screen/add-task.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String loginDesktopRoute = "/login-desktop";
  static const String registerDesktopRoute = "/register-desktop";
  static const String allCommunities = "/all-communities";
  static const String createCommunity = "/create-community";
  static const String createTask = "/create-task";
  static const String registerRoute = "/register";
  static const String dashboardRoute = "/dashboard";
  static const String introRoute = "/intro";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashPage(),
        );
      case Routes.loginDesktopRoute:
        return MaterialPageRoute(
          builder: (context) => const LoginDesktopPage(),
        );
      case Routes.allCommunities:
        return MaterialPageRoute(
          builder: (context) => const AllCommunities(),
        );
      case Routes.createCommunity:
        return MaterialPageRoute(
          builder: (context) => const CreateCommunity(),
        );
        case Routes.createTask:
        return MaterialPageRoute(
          builder: (context) => const AddTaskPage(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case Routes.registerDesktopRoute:
        return MaterialPageRoute(
          builder: (context) => const RegisterDesktopPage(),
        );
      case Routes.registerRoute:
        return MaterialPageRoute(
          builder: (context) => const RegisterPage(),
        );
      case Routes.introRoute:
        return MaterialPageRoute(
          builder: (context) => const OnboardingPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const DashboardPage(),
        );
    }
  }
}
