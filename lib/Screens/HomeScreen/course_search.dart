import 'package:flutter/material.dart';

class CourseSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> courses;
  String selectedCategory = 'All';
  String selectedPriceRange = 'All';

  CourseSearchDelegate({required this.courses});

  List<String> get categories =>
      ['All', ...courses.map((c) => c['category'] as String).toSet()];
  List<String> get priceRanges => ['All', '0-20', '20-50', '50-75', '75+'];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    return Column(
      children: [
        _buildFilters(context),
        Expanded(
          child: _buildFilteredCourseList(context),
        ),
      ],
    );
  }

  Widget _buildFilters(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: _buildDropdown(
              context: context,
              value: selectedCategory,
              items: categories,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  selectedCategory = newValue;
                  showResults(context);
                }
              },
              hint: 'Category',
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildDropdown(
              context: context,
              value: selectedPriceRange,
              items: priceRanges,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  selectedPriceRange = newValue;
                  showResults(context);
                }
              },
              hint: 'Price Range',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required BuildContext context,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
    required String hint,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
        underline: Container(
          height: 0,
        ),
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        hint: Text(hint),
      ),
    );
  }

  Widget _buildFilteredCourseList(BuildContext context) {
    final filteredCourses = courses.where((course) {
      final matchesQuery = course['title']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          course['category']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          course['description']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase());

      final matchesCategory =
          selectedCategory == 'All' || course['category'] == selectedCategory;

      final price = course['price'] as double;
      final matchesPrice = selectedPriceRange == 'All' ||
          (selectedPriceRange == '0-20' && price <= 20) ||
          (selectedPriceRange == '20-50' && price > 20 && price <= 50) ||
          (selectedPriceRange == '50-75' && price > 50 && price <= 75) ||
          (selectedPriceRange == '75+' && price > 75);

      return matchesQuery && matchesCategory && matchesPrice;
    }).toList();

    return ListView.builder(
      itemCount: filteredCourses.length,
      itemBuilder: (context, index) {
        final course = filteredCourses[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () {
                close(context, course['title'] as String);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.network(
                      course['imageurl'] as String,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course['title'] as String,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.category,
                                size: 16,
                                color: Theme.of(context).colorScheme.secondary),
                            const SizedBox(width: 4),
                            Text(
                              course['category'] as String,
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          course['description'] as String,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.8),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${course['price']}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Handle enrollment
                              },
                              child: const Text('Enroll Now'),
                            ),
                          ],
                        ),
                      ],
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
