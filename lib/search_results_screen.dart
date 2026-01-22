import 'package:flutter/material.dart';
import 'worker_profile_screen.dart';
import 'chat_screen.dart';

class SearchResultsScreen extends StatefulWidget {
  final String query;

  const SearchResultsScreen({Key? key, required this.query}) : super(key: key);

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];
  bool isLoading = false;
  String selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.query;
    _performSearch();
  }

  void _performSearch() {
    setState(() {
      isLoading = true;
    });

    // Simulate search delay
    Future.delayed(Duration(milliseconds: 800), () {
      setState(() {
        searchResults = _getSearchResults(widget.query);
        isLoading = false;
      });
    });
  }

  List<Map<String, dynamic>> _getSearchResults(String query) {
    // Mock search results based on query
    final allResults = [
      {
        'name': 'John Martinez',
        'initial': 'JM',
        'service': 'Plumbing',
        'rating': 4.9,
        'reviews': 127,
        'distance': 0.8,
        'hourlyRate': 80,
        'availability': 'Available Today',
        'specialties': ['Emergency Repairs', 'Faucet Installation', 'Pipe Repair'],
        'verified': true,
        'id': 'john_martinez'
      },
      {
        'name': 'Sarah Chen',
        'initial': 'SC',
        'service': 'Electrical',
        'rating': 4.8,
        'reviews': 89,
        'distance': 1.2,
        'hourlyRate': 85,
        'availability': 'Available Tomorrow',
        'specialties': ['Wiring', 'Panel Upgrades', 'Lighting Installation'],
        'verified': true,
        'id': 'sarah_chen'
      },
      {
        'name': 'Mike Thompson',
        'initial': 'MT',
        'service': 'HVAC',
        'rating': 4.7,
        'reviews': 156,
        'distance': 2.1,
        'hourlyRate': 90,
        'availability': 'Available This Week',
        'specialties': ['AC Repair', 'Heating Systems', 'Maintenance'],
        'verified': true,
        'id': 'mike_thompson'
      },
      {
        'name': 'Lisa Rodriguez',
        'initial': 'LR',
        'service': 'House Cleaning',
        'rating': 4.6,
        'reviews': 203,
        'distance': 1.5,
        'hourlyRate': 45,
        'availability': 'Available Today',
        'specialties': ['Deep Cleaning', 'Regular Maintenance', 'Move-out Cleaning'],
        'verified': true,
        'id': 'lisa_rodriguez'
      },
      {
        'name': 'David Kim',
        'initial': 'DK',
        'service': 'Handyman',
        'rating': 4.5,
        'reviews': 98,
        'distance': 3.2,
        'hourlyRate': 65,
        'availability': 'Available Tomorrow',
        'specialties': ['Furniture Assembly', 'Small Repairs', 'Painting Touch-ups'],
        'verified': false,
        'id': 'david_kim'
      },
    ];

    // Filter results based on query
    return allResults.where((worker) {
      final queryLower = query?.toLowerCase() ?? "";

      final service = (worker['service'] as String?)?.toLowerCase() ?? "";
      final name = (worker['name'] as String?)?.toLowerCase() ?? "";
      final specialties = (worker['specialties'] as List?) ?? [];

      return service.contains(queryLower) ||
          name.contains(queryLower) ||
          specialties.any((specialty) =>
          (specialty as String?)?.toLowerCase().contains(queryLower) ?? false);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Container(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search for services or workers...',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  searchResults = _getSearchResults(value);
                });
              }
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.black),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterChips(),
          _buildSearchHeader(),
          Expanded(
            child: isLoading
                ? _buildLoadingState()
                : searchResults.isEmpty
                ? _buildEmptyState()
                : _buildResultsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = ['All', 'Nearest', 'Highest Rated', 'Available Today', 'Verified'];

    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedFilter == filter;

          return Container(
            margin: EdgeInsets.only(right: 8, top: 8, bottom: 8),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  selectedFilter = selected ? filter : 'All';
                });
                _applyFilter(selectedFilter);
              },
              selectedColor: Color(0xFF2E86AB).withOpacity(0.2),
              checkmarkColor: Color(0xFF2E86AB),
              labelStyle: TextStyle(
                color: isSelected ? Color(0xFF2E86AB) : Colors.grey[700],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${searchResults.length} results for "${widget.query}"',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Icon(Icons.sort, size: 16, color: Colors.grey[600]),
              SizedBox(width: 4),
              Text(
                'Sort by Rating',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Color(0xFF2E86AB),
          ),
          SizedBox(height: 16),
          Text(
            'Searching for workers...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            'No workers found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Try searching with different keywords',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                searchResults = _getSearchResults('');
              });
            },
            child: Text('Show All Workers'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2E86AB),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return _buildWorkerCard(searchResults[index]);
      },
    );
  }

  Widget _buildWorkerCard(Map<String, dynamic> worker) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Color(0xFF2E86AB),
                radius: 30,
                child: Text(
                  worker['initial'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          worker['name'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (worker['verified']) ...[
                          SizedBox(width: 4),
                          Icon(
                            Icons.verified,
                            color: Colors.blue,
                            size: 16,
                          ),
                        ],
                      ],
                    ),
                    Text(
                      worker['service'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 16),
                        Text(
                          ' ${worker['rating']} (${worker['reviews']})',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(width: 16),
                        Icon(Icons.location_on, color: Colors.grey, size: 16),
                        Text(
                          ' ${worker['distance']} mi',
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${worker['hourlyRate']}/hr',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E86AB),
                    ),
                  ),
                  Text(
                    worker['availability'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Specialties: ${worker['specialties'].join(', ')}',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkerProfileScreen(
                          workerId: worker['id'],
                          workerData: worker,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2E86AB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Book Now', style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          workerName: worker['name'],
                          workerId: worker['id'],
                        ),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xFF2E86AB)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Message', style: TextStyle(color: Color(0xFF2E86AB))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter Results',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Distance'),
              subtitle: Text('Sort by nearest first'),
              onTap: () {
                Navigator.pop(context);
                _applyFilter('Nearest');
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Rating'),
              subtitle: Text('Highest rated first'),
              onTap: () {
                Navigator.pop(context);
                _applyFilter('Highest Rated');
              },
            ),
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text('Availability'),
              subtitle: Text('Available today'),
              onTap: () {
                Navigator.pop(context);
                _applyFilter('Available Today');
              },
            ),
            ListTile(
              leading: Icon(Icons.verified),
              title: Text('Verification'),
              subtitle: Text('Verified workers only'),
              onTap: () {
                Navigator.pop(context);
                _applyFilter('Verified');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _applyFilter(String filter) {
    setState(() {
      selectedFilter = filter;

      switch (filter) {
        case 'Nearest':
          searchResults.sort((a, b) => (a['distance'] as double).compareTo(b['distance'] as double));
          break;
        case 'Highest Rated':
          searchResults.sort((a, b) => (b['rating'] as double).compareTo(a['rating'] as double));
          break;
        case 'Available Today':
          searchResults = searchResults.where((w) => w['availability'].contains('Today')).toList();
          break;
        case 'Verified':
          searchResults = searchResults.where((w) => w['verified'] == true).toList();
          break;
        case 'All':
          searchResults = _getSearchResults(_searchController.text);
          break;
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}