import 'package:flutter/material.dart';

class WorkerProfileScreen extends StatefulWidget {
  final String workerId;
  final Map<String, dynamic> workerData;

  const WorkerProfileScreen({
    Key? key,
    required this.workerId,
    required this.workerData,
  }) : super(key: key);

  @override
  _WorkerProfileScreenState createState() => _WorkerProfileScreenState();
}

class _WorkerProfileScreenState extends State<WorkerProfileScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          _buildActionButtons(),
          _buildTabBar(),
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
      height: 280,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2E86AB), Color(0xFF4A9CD1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  IconButton(
                    icon: Icon(Icons.share, color: Colors.white),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Share profile - Coming Soon!')),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Profile Info
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50,
                    child: Text(
                      widget.workerData['initial'] ?? 'JM',
                      style: TextStyle(
                        color: Color(0xFF2E86AB),
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.workerData['name'] ?? 'John Martinez',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      Text(
                        'Available Now',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      SizedBox(width: 16),
                      Icon(Icons.star, color: Colors.orange, size: 16),
                      Text(
                        ' ${widget.workerData['rating'] ?? 4.9}',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Opening chat with ${widget.workerData['name']}...')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2E86AB),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.message, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Message',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Request call - Coming Soon!')),
                );
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey[400]!),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone, color: Colors.grey[700], size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Request Call',
                    style: TextStyle(color: Colors.grey[700], fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
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
        labelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        indicatorColor: Color(0xFF2E86AB),
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
          _buildAboutMeSection(),
          SizedBox(height: 24),
          _buildOverviewSection(),
        ],
      ),
    );
  }

  Widget _buildAboutMeSection() {
    return Container(
      padding: EdgeInsets.all(20),
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
              fontSize: 16,
              height: 1.5,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildSpecialtyChip('Leak Repair'),
              _buildSpecialtyChip('Pipe Installation'),
              _buildSpecialtyChip('Bathroom Renovation'),
              _buildSpecialtyChip('Emergency Plumbing'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialtyChip(String specialty) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xFF2E86AB).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFF2E86AB).withOpacity(0.3)),
      ),
      child: Text(
        specialty,
        style: TextStyle(
          fontSize: 12,
          color: Color(0xFF2E86AB),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildOverviewSection() {
    return Container(
      padding: EdgeInsets.all(20),
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
            'Overview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildStatCard(Icons.work_outline, Color(0xFF2E86AB), 'Experience', '8+ years')),
              SizedBox(width: 12),
              Expanded(child: _buildStatCard(Icons.check_circle_outline, Colors.green, 'Completed Jobs', '234')),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildStatCard(Icons.schedule, Colors.orange, 'Response Time', '< 2 hours')),
              SizedBox(width: 12),
              Expanded(child: _buildStatCard(Icons.calendar_today, Colors.purple, 'Member Since', 'March 2021')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(IconData icon, Color color, String label, String value) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesTab() {
    final services = [
      {'name': 'Leak Repair', 'price': '\$75-150', 'duration': '1-3 hours', 'description': 'Fix all types of water leaks including faucets, pipes, and fixtures'},
      {'name': 'Pipe Installation', 'price': '\$200-500', 'duration': '4-8 hours', 'description': 'New pipe installation and replacement for residential properties'},
      {'name': 'Bathroom Renovation', 'price': '\$800-2000', 'duration': '2-5 days', 'description': 'Complete bathroom plumbing for renovation projects'},
      {'name': 'Emergency Service', 'price': '\$150-300', 'duration': '1-2 hours', 'description': '24/7 emergency plumbing repairs'},
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: services.map((service) => _buildServiceCard(service)).toList(),
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                service['name'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                service['price'],
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
            service['description'],
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.schedule, size: 16, color: Colors.grey[500]),
                  SizedBox(width: 4),
                  Text(
                    service['duration'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () => _showBookingDialog(context, service['name']),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2E86AB),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Book Now',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioTab() {
    final portfolioItems = [
      'Kitchen Leak Repair',
      'Bathroom Renovation',
      'Pipe Installation Process',
      'Emergency Fix',
      'New Faucet Installation',
      'Shower Repair',
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
        return _buildPortfolioItem(portfolioItems[index]);
      },
    );
  }

  Widget _buildPortfolioItem(String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.camera_alt,
            size: 40,
            color: Colors.grey[400],
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsTab() {
    final reviews = [
      {
        'name': 'Sarah Wilson',
        'initial': 'SW',
        'rating': 5,
        'date': 'Dec 15, 2024',
        'comment': 'John was fantastic! Fixed our kitchen leak quickly and professionally. Very clean work and explained everything clearly.',
        'hasPhotos': true,
      },
      {
        'name': 'Mike Chen',
        'initial': 'MC',
        'rating': 5,
        'date': 'Dec 10, 2024',
        'comment': 'Excellent service for our bathroom renovation. On time, within budget, and great quality work.',
        'hasPhotos': true,
      },
      {
        'name': 'Lisa Thompson',
        'initial': 'LT',
        'rating': 4,
        'date': 'Dec 5, 2024',
        'comment': 'Good work on the emergency pipe repair. Arrived quickly and got it fixed. Would recommend.',
        'hasPhotos': false,
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          ...reviews.map((review) => _buildReviewCard(review)).toList(),
          SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Load more reviews - Coming Soon!')),
              );
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Color(0xFF2E86AB)),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Load More Reviews',
              style: TextStyle(color: Color(0xFF2E86AB)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
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
                radius: 20,
                child: Text(
                  review['initial'],
                  style: TextStyle(
                    color: Colors.white,
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
                      review['name'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: List.generate(5, (index) =>
                          Icon(
                            Icons.star,
                            size: 16,
                            color: index < review['rating'] ? Colors.orange : Colors.grey[300],
                          ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                review['date'],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            review['comment'],
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
          if (review['hasPhotos']) ...[
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.photo, size: 16, color: Colors.grey[500]),
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
  }

  void _showBookingDialog(BuildContext context, String serviceName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Book $serviceName'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Select a date and time for your $serviceName booking:'),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.today),
              title: Text('Today'),
              subtitle: Text('Available 2:00 PM - 6:00 PM'),
              onTap: () {
                Navigator.pop(context);
                _confirmBooking(context, 'Today', serviceName);
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Tomorrow'),
              subtitle: Text('Available 9:00 AM - 5:00 PM'),
              onTap: () {
                Navigator.pop(context);
                _confirmBooking(context, 'Tomorrow', serviceName);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _confirmBooking(BuildContext context, String date, String serviceName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Booking Confirmed!'),
        content: Text(
          'Your $serviceName booking with ${widget.workerData['name']} for $date has been confirmed.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}