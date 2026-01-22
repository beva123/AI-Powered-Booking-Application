import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'request_quote_screen.dart';

class DetailedWorkerProfileScreen extends StatefulWidget {
  final String workerId;
  final Map<String, dynamic> workerData;
  final Map<String, dynamic>? questionnaire;

  const DetailedWorkerProfileScreen({
    super.key,
    required this.workerId,
    required this.workerData,
    this.questionnaire,
  });

  @override
  State<DetailedWorkerProfileScreen> createState() => _DetailedWorkerProfileScreenState();
}

class _DetailedWorkerProfileScreenState extends State<DetailedWorkerProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Header Section
          _buildHeader(),
          // Action Buttons
          _buildActionButtons(),
          // Tab Bar
          _buildTabBar(),
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAboutTab(),
                _buildServicesTab(),
                _buildPortfolioTab(),
                _buildReviewsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF2E86AB), Color(0xFF1565C0)],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 35,
                    child: Text(
                      (widget.workerData['initial'] as String?) ?? 'JM',
                      style: TextStyle(
                        color: Color(0xFF2E86AB),
                        fontSize: 24,
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
                          (widget.workerData['name'] as String?) ?? 'John Martinez',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                            SizedBox(width: 4),
                            Icon(Icons.star, color: Colors.orange, size: 16),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      workerName: (widget.workerData['name'] as String?) ?? 'John Martinez',
                      workerId: widget.workerId,
                    ),
                  ),
                );
              },
              icon: Icon(Icons.message, color: Colors.white),
              label: Text('Message', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2E86AB),
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Calling ${(widget.workerData['name'] as String?) ?? 'worker'}...')),
                );
              },
              icon: Icon(Icons.phone, color: Colors.grey[700]),
              label: Text('Request Call', style: TextStyle(color: Colors.grey[700])),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey[300]!),
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: Color(0xFF2E86AB),
        unselectedLabelColor: Colors.grey[600],
        indicatorColor: Color(0xFF2E86AB),
        indicatorWeight: 2,
        tabs: [
          Tab(text: 'About'),
          Tab(text: 'Services'),
          Tab(text: 'Portfolio'),
          Tab(text: 'Reviews'),
        ],
      ),
    );
  }

  Widget _buildAboutTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // About Me Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
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
                  'About Me',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Experienced plumber with over 8 years in residential and commercial plumbing. I specialize in leak repairs, pipe installation, and bathroom renovations. Quality work guaranteed with all jobs backed by a 1-year warranty.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 16),
                // Specialty Tags
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildSpecialtyTag('Leak Repair'),
                    _buildSpecialtyTag('Pipe Installation'),
                    _buildSpecialtyTag('Bathroom Renovation'),
                    _buildSpecialtyTag('Emergency Plumbing'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          // Overview Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
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
                  'Overview',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _buildOverviewItem(
                        Icons.timeline,
                        'Experience',
                        '8+ years',
                        Color(0xFF2E86AB),
                      ),
                    ),
                    Expanded(
                      child: _buildOverviewItem(
                        Icons.check_circle,
                        'Completed Jobs',
                        '234',
                        Colors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildOverviewItem(
                        Icons.access_time,
                        'Response Time',
                        '< 2 hours',
                        Colors.orange,
                      ),
                    ),
                    Expanded(
                      child: _buildOverviewItem(
                        Icons.calendar_today,
                        'Member Since',
                        'March 2021',
                        Colors.purple,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesTab() {
    final services = [
      {
        'name': 'Leak Repair',
        'description': 'Fix all types of water leaks including faucets, pipes, and fixtures',
        'price': '\$75-150',
        'duration': '1-3 hours',
      },
      {
        'name': 'Pipe Installation',
        'description': 'New pipe installation and replacement for residential properties',
        'price': '\$200-500',
        'duration': '4-8 hours',
      },
      {
        'name': 'Bathroom Renovation',
        'description': 'Complete bathroom plumbing for renovation projects',
        'price': '\$800-2000',
        'duration': '2-5 days',
      },
      {
        'name': 'Emergency Service',
        'description': '24/7 emergency plumbing repairs',
        'price': '\$150-300',
        'duration': '1-2 hours',
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return Container(
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    service['name']!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    service['price']!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E86AB),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                service['description']!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                      SizedBox(width: 4),
                      Text(
                        service['duration']!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () => _bookService(service),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2E86AB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('Book Now', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPortfolioTab() {
    final portfolioItems = [
      {'title': 'Kitchen Leak Repair', 'image': Icons.kitchen},
      {'title': 'Bathroom Renovation', 'image': Icons.bathtub},
      {'title': 'Pipe Installation Process', 'image': Icons.play_circle},
      {'title': 'Emergency Fix', 'image': Icons.build},
      {'title': 'New Faucet Installation', 'image': Icons.water_drop}, // Changed from Icons.tap
      {'title': 'Shower Repair', 'image': Icons.shower},
    ];

    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemCount: portfolioItems.length,
      itemBuilder: (context, index) {
        final item = portfolioItems[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                item['image'] as IconData,
                size: 48,
                color: Colors.grey[500],
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  item['title'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700], // Changed from Colors.white to make text visible
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildReviewsTab() {
    final reviews = [
      {
        'name': 'Sarah Wilson',
        'initial': 'SW',
        'rating': 5,
        'date': 'Dec 15, 2024',
        'review': 'John was fantastic! Fixed our kitchen leak quickly and professionally. Very clean work and explained everything clearly.',
        'hasPhotos': true,
      },
      {
        'name': 'Mike Chen',
        'initial': 'MC',
        'rating': 5,
        'date': 'Dec 10, 2024',
        'review': 'Excellent service for our bathroom renovation. On time, within budget, and great quality work.',
        'hasPhotos': false,
      },
      {
        'name': 'Lisa Thompson',
        'initial': 'LT',
        'rating': 4,
        'date': 'Dec 5, 2024',
        'review': 'Good work on the emergency pipe repair. Arrived quickly and got it fixed. Would recommend.',
        'hasPhotos': true,
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: reviews.length + 1, // +1 for "Load More" button
      itemBuilder: (context, index) {
        if (index == reviews.length) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Loading more reviews...')),
                  );
                },
                child: Text('Load More Reviews'),
              ),
            ),
          );
        }

        final review = reviews[index];
        return Container(
          margin: EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
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
                    radius: 16,
                    child: Text(
                      review['initial'] as String,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          review['name'] as String,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Row(
                              children: List.generate(
                                5,
                                    (i) => Icon(
                                  Icons.star,
                                  size: 14,
                                  color: i < (review['rating'] as int)
                                      ? Colors.orange
                                      : Colors.grey[300],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    review['date'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                review['review'] as String,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),
              if (review['hasPhotos'] == true) ...[
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.photo, size: 14, color: Colors.grey[500]),
                    SizedBox(width: 4),
                    Text(
                      'Includes photos',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildSpecialtyTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Color(0xFF2E86AB).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF2E86AB).withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: Color(0xFF2E86AB),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildOverviewItem(IconData icon, String label, String value, Color color) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void _bookService(Map<String, String> service) {
    if (widget.questionnaire != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RequestQuoteScreen(
            professional: widget.workerData,
            questionnaire: widget.questionnaire!,
          ),
        ),
      );
    } else {
      final workerName = (widget.workerData['name'] as String?) ?? 'worker';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking ${service['name']} with $workerName...')),
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}