import 'package:codestore/Animations/light_to_dark.dart';
import 'package:flutter/material.dart';

class ThemeToggleButton extends StatefulWidget {
  final ThemeProvider themeProvider;

  const ThemeToggleButton({required this.themeProvider, Key? key})
      : super(key: key);

  @override
  _ThemeToggleButtonState createState() => _ThemeToggleButtonState();
}

class _ThemeToggleButtonState extends State<ThemeToggleButton>
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
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Sync animation with the initial theme
    if (widget.themeProvider.isDarkMode) {
      _controller.value = 1.0;
    }
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
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: InkWell(
            onTap: () {
              if (widget.themeProvider.isDarkMode) {
                _controller.reverse();
              } else {
                _controller.forward();
              }
              widget.themeProvider.toggleTheme(context);
            },
            borderRadius: BorderRadius.circular(30),
            child: Container(
              width: 80,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color.lerp(
                    Colors.grey[300], Colors.grey[800], _animation.value),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.8),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    left: _animation.value * 40,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.lerp(
                            Colors.white, Colors.grey[900], _animation.value),
                      ),
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: _animation.value < 0.5
                              ? Icon(Icons.light_mode,
                                  color: Colors.orange, key: ValueKey('light'))
                              : Icon(Icons.dark_mode,
                                  color: Colors.blue, key: ValueKey('dark')),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
