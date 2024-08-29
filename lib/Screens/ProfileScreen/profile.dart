import 'package:codestore/Animations/light_to_dark.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 15),
              title: Row(
                children: [
                  Text(
                    "My Profile",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  )
                ],
              ),
            ),
            expandedHeight: 80,
            floating: false,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: colorScheme.secondary,
                      child: Icon(Icons.person,
                          size: 50, color: colorScheme.onSecondary),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      'John Doe',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: colorScheme.onBackground),
                    ),
                  ),
                  SizedBox(height: 24),
                  _buildInfoSection(context, 'Educational Background',
                      'University of Example, Computer Science', colorScheme),
                  _buildInfoSection(
                      context,
                      'Areas of Interest',
                      'Machine Learning, Web Development, Mobile Apps',
                      colorScheme),
                  _buildAchievementsSection(context, colorScheme),
                  _buildProgressSection(context, colorScheme),
                  _buildCurrentCoursesSection(context, colorScheme),
                  _buildStudyGoalsSection(context, colorScheme),
                  _buildContactInfoSection(context, colorScheme),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, String title, String content,
      ColorScheme colorScheme) {
    return Card(
      color: colorScheme.surface,
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: colorScheme.primary, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(content, style: TextStyle(color: colorScheme.onSurface)),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementsSection(
      BuildContext context, ColorScheme colorScheme) {
    return Card(
      color: colorScheme.surface,
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Achievements',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: colorScheme.primary, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                Chip(
                    label: Text('Python Master'),
                    backgroundColor: colorScheme.secondary,
                    labelStyle: TextStyle(color: colorScheme.onSecondary)),
                Chip(
                    label: Text('100 Day Streak'),
                    backgroundColor: colorScheme.secondary,
                    labelStyle: TextStyle(color: colorScheme.onSecondary)),
                Chip(
                    label: Text('Top Contributor'),
                    backgroundColor: colorScheme.secondary,
                    labelStyle: TextStyle(color: colorScheme.onSecondary)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context, ColorScheme colorScheme) {
    return Card(
      color: colorScheme.surface,
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Progress',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: colorScheme.primary, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ListTile(
              title: Text('Courses Completed',
                  style: TextStyle(color: colorScheme.onSurface)),
              trailing: Text('12',
                  style: TextStyle(
                      color: colorScheme.secondary,
                      fontWeight: FontWeight.bold)),
            ),
            ListTile(
              title: Text('Average Grade',
                  style: TextStyle(color: colorScheme.onSurface)),
              trailing: Text('A-',
                  style: TextStyle(
                      color: colorScheme.secondary,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentCoursesSection(
      BuildContext context, ColorScheme colorScheme) {
    return Card(
      color: colorScheme.surface,
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Courses',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: colorScheme.primary, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ListTile(
              title: Text('Advanced Machine Learning',
                  style: TextStyle(color: colorScheme.onSurface)),
              subtitle: LinearProgressIndicator(
                  value: 0.6,
                  backgroundColor: colorScheme.secondary.withOpacity(0.2),
                  valueColor:
                      AlwaysStoppedAnimation<Color>(colorScheme.secondary)),
            ),
            ListTile(
              title: Text('Flutter Development',
                  style: TextStyle(color: colorScheme.onSurface)),
              subtitle: LinearProgressIndicator(
                  value: 0.75,
                  backgroundColor: colorScheme.secondary.withOpacity(0.2),
                  valueColor:
                      AlwaysStoppedAnimation<Color>(colorScheme.secondary)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudyGoalsSection(
      BuildContext context, ColorScheme colorScheme) {
    return Card(
      color: colorScheme.surface,
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Study Goals',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: colorScheme.primary, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            CheckboxListTile(
              title: Text('Complete 3 courses this month',
                  style: TextStyle(color: colorScheme.onSurface)),
              value: true,
              onChanged: (bool? value) {},
              activeColor: colorScheme.secondary,
            ),
            CheckboxListTile(
              title: Text('Achieve 30-day study streak',
                  style: TextStyle(color: colorScheme.onSurface)),
              value: false,
              onChanged: (bool? value) {},
              activeColor: colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfoSection(
      BuildContext context, ColorScheme colorScheme) {
    return Card(
      color: colorScheme.surface,
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Contact Information',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: colorScheme.primary, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.email, color: colorScheme.secondary),
              title: Text('john.doe@example.com',
                  style: TextStyle(color: colorScheme.onSurface)),
            ),
          ],
        ),
      ),
    );
  }
}
