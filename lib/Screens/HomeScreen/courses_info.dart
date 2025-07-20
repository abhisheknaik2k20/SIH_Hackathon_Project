import 'dart:math';

List<Map<String, Object>> filterCourses(String selectedCategory) {
  final allCourses = [
    // Data Structures
    {
      'title': 'Introduction to Data Structures',
      'category': 'Data Structures',
      'description': '10 weeks, Beginner',
      'price': 49.99,
      'imageurl':
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-Ji69HYeNqt2YPsYqeR_61Vzx3YcQpVT8cg&s"
    },
    {
      'title': 'Advanced Data Structures',
      'category': 'Data Structures',
      'description': '12 weeks, Advanced',
      'price': 69.99,
      'imageurl':
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-Ji69HYeNqt2YPsYqeR_61Vzx3YcQpVT8cg&s"
    },

    // Algorithms
    {
      'title': 'Advanced Algorithms',
      'category': 'Algorithms',
      'description': '8 weeks, Advanced',
      'price': 59.99,
      'imageurl':
          "https://media.geeksforgeeks.org/wp-content/uploads/20230316121305/Complexity-Analysis-A-complete-reference-(1).png"
    },

    {
      'title': 'Graph Algorithms',
      'category': 'Algorithms',
      'description': '9 weeks, Advanced',
      'price': 69.99,
      'imageurl':
          "https://media.geeksforgeeks.org/wp-content/uploads/20230316121305/Complexity-Analysis-A-complete-reference-(1).png"
    },
    {
      'title': 'Algorithms in Python',
      'category': 'Algorithms',
      'description': '7 weeks, Intermediate',
      'price': 49.99,
      'imageurl':
          "https://media.geeksforgeeks.org/wp-content/uploads/20230316121305/Complexity-Analysis-A-complete-reference-(1).png"
    },

    // Operating Systems

    {
      'title': 'Introduction to Linux Systems',
      'category': 'Operating Systems',
      'description': '8 weeks, Beginner',
      'price': 59.99,
      "imageurl":
          "https://i.pcmag.com/imagery/roundups/03HzxsBLnETBkBt5BrRsFIY-1.fit_lim.size_850x490.v1643742425.jpg"
    },
    {
      'title': 'Windows Operating System Internals',
      'category': 'Operating Systems',
      'description': '10 weeks, Intermediate',
      'price': 64.99,
      "imageurl":
          "https://i.pcmag.com/imagery/roundups/03HzxsBLnETBkBt5BrRsFIY-1.fit_lim.size_850x490.v1643742425.jpg"
    },
    {
      'title': 'Real-Time Operating Systems',
      'category': 'Operating Systems',
      'description': '11 weeks, Advanced',
      'price': 74.99,
      "imageurl":
          "https://i.pcmag.com/imagery/roundups/03HzxsBLnETBkBt5BrRsFIY-1.fit_lim.size_850x490.v1643742425.jpg"
    },

    // Computer Networks
    {
      'title': 'Computer Networks: Basics to Advanced',
      'category': 'Computer Networks',
      'description': '9 weeks, Intermediate',
      'price': 54.99,
      'imageurl':
          "https://media.geeksforgeeks.org/wp-content/uploads/20230406152358/CN-(1).jpg"
    },
    {
      'title': 'Introduction to Computer Networks',
      'category': 'Computer Networks',
      'description': '8 weeks, Beginner',
      'price': 49.99,
      'imageurl':
          "https://media.geeksforgeeks.org/wp-content/uploads/20230406152358/CN-(1).jpg"
    },
    {
      'title': 'TCP/IP Protocol Suite',
      'category': 'Computer Networks',
      'description': '12 weeks, Advanced',
      'price': 74.99,
      'imageurl':
          "https://media.geeksforgeeks.org/wp-content/uploads/20230406152358/CN-(1).jpg"
    },

    // DBMS
    {
      'title': 'Introduction to DBMS',
      'category': 'DBMS',
      'description': '11 weeks, Beginner',
      'price': 64.99,
      'imageurl':
          "https://smsvaranasi.com/uploads/news/79/The-Considerations-And-Perks-Of-Choosing-A-DBMS-ITs-Guru.png"
    },
    {
      'title': 'Database Design and Management',
      'category': 'DBMS',
      'description': '12 weeks, Intermediate',
      'price': 74.99,
      'imageurl':
          "https://smsvaranasi.com/uploads/news/79/The-Considerations-And-Perks-Of-Choosing-A-DBMS-ITs-Guru.png"
    },
    {
      'title': 'Data Warehousing',
      'category': 'DBMS',
      'description': '14 weeks, Advanced',
      'price': 79.99,
      'imageurl':
          "https://smsvaranasi.com/uploads/news/79/The-Considerations-And-Perks-Of-Choosing-A-DBMS-ITs-Guru.png"
    },

    // Cyber Security
    {
      'title': 'Cyber Security Essentials',
      'category': 'Cyber Security',
      'description': '10 weeks, Intermediate',
      'price': 59.99,
      'imageurl':
          "https://theforage.wpengine.com/wp-content/uploads/2022/12/what-is-cybersecurity-1536x947.jpg"
    },
    {
      'title': 'Ethical Hacking',
      'category': 'Cyber Security',
      'description': '12 weeks, Advanced',
      'price': 74.99,
      'imageurl':
          "https://theforage.wpengine.com/wp-content/uploads/2022/12/what-is-cybersecurity-1536x947.jpg"
    },

    // Artificial Intelligence
    {
      'title': 'Artificial Intelligence and Machine Learning',
      'category': 'Artificial Intelligence',
      'description': '14 weeks, Advanced',
      'price': 79.99,
      'imageurl':
          'https://media.licdn.com/dms/image/v2/D5612AQHjDGhc8cNfJA/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1704439037481?e=1730332800&v=beta&t=h_Sq1eGjIiKQF97jfdDvevDKH2mxVhvJ2jt2Lr_Vn1o'
    },

    {
      'title': 'Reinforcement Learning',
      'category': 'Artificial Intelligence',
      'description': '16 weeks, Advanced',
      'price': 89.99,
      'imageurl':
          'https://media.licdn.com/dms/image/v2/D5612AQHjDGhc8cNfJA/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1704439037481?e=1730332800&v=beta&t=h_Sq1eGjIiKQF97jfdDvevDKH2mxVhvJ2jt2Lr_Vn1o'
    },
    // Programming Languages
    {
      'title': 'Mastering Python: From Basics to OOP',
      'category': 'Programming Languages',
      'description': '7 weeks, Beginner',
      'price': 39.99,
      "imageurl":
          "https://loudbench.com/wp-content/uploads/2023/02/Python-logo-696x392.png"
    },
    {
      'title': 'Java Programming for Beginners',
      'category': 'Programming Languages',
      'description': '10 weeks, Beginner',
      'price': 49.99,
      'imageurl':
          'https://www.devopsschool.com/blog/wp-content/uploads/2022/03/java_logo_icon_168609.png'
    },
    {
      'title': 'C++ Programming Essentials',
      'category': 'Programming Languages',
      'description': '12 weeks, Intermediate',
      'price': 59.99,
      "imageurl": "https://cloud.google.com/static/cpp/images/cpp-logo.png"
    },
    {
      'title': 'Advanced JavaScript Concepts',
      'category': 'Programming Languages',
      'description': '8 weeks, Intermediate',
      'price': 54.99,
      'imageurl':
          "https://miro.medium.com/v2/resize:fit:828/format:webp/1*LyZcwuLWv2FArOumCxobpA.png"
    },
    {
      'title': 'Functional Programming with Scala',
      'category': 'Programming Languages',
      'description': '14 weeks, Advanced',
      'price': 69.99,
      'imageurl':
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZCIzfauH5P4Lz0giB2mxbnKkJ8Kn4tT-zEw&s"
    },

    // Mobile Development
    {
      'title': 'Developing Android Apps with Kotlin',
      'category': 'Mobile Development',
      'description': '10 weeks, Intermediate',
      'price': 64.99,
      "imageurl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWwpZjviaGLAT52je89zklZqJzcX0-IBhJQA&s"
    },
    {
      'title': 'iOS App Development with Swift',
      'category': 'Mobile Development',
      'description': '12 weeks, Intermediate',
      'price': 69.99,
      "imageurl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWwpZjviaGLAT52je89zklZqJzcX0-IBhJQA&s"
    },

    {
      'title': 'Flutter Development for Beginners',
      'category': 'Mobile Development',
      'description': '10 weeks, Beginner',
      'price': 59.99,
      "imageurl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWwpZjviaGLAT52je89zklZqJzcX0-IBhJQA&s"
    },

    {
      'title': 'Introduction to Cloud Computing',
      'category': 'Cloud Computing',
      'description': '8 weeks, Beginner',
      'price': 59.99,
      'imageurl':
          "https://www.ingenious.co.uk/wp-content/uploads/2023/08/What-is-Cloud-Computing-and-How-Can-it-Benefit-Our-Company-1024x512.jpeg"
    },
    {
      'title': 'Big Data Analytics with Hadoop',
      'category': 'Big Data',
      'description': '12 weeks, Advanced',
      'price': 74.99,
      'imageurl':
          "https://cdn.prod.website-files.com/605c9e03d6553a5d82976ce2/661d7f1a5c164b271a7cd531_data-analysis-1024x576.webp"
    },
    {
      'title': 'Data Analytics with Python',
      'category': 'Data Analytics',
      'description': '10 weeks, Intermediate',
      'price': 69.99,
      'imageurl':
          "https://cdn.prod.website-files.com/605c9e03d6553a5d82976ce2/661d7f1a5c164b271a7cd531_data-analysis-1024x576.webp"
    },
    {
      'title': 'IoT Development with Raspberry Pi',
      'category': 'Internet of Things (IoT)',
      'description': '11 weeks, Advanced',
      'price': 79.99,
      'imageurl':
          "https://spin.atomicobject.com/wp-content/uploads/raspberry-pi-1.jpg"
    },
    {
      'title': 'Robotics: Basics and Applications',
      'category': 'Robotics',
      'description': '13 weeks, Intermediate',
      'price': 69.99,
      'imageurl':
          "https://s3-ap-south-1.amazonaws.com/ricedigitals3bucket/AUPortalContent/2023/07/25174434/efc290acf4d2f1573b4a87aa3999508b.png"
    },
    {
      'title': 'Software Engineering Principles',
      'category': 'Software Engineering',
      'description': '9 weeks, Beginner',
      'price': 54.99,
      'imageurl':
          "https://www.ingenious.co.uk/wp-content/uploads/2023/08/What-is-Cloud-Computing-and-How-Can-it-Benefit-Our-Company-1024x512.jpeg"
    },
  ];

  final Map<String, List<Map<String, Object>>> coursesByCategory = {};
  for (var course in allCourses) {
    final category = course['category'].toString();
    if (!coursesByCategory.containsKey(category)) {
      coursesByCategory[category] = [];
    }
    coursesByCategory[category]!.add(course);
  }

  // List of categories
  final categories = coursesByCategory.keys.toList();

  // Shuffle categories
  final random = Random();
  categories.shuffle(random);

  // Shuffle courses within each category
  final List<Map<String, Object>> shuffledCourses = [];
  for (var category in categories) {
    final courses = coursesByCategory[category]!;
    courses.shuffle(random);
    shuffledCourses.addAll(courses);
  }

  if (selectedCategory.isEmpty) {
    return shuffledCourses;
  } else {
    final normalizedCategory = selectedCategory
        .trim()
        .replaceAll('\n', '')
        .replaceAll(' ', '')
        .toLowerCase();

    return shuffledCourses
        .where((course) =>
            course['category']
                .toString()
                .trim()
                .replaceAll('\n', '')
                .replaceAll(' ', '')
                .toLowerCase() ==
            normalizedCategory)
        .toList();
  }
}
