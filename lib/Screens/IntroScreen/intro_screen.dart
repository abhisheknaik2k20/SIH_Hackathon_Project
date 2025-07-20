import 'package:codestore/Animations/fade_switch.dart';
import 'package:codestore/Screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
// Import for rootBundle
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

class CodeStoreIntroScreen extends StatefulWidget {
  final void Function() onDone;

  const CodeStoreIntroScreen({super.key, required this.onDone});

  @override
  State<CodeStoreIntroScreen> createState() => _CodeStoreIntroScreenState();
}

class _CodeStoreIntroScreenState extends State<CodeStoreIntroScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _backgroundAnimationController;
  late Animation<Color?> _backgroundColorAnimation;

  final List<Color> _pageColors = [
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.orange.shade100,
    Colors.purple.shade100,
    Colors.red.shade100,
  ];

  final _introKey = GlobalKey<IntroductionScreenState>();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _backgroundAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Increased duration
    );
    _backgroundColorAnimation = ColorTween(
      begin: _pageColors[0],
      end: _pageColors[1],
    ).animate(CurvedAnimation(
      parent: _backgroundAnimationController,
      curve: Curves.easeInOut,
    ));
    _pageController.addListener(() {
      final page = _pageController.page ?? 0;
      if (page % 1 == 0) {
        final nextPage = page.toInt() + 1;
        if (nextPage < _pageColors.length) {
          _backgroundColorAnimation = ColorTween(
            begin: _pageColors[page.toInt()],
            end: _pageColors[nextPage],
          ).animate(CurvedAnimation(
            parent: _backgroundAnimationController,
            curve: Curves.easeInOut,
          ));
          _backgroundAnimationController.forward(from: 0);
        }
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _backgroundAnimationController.dispose();
    super.dispose();
  }

  Widget _buildContent(String title, String body, String lottieAsset) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            lottieAsset,
            height: 250,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 30),
          Text(
            title,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              body,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  void _onSkip() {
    _introKey.currentState?.animateScroll(_pageColors.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _backgroundColorAnimation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _backgroundColorAnimation.value ?? Colors.white,
                  Colors.white,
                ],
              ),
            ),
            child: SafeArea(
              child: IntroductionScreen(
                key: _introKey,
                pages: [
                  PageViewModel(
                    title: "",
                    bodyWidget: _buildContent(
                      "Welcome to Code Store",
                      "Your personalized learning platform for smart education",
                      'assets/lottie/welcome.json',
                    ),
                  ),
                  PageViewModel(
                    title: "",
                    bodyWidget: _buildContent(
                      "Personalized Learning Paths",
                      "Discover tailored courses and learning experiences just for you",
                      'assets/lottie/personalized_learning.json',
                    ),
                  ),
                  PageViewModel(
                    title: "",
                    bodyWidget: _buildContent(
                      "Skill Enhancing Contests",
                      "Participate in challenges to boost your coding skills",
                      'assets/lottie/skill.json',
                    ),
                  ),
                  PageViewModel(
                    title: "",
                    bodyWidget: _buildContent(
                      "Expert Tutors & Live Sessions",
                      "Learn from the best with our expert tutors and tailored live sessions",
                      'assets/lottie/personalized_learning.json',
                    ),
                  ),
                  PageViewModel(
                    title: "",
                    bodyWidget: _buildContent(
                      "Community Engagement",
                      "Join our discussion forum to interact with peers and expand your network",
                      'assets/lottie/community.json',
                    ),
                  ),
                ],
                onDone: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      FadePageRoute(
                        builder: (context) => const LoginSignupScreen(),
                      ),
                      (Route route) => false);
                },
                onSkip: _onSkip,
                showSkipButton: true,
                skip: const Text("Skip"),
                next: const Text("Next"),
                done: const Text("Get Started",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                curve: Curves.easeInOut, // Smoother curve for page transition
                controlsMargin: const EdgeInsets.all(10),
                controlsPadding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
                dotsDecorator: const DotsDecorator(
                  size: Size(7.0, 7.0),
                  color: Color(0xFFBDBDBD),
                  activeSize: Size(15.0, 12.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
                dotsContainerDecorator: ShapeDecoration(
                  color: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
