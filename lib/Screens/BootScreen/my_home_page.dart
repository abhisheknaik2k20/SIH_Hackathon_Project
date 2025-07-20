import 'package:codestore/Animations/light_to_dark.dart';
import 'package:codestore/Screens/Community/community.dart';
import 'package:codestore/CustomWidgets/togglebutton.dart';
import 'package:codestore/Screens/BootScreen/bottom_nav_bar.dart';
import 'package:codestore/Screens/DashBoard/dash_board.dart';
import 'package:codestore/Screens/HomeScreen/home_screen.dart';
import 'package:codestore/Screens/ProfileScreen/profile.dart';
import 'package:codestore/Screens/calender/calendarPage.dart';
import 'package:codestore/Screens/login_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  final _advancedDrawerController = AdvancedDrawerController();
  late AnimationController _animationController;
  late PageController _pageController;

  final List<Widget> _screens = [
    const HomeScreen(),
    CalendarPage(),
    const EngineeringDashboardScreen(),
    const ClassroomScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 128.0,
                height: 128.0,
                margin: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 64.0,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  size: 64,
                  color: Colors.white,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.home),
                title: const Text('Home'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.account_circle_rounded),
                title: const Text('Profile'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
              ),
              ListTile(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginSignupScreen()),
                      (Route route) => false);
                },
                leading: const Icon(Icons.logout),
                title: const Text('Log-Out'),
              ),
              const Spacer(),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: const Text('Terms of Service | Privacy Policy'),
                ),
              ),
            ],
          ),
        ),
      ),
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: _screens,
        ),
        floatingActionButton: CustomGNav(
          selectedIndex: _selectedIndex,
          onTabChange: _onTabChange,
          colorScheme: Theme.of(context).colorScheme,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

class LikesScreen extends StatelessWidget {
  const LikesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Likes Screen'));
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Search Screen'));
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Profile Screen'));
  }
}
