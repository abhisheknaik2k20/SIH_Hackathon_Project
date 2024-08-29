import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text(
                  'Your Courses',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildChip('Design', context, isSelected: true),
                      _buildChip('Illustration', context),
                      _buildChip('Marketing', context),
                      _buildChip('Music', context),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 3 * 100,
                        child: _buildClassCard(
                          context,
                          title: 'Dashboard Tutorial',
                          lessons: 3,
                          color: Colors.indigo,
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 3 * 100,
                        child: _buildClassCard(
                          context,
                          title: 'Figma Basics',
                          lessons: 5,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 3 * 100,
                        child: _buildClassCard(
                          context,
                          title: 'Figma Basic',
                          lessons: 0,
                          color: Colors.orange,
                          isCompact: true,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Live Workshops',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'View all',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                _buildWorkshopItem(
                  context,
                  title: 'Art Direction & Design Leadership',
                  date: '15 November',
                  time: '16:00-18:30',
                ),
                SizedBox(height: 16),
                _buildWorkshopItem(
                  context,
                  title: 'How to Become UX Designer',
                  date: '16 November',
                  time: '18:00-18:40',
                ),
                SizedBox(height: 16),
                Text(
                  'Advanced Motion',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChip(String label, BuildContext context,
      {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        label: Text(label),
        backgroundColor: isSelected
            ? Theme.of(context).colorScheme.primary
            : Colors.grey[300],
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildClassCard(
    BuildContext context, {
    required String title,
    required int lessons,
    required Color color,
    bool isCompact = false,
  }) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!isCompact) Icon(Icons.play_circle_outline, color: Colors.white),
          if (!isCompact) SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (!isCompact)
            Text(
              '$lessons lessons',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                  ),
            ),
        ],
      ),
    );
  }

  Widget _buildWorkshopItem(
    BuildContext context, {
    required String title,
    required String date,
    required String time,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                '$date • $time',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ],
          ),
        ),
        const Icon(Icons.arrow_forward, color: Colors.grey),
      ],
    );
  }
}
