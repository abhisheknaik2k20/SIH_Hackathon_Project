import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class EngineeringDashboardScreen extends StatefulWidget {
  const EngineeringDashboardScreen({Key? key}) : super(key: key);

  @override
  _EngineeringDashboardScreenState createState() =>
      _EngineeringDashboardScreenState();
}

class _EngineeringDashboardScreenState extends State<EngineeringDashboardScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        physics: BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[];
        },
        body: _buildAllPostsTab(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.indigo,
      ),
    );
  }

  Widget _buildAllPostsTab() {
    return AnimationLimiter(
      child: ListView(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 375),
          childAnimationBuilder: (widget) => SlideAnimation(
            horizontalOffset: 50.0,
            child: FadeInAnimation(
              child: widget,
            ),
          ),
          children: [
            _buildGoodMorningCard(),
            _buildStorySection(),
            _buildTopPostsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildGoodMorningCard() {
    return Card(
      margin: EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning, Engineer',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Here\'s what\'s happening in your engineering network'),
            SizedBox(height: 16),
            LinearProgressIndicator(
              value: 0.7,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
            ),
            SizedBox(height: 8),
            Text('70% of your daily goals completed',
                style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  Widget _buildStorySection() {
    return Container(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildStoryItem("John Doe", 'Your story', Icons.add, null,
              "This is a description of your latest story. Share something new!"),
          _buildStoryItem(
              'Jane Smith',
              'AI Ethics',
              FontAwesomeIcons.brain,
              'https://nietm.in/wp-content/uploads/2022/12/AI3.png',
              "Discussing the ethical implications of AI in modern society, focusing on fairness, transparency, and accountability."),
          _buildStoryItem(
              'Michael Lee',
              'Robotics',
              FontAwesomeIcons.robot,
              'https://stembotix-bucket.s3.ap-south-1.amazonaws.com/thumbnail_tb4acak54l0l.jpg',
              "Exploring the cutting-edge advancements in robotics and their potential to reshape industries and daily life."),
          _buildStoryItem(
              'Emily Clark',
              'IoT',
              FontAwesomeIcons.microchip,
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRvOw-FHxw1B0pKMZkc0zo6LrQWpWtQjAbGQ&s',
              "A deep dive into how the Internet of Things (IoT) is connecting devices and revolutionizing our interaction with technology."),
        ],
      ),
    );
  }

  Widget _buildStoryItem(String name, String title, IconData icon,
      String? imageUrl, String description) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => StoryViewerScreen(
                    username: name,
                    title: title,
                    imageUrl: imageUrl,
                    description: description,
                  )),
        );
      },
      child: Container(
        width: 90,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.purple, Colors.indigo],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: ClipOval(
                    child: imageUrl != null
                        ? Image.network(imageUrl, fit: BoxFit.cover)
                        : Icon(icon, color: Colors.indigo),
                  ),
                ),
              ),
            ),
            SizedBox(height: 4),
            Text(title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }

  Widget _buildTopPostsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Top Posts',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {},
                child: Text('SEE ALL', style: TextStyle(color: Colors.indigo)),
              ),
            ],
          ),
        ),
        _buildPostItem(
          'Dr. Ada Lovelace',
          'AI Research Scientist',
          'Exploring the latest trends in Machine Learning!',
          '3h ago',
          ['#AI', '#MachineLearning'],
          'https://nietm.in/wp-content/uploads/2022/12/AI3.png',
        ),
        _buildPostItem(
          'Nikola Tesla',
          'Electrical Engineer',
          'Check out my new robotics project. Feedback welcome!',
          '4h ago',
          ['#Robotics', '#Engineering'],
          'https://stembotix-bucket.s3.ap-south-1.amazonaws.com/thumbnail_tb4acak54l0l.jpg',
        ),
        _buildPostItem(
          'Grace Hopper',
          'Computer Scientist',
          'Looking for study group members for Advanced Algorithms.',
          '6h ago',
          ['#StudyGroup', '#Algorithms'],
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRvOw-FHxw1B0pKMZkc0zo6LrQWpWtQjAbGQ&s',
        ),
      ],
    );
  }

  Widget _buildPostItem(String name, String title, String content, String time,
      List<String> hashtags, String? imageUrl) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://placekitten.com/100/100'),
            ),
            title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(title),
            trailing: Text(time, style: TextStyle(color: Colors.grey)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(content),
          ),
          if (imageUrl != null)
            Container(
              height: 200,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Wrap(
              spacing: 8.0,
              children: hashtags
                  .map((hashtag) => Chip(
                        label: Text(hashtag,
                            style: TextStyle(color: Colors.indigo)),
                        backgroundColor: Colors.indigo.withOpacity(0.1),
                      ))
                  .toList(),
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPostAction(Icons.thumb_up_outlined, 'Like'),
              _buildPostAction(Icons.comment_outlined, 'Comment'),
              _buildPostAction(Icons.share_outlined, 'Share'),
              _buildPostAction(Icons.send_outlined, 'Send'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPostAction(IconData icon, String label) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.grey),
      label: Text(label, style: TextStyle(color: Colors.grey)),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class StoryViewerScreen extends StatefulWidget {
  final String title;
  final String? imageUrl;
  final String username;
  final String description;
  final int durationInSeconds;

  const StoryViewerScreen({
    Key? key,
    required this.title,
    this.imageUrl,
    required this.username,
    required this.description,
    this.durationInSeconds = 5,
  }) : super(key: key);

  @override
  _StoryViewerScreenState createState() => _StoryViewerScreenState();
}

class _StoryViewerScreenState extends State<StoryViewerScreen> {
  double progress = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startProgress();
  }

  void _startProgress() {
    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        progress += 0.01;
        if (progress >= 1.0) {
          _timer?.cancel();
          Navigator.pop(context);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Stack(
          children: [
            Center(
              child: Hero(
                tag: widget.title,
                child: widget.imageUrl != null
                    ? Image.network(widget.imageUrl!, fit: BoxFit.contain)
                    : Container(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
              ),
            ),
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[700],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.username,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      widget.description,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.favorite_border, color: Colors.white),
                        Icon(Icons.comment, color: Colors.white),
                        Icon(Icons.share, color: Colors.white),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
