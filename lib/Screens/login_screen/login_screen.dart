import 'package:codestore/Screens/login_screen/login_logic.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen>
    with SingleTickerProviderStateMixin {
  bool isLogin = true;
  bool _obscureText = true;
  String _selectedUserType = 'Student';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
            .animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    // Delay the start of the animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _animationController.forward();
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _toggleLoginSignup() {
    setState(() {
      isLogin = !isLogin;
      _animationController.reset();
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              _buildLogo(colors),
              const SizedBox(height: 24),
              _buildHeader(colors),
              const SizedBox(height: 16),
              _buildUserTypeSelector(colors),
              const SizedBox(height: 16),
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (!isLogin)
                              _buildTextField(
                                  controller: _nameController,
                                  hint: 'Full Name',
                                  icon: Icons.person),
                            if (!isLogin) const SizedBox(height: 16),
                            if (!isLogin) _buildPhoneField(),
                            if (!isLogin) const SizedBox(height: 16),
                            _buildTextField(
                                controller: _emailController,
                                hint: 'Email',
                                icon: Icons.email),
                            const SizedBox(height: 16),
                            _buildTextField(
                                controller: _passwordController,
                                hint: 'Password',
                                icon: Icons.lock,
                                isPassword: true),
                            const SizedBox(height: 24),
                            _buildActionButton(colors),
                            if (isLogin) _buildForgotPassword(colors),
                            const SizedBox(height: 24),
                            if (isLogin)
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text("Or Login with")],
                              ),
                            const SizedBox(height: 24),
                            if (isLogin)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildGoogleLogin(colors),
                                  const SizedBox(
                                      width:
                                          20), // Add some space between the buttons
                                  _buildGitHubLogin(colors),
                                ],
                              ),
                            _buildToggleButton(colors),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(ColorScheme colors) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: colors.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.school, color: colors.onPrimary, size: 24),
      ),
    );
  }

  Widget _buildHeader(ColorScheme colors) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isLogin ? 'Welcome Back!' : 'Create Account',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: colors.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isLogin
                ? 'Enter your email address and password to get access your account'
                : 'Please enter valid information to access your account.',
            style: TextStyle(
              fontSize: 14,
              color: colors.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserTypeSelector(ColorScheme colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.onSurface.withOpacity(0.1)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedUserType,
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down, color: colors.onSurface),
          style: TextStyle(color: colors.onSurface, fontSize: 16),
          onChanged: (String? newValue) {
            setState(() {
              _selectedUserType = newValue!;
            });
          },
          items: <String>['Student', 'Teacher', 'Admin']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Builder(builder: (context) {
      final colors = Theme.of(context).colorScheme;
      return Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.onSurface.withOpacity(0.1)),
        ),
        child: TextField(
          controller: controller,
          obscureText: isPassword && _obscureText,
          style: TextStyle(color: colors.onSurface),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: colors.onSurface.withOpacity(0.5)),
            prefixIcon: Icon(icon, color: colors.onSurface.withOpacity(0.5)),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: colors.onSurface.withOpacity(0.5),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      );
    });
  }

  Widget _buildPhoneField() {
    return Builder(builder: (context) {
      final colors = Theme.of(context).colorScheme;
      return Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.onSurface.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16),
              child: Icon(
                Icons.phone,
                color: colors.onSurface.withOpacity(0.5),
              ),
            ),
            Expanded(
              child: TextField(
                controller: _phoneController,
                style: TextStyle(color: colors.onSurface),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Enter Phone',
                  hintStyle:
                      TextStyle(color: colors.onSurface.withOpacity(0.5)),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildForgotPassword(ColorScheme colors) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          // Implement forgot password logic
        },
        child: Text(
          'Forgot Password?',
          style: TextStyle(color: colors.primary),
        ),
      ),
    );
  }

  Widget _buildActionButton(ColorScheme colors) {
    return ElevatedButton(
      onPressed: () async {
        if (isLogin &&
            _emailController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty) {
          emailpassLogin(_emailController.text, _passwordController.text,
              context, _selectedUserType);
        }
        if (_emailController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty &&
            _phoneController.text.isNotEmpty &&
            _nameController.text.isNotEmpty) {
          emailpassSignup(_emailController.text, _passwordController.text,
              _phoneController.text, context, _selectedUserType);
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: colors.onPrimary,
        backgroundColor: colors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isLogin ? 'Login' : 'Create',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward, size: 18),
        ],
      ),
    );
  }

  Widget _buildGoogleLogin(ColorScheme colors) {
    return GestureDetector(
      onTap: () {
        implementGoogleSignIn(context, _selectedUserType);
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: SizedBox(
              width: 30,
              height: 30,
              child: Icon(
                FontAwesomeIcons.google,
                color: Colors.white,
                size: 30,
              )),
        ),
      ),
    );
  }

  Widget _buildGitHubLogin(ColorScheme colors) {
    return GestureDetector(
      onTap: () async {
        gitHubSignIn(context, _selectedUserType);
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: SizedBox(
              width: 30,
              height: 30,
              child: Icon(
                FontAwesomeIcons.github,
                color: Colors.white,
                size: 30,
              )),
        ),
      ),
    );
  }

  Widget _buildToggleButton(ColorScheme colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLogin ? 'Don\'t have an account?' : 'Already have an account?',
          style: TextStyle(color: colors.onSurface.withOpacity(0.7)),
        ),
        TextButton(
          onPressed: _toggleLoginSignup,
          child: Text(
            isLogin ? 'Create account' : 'Login',
            style:
                TextStyle(color: colors.primary, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
