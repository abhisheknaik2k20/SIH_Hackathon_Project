import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> userData = {
    'name': 'John Doe',
    'email': 'john.doe@example.com',
    'dob': '1990-01-01',
    'grade': '10th Grade',
    'school': 'Springfield High School',
    'bio': 'Passionate learner, aspiring scientist',
    'subjects': ['Mathematics', 'Physics', 'Chemistry'],
    'achievements': ['Science Fair Winner 2023', 'Math Olympiad Finalist'],
    'website': 'www.johndoe-student.com',
    'phone': '1234567890',
  };
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            _buildBioSection(),
            _buildEducationSection(),
            _buildAchievementsSection(),
            _buildContactSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 80, left: 17, right: 17),
      child: Container(
        alignment: Alignment.centerLeft,
        height: 300,
        padding: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(width: 5),
              Container(
                width: 190,
                height: 290,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage("assets/profile.png"),
                    fit: BoxFit.fitWidth,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData['name'],
                      style: const TextStyle(
                          fontSize: 45, height: 0.9, color: Colors.blue),
                    ),
                    const SizedBox(height: 12),
                    _buildInfoItem("Email", userData['email']),
                    _buildInfoItem("Date of Birth", userData['dob']),
                    _buildInfoItem("Grade", userData['grade']),
                    _buildInfoItem("School", userData['school']),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              color: Colors.black45, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 20, height: 0.9, color: Colors.blue),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildBioSection() {
    return _buildSection(
      "BIO",
      Text(
        userData['bio'],
      ),
    );
  }

  Widget _buildEducationSection() {
    return _buildSection(
      "SUBJECTS",
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: userData['subjects']
            .map<Widget>((subject) => Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "• $subject",
                    style: const TextStyle(color: Colors.blue),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildAchievementsSection() {
    return _buildSection(
      "ACHIEVEMENTS",
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: userData['achievements']
            .map<Widget>((achievement) => Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "• $achievement",
                    style: const TextStyle(color: Colors.blue),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildContactSection() {
    return _buildSection(
      "CONTACT",
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("WEBSITE",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue)),
              Text(userData['website'],
                  style: const TextStyle(color: Colors.blue)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("PHONE",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue)),
              Text(userData['phone'],
                  style: const TextStyle(color: Colors.blue)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 17, right: 17, bottom: 20),
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 10),
              content,
            ],
          ),
        ),
      ),
    );
  }
}
