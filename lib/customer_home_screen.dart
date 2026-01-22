import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'worker_profile_screen.dart';
import 'chat_screen.dart';
import 'notifications_screen.dart';
import 'search_results_screen.dart';
import 'emergency_service_screen.dart';
import 'ai_chat_screen.dart';
import 'bookings_screen.dart';
import 'inbox_screen.dart';
import 'profile_screen.dart';
import 'electrical_questionnaire_screen.dart';
import 'plumbing_questionnaire_screen.dart';
import 'house_cleaning_questionnaire_screen.dart';
import 'handyman_questionnaire_screen.dart';
import 'hvac_questionnaire_screen.dart';
import 'location_selection_screen.dart';

class CustomerHomeScreen extends StatefulWidget {
  @override
  _CustomerHomeScreenState createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String userName = '';
  String userLocation = 'San Francisco, CA';
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name') ?? 'User';
      userLocation = prefs.getString('user_location') ?? 'San Francisco, CA';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header with location and profile
            _buildHeader(),
            // Search bar and emergency button
            _buildSearchSection(),
            // Main content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildServicesSection(),
                    SizedBox(height: 24),
                    _buildFeaturedWorkers(),
                    SizedBox(height: 24),
                    _buildRecentActivity(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () async {
                final selectedLocation = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LocationSelectionScreen(
                      currentLocation: userLocation,
                    ),
                  ),
                );

                if (selectedLocation != null) {
                  setState(() {
                    userLocation = selectedLocation;
                  });
                }
              },
              child: Row(
                children: [
                  Icon(Icons.location_on, color: Colors.grey[600], size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      userLocation,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey[400],
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsScreen()),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: _handleMenuSelection,
            icon: CircleAvatar(
              backgroundColor: Color(0xFF2E86AB),
              child: Text(
                userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(value: 'profile', child: Text('Profile')),
              PopupMenuItem(value: 'settings', child: Text('Settings')),
              PopupMenuItem(value: 'help', child: Text('Help & Support')),
              PopupMenuItem(value: 'logout', child: Text('Logout')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search for services or workers...',
              prefixIcon: Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchResultsScreen(query: value),
                  ),
                );
              }
            },
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmergencyServiceScreen()),
                );
              },
              icon: Icon(Icons.warning, color: Colors.white),
              label: Text(
                'Emergency Service',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesSection() {
    final services = [
      {'name': 'Plumbing', 'icon': Icons.plumbing, 'color': Colors.blue},
      {'name': 'Electrical', 'icon': Icons.electrical_services, 'color': Colors.orange},
      {'name': 'House Cleaning', 'icon': Icons.cleaning_services, 'color': Colors.green},
      {'name': 'Handyman', 'icon': Icons.handyman, 'color': Colors.orange},
      {'name': 'HVAC', 'icon': Icons.ac_unit, 'color': Colors.purple},
      {'name': 'Carpentry', 'icon': Icons.carpenter, 'color': Colors.brown},
      {'name': 'Painting', 'icon': Icons.format_paint, 'color': Colors.pink},
      {'name': 'Landscaping', 'icon': Icons.grass, 'color': Colors.green},
      {'name': 'Appliance Repair', 'icon': Icons.settings, 'color': Colors.grey},
      {'name': 'Pest Control', 'icon': Icons.bug_report, 'color': Colors.red},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Services',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            return _buildServiceCard(
              service['name'] as String,
              service['icon'] as IconData,
              service['color'] as Color,
            );
          },
        ),
      ],
    );
  }

  Widget _buildServiceCard(String serviceName, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        switch (serviceName) {
          case 'Electrical':
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => ElectricalQuestionnaireScreen(),
            ));
            break;
          case 'Plumbing':
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => PlumbingQuestionnaireScreen(),
            ));
            break;
          case 'House Cleaning':
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => HouseCleaningQuestionnaireScreen(),
            ));
            break;
          case 'Handyman':
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => HandymanQuestionnaireScreen(),
            ));
            break;
          case 'HVAC':
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => HVACQuestionnaireScreen(),
            ));
            break;
          default:
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => SearchResultsScreen(query: serviceName),
            ));
        }
      },
      child: Container(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            SizedBox(height: 12),
            Text(
              serviceName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedWorkers() {
    final workers = [
      {
        'name': 'John Martinez',
        'initial': 'JM',
        'service': 'Plumbing',
        'rating': 4.9,
        'reviews': 127,
        'distance': 0.8,
        'id': 'john_martinez'
      },
      {
        'name': 'Sarah Chen',
        'initial': 'SC',
        'service': 'Electrical',
        'rating': 4.8,
        'reviews': 89,
        'distance': 1.2,
        'id': 'sarah_chen'
      },
      {
        'name': 'Mike Thompson',
        'initial': 'MT',
        'service': 'HVAC',
        'rating': 4.7,
        'reviews': 156,
        'distance': 2.1,
        'id': 'mike_thompson'
      },
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Featured Workers',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to all workers screen
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('View All Workers - Coming Soon!')),
                );
              },
              child: Text('View All'),
            ),
          ],
        ),
        SizedBox(height: 12),
        Column(
          children: workers.map((worker) => _buildWorkerCard(worker)).toList(),
        ),
      ],
    );
  }

  Widget _buildWorkerCard(Map<String, dynamic> worker) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
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
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Color(0xFF2E86AB),
            radius: 24,
            child: Text(
              worker['initial'],
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  worker['name'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.star, color: Colors.orange, size: 16),
                    Text(
                      ' ${worker['rating']} (${worker['reviews']})',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(width: 12),
                    Text(
                      '${worker['distance']} mi',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(
                width: 80,
                height: 32,
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
                  child: Text(
                    'Book Now',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 8),
              SizedBox(
                width: 80,
                height: 32,
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
                  child: Text(
                    'Message',
                    style: TextStyle(fontSize: 10, color: Color(0xFF2E86AB)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Container(
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
              Text(
                'Your last booking was on Dec 18, 2024',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xFF2E86AB),
                    radius: 20,
                    child: Text(
                      'JM',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kitchen faucet repair by John Martinez',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: List.generate(5, (index) =>
                              Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.orange,
                              ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onBottomNavTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0xFF2E86AB),
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'AI Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inbox),
          label: 'Inbox',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }

  void _onBottomNavTap(int index) {
    if (index == _selectedIndex) return;

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
      // Home - already here
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AIChatScreen()),
        ).then((_) {
          setState(() {
            _selectedIndex = 0;
          });
        });
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookingsScreen()),
        ).then((_) {
          setState(() {
            _selectedIndex = 0;
          });
        });
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InboxScreen()),
        ).then((_) {
          setState(() {
            _selectedIndex = 0;
          });
        });
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        ).then((_) {
          setState(() {
            _selectedIndex = 0;
          });
        });
        break;
    }
  }

  void _handleMenuSelection(String value) {
    switch (value) {
      case 'profile':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        break;
      case 'settings':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Settings - Coming Soon!')),
        );
        break;
      case 'help':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Help & Support - Coming Soon!')),
        );
        break;
      case 'logout':
        _handleLogout();
        break;
    }
  }

  void _handleLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
          (route) => false,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}