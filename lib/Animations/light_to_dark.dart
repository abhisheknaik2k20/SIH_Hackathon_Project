import 'package:codestore/styles/colorscheme.dart';
import 'package:flutter/material.dart';

class ThemeChangeIcon extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onAnimationComplete;

  const ThemeChangeIcon({
    super.key,
    required this.isDarkMode,
    required this.onAnimationComplete,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ThemeChangeIconState createState() => _ThemeChangeIconState();
}

class _ThemeChangeIconState extends State<ThemeChangeIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward().then((_) => widget.onAnimationComplete());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value * 2 * 3.14159,
          child: Icon(
            widget.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            size: 48,
            color: Colors.white,
          ),
        );
      },
    );
  }
}

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  ThemeData get currentTheme => _isDarkMode ? darkTheme : lightTheme;

  void toggleTheme(BuildContext context) {
    _showThemeChangeAnimation(context);
  }

  void _showThemeChangeAnimation(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return Center(
          child: ThemeChangeIcon(
            isDarkMode: !_isDarkMode,
            onAnimationComplete: () {
              Navigator.of(context).pop();
              _isDarkMode = !_isDarkMode;
              notifyListeners();
            },
          ),
        );
      },
    );
  }
}
