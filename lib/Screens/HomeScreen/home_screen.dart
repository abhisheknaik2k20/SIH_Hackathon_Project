import 'dart:ui';

import 'package:codestore/Screens/HomeScreen/coursesinfo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = '';
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        SliverAppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          pinned: true,
          toolbarHeight: 80,
          floating: false,
          stretch: true,
          surfaceTintColor: Theme.of(context).colorScheme.surface,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.zoomBackground,
              StretchMode.blurBackground
            ],
            titlePadding: const EdgeInsets.only(left: 15, bottom: 16),
            title: Row(
              children: [
                Icon(Icons.school,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  "EduMate",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                Icon(Icons.notifications_outlined,
                    color: Theme.of(context).colorScheme.onSurface),
                const SizedBox(
                  width: 15,
                )
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSearchBar(context),
                const SizedBox(height: 16),
                _buildPromotionBanner(context),
                const SizedBox(height: 24),
                _buildCategories(context),
                const SizedBox(height: 24),
                _buildPopularSection(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search courses, topics, tutors...',
        hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
        prefixIcon:
            Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }

  Widget _buildPromotionBanner(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 16,
            top: 16,
            child: Icon(Icons.book_online,
                size: 100, color: Theme.of(context).colorScheme.primary),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('NEW',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(
                  'FREE access to\nall courses this week!',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    final categories = [
      {
        'icon': FontAwesomeIcons.diagramProject,
        'label': '    Data\nStructures'
      }, // Data Structures (Tree/Graph)
      {'icon': Icons.memory, 'label': 'Algorithms\n'}, // Algorithms
      {
        'icon': Icons.desktop_windows,
        'label': 'Operating\nSystems'
      }, // Operating Systems
      {
        'icon': Icons.router,
        'label': 'Computer\nNetworks'
      }, // Computer Networks
      {'icon': Icons.storage, 'label': 'DBMS'}, // DBMS
      {'icon': Icons.security, 'label': 'Cyber\nSecurity'}, // Cyber Security
      {
        'icon': Icons.android,
        'label': 'Artificial\nIntelligence'
      }, // Artificial Intelligence
      {
        'icon': Icons.code,
        'label': 'Programming\nLanguages'
      }, // Programming Languages
      {
        'icon': Icons.phone_android,
        'label': 'Mobile\nDevelopment'
      }, // Mobile Development
      {'icon': Icons.cloud, 'label': 'Cloud\nComputing'}, // Cloud Computing
      {'icon': Icons.web, 'label': 'Web\nDevelopment'}, // Web Development
      {
        'icon': Icons.developer_board,
        'label': 'Embedded\nSystems'
      }, // Embedded Systems
      {'icon': Icons.data_usage, 'label': 'Big\nData'}, // Big Data
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Engineering Fields',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface)),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedCategory = '';
                });
              },
              child: Text('CLEAR FILTER',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories
                .map((category) => _buildCategoryItem(
                      context: context,
                      icon: category['icon'] as IconData,
                      label: category['label'] as String,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem({
    required BuildContext context,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _selectedCategory == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = isSelected ? '' : label;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(icon,
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 8),
            Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface)),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularSection(BuildContext context) {
    final filteredCourses = filterCourses(_selectedCategory);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Popular Courses',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface)),
            Text('SHOW ALL',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 16),
        if (filteredCourses.isEmpty)
          Center(
            child: Text('No courses found for the selected category.',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface)),
          )
        else
          ...filteredCourses.map(
            (course) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildCourseCard(
                context,
                course['title'] as String,
                course['category'] as String,
                course['description'] as String,
                course['price'] as double,
                course['imageurl'] as String,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCourseCard(BuildContext context, String title, String category,
      String description, double price, String imageurl) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.purple, Colors.blue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(
                  imageurl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    '30+ SESSIONS!',
                    style: TextStyle(
                      color: Colors.purple[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Bottom section with course info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  price.toString(),
                  style: TextStyle(
                    color: Colors.yellow[300],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
