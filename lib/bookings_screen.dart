import 'package:flutter/material.dart';
import 'worker_profile_screen.dart';
import 'chat_screen.dart';

class BookingsScreen extends StatefulWidget {
  @override
  _BookingsScreenState createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> upcomingBookings = [
    {
      'id': '1',
      'workerName': 'John Martinez',
      'workerInitial': 'JM',
      'service': 'Kitchen Faucet Repair',
      'date': 'Dec 22, 2024',
      'time': '2:00 PM',
      'address': '123 Main St, San Francisco',
      'price': 120,
      'status': 'Confirmed',
      'workerId': 'john_martinez'
    },
    {
      'id': '2',
      'workerName': 'Sarah Chen',
      'workerInitial': 'SC',
      'service': 'Outlet Installation',
      'date': 'Dec 24, 2024',
      'time': '10:00 AM',
      'address': '123 Main St, San Francisco',
      'price': 180,
      'status': 'Pending',
      'workerId': 'sarah_chen'
    },
  ];

  final List<Map<String, dynamic>> pastBookings = [
    {
      'id': '3',
      'workerName': 'Mike Thompson',
      'workerInitial': 'MT',
      'service': 'AC Maintenance',
      'date': 'Dec 18, 2024',
      'time': '3:00 PM',
      'address': '123 Main St, San Francisco',
      'price': 150,
      'status': 'Completed',
      'rating': 5,
      'workerId': 'mike_thompson'
    },
  ];

  final List<Map<String, dynamic>> cancelledBookings = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Color(0xFF2E86AB).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.person, color: Color(0xFF2E86AB), size: 20),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Bookings',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Services you have requested',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Color(0xFF2E86AB),
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: Color(0xFF2E86AB),
          indicatorWeight: 3,
          tabs: [
            Tab(text: 'Upcoming'),
            Tab(text: 'Past'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildUpcomingTab(),
          _buildPastTab(),
          _buildCancelledTab(),
        ],
      ),
    );
  }

  Widget _buildUpcomingTab() {
    if (upcomingBookings.isEmpty) {
      return _buildEmptyState(
        icon: Icons.calendar_today,
        title: 'No upcoming bookings',
        subtitle: 'Your scheduled appointments will appear here',
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: upcomingBookings.length,
      itemBuilder: (context, index) {
        return _buildUpcomingBookingCard(upcomingBookings[index]);
      },
    );
  }

  Widget _buildPastTab() {
    if (pastBookings.isEmpty) {
      return _buildEmptyState(
        icon: Icons.history,
        title: 'No past bookings',
        subtitle: 'Your completed services will appear here',
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: pastBookings.length,
      itemBuilder: (context, index) {
        return _buildPastBookingCard(pastBookings[index]);
      },
    );
  }

  Widget _buildCancelledTab() {
    return _buildEmptyState(
      icon: Icons.cancel_outlined,
      title: 'No cancelled bookings',
      subtitle: 'Your cancelled appointments will appear here',
    );
  }

  Widget _buildUpcomingBookingCard(Map<String, dynamic> booking) {
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
                radius: 24,
                child: Text(
                  booking['workerInitial'],
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          booking['workerName'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: booking['status'] == 'Confirmed'
                                ? Colors.green.withOpacity(0.1)
                                : Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            booking['status'],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: booking['status'] == 'Confirmed'
                                  ? Colors.green[700]
                                  : Colors.orange[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      booking['service'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
              SizedBox(width: 8),
              Text(
                '${booking['date']}',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(width: 16),
              Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
              SizedBox(width: 8),
              Text(
                booking['time'],
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  booking['address'],
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Price: \$${booking['price']}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _makeCall(booking['workerName']),
                  icon: Icon(Icons.phone, size: 16, color: Color(0xFF2E86AB)),
                  label: Text('Call', style: TextStyle(color: Color(0xFF2E86AB))),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xFF2E86AB)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _openChat(booking),
                  icon: Icon(Icons.message, size: 16, color: Color(0xFF2E86AB)),
                  label: Text('Message', style: TextStyle(color: Color(0xFF2E86AB))),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xFF2E86AB)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _viewBookingDetails(booking),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2E86AB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('View Details', style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ),
            ],
          ),
          if (booking['status'] == 'Pending') ...[
            SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _cancelBooking(booking),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Cancel', style: TextStyle(color: Colors.red)),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPastBookingCard(Map<String, dynamic> booking) {
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
                radius: 24,
                child: Text(
                  booking['workerInitial'],
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          booking['workerName'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            booking['status'],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      booking['service'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
              SizedBox(width: 8),
              Text(
                '${booking['date']}',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(width: 16),
              Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
              SizedBox(width: 8),
              Text(
                booking['time'],
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  booking['address'],
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Price: \$${booking['price']}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (booking['rating'] != null) ...[
            SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'Your rating: ',
                  style: TextStyle(fontSize: 14),
                ),
                Row(
                  children: List.generate(5, (index) =>
                      Icon(
                        Icons.star,
                        size: 16,
                        color: index < booking['rating'] ? Colors.orange : Colors.grey[300],
                      ),
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _viewBookingDetails(booking),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2E86AB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('View Details', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _makeCall(String workerName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Calling $workerName...')),
    );
  }

  void _openChat(Map<String, dynamic> booking) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          workerName: booking['workerName'],
          workerId: booking['workerId'],
        ),
      ),
    );
  }

  void _viewBookingDetails(Map<String, dynamic> booking) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Booking Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                _buildDetailRow('Service', booking['service']),
                _buildDetailRow('Worker', booking['workerName']),
                _buildDetailRow('Date', booking['date']),
                _buildDetailRow('Time', booking['time']),
                _buildDetailRow('Address', booking['address']),
                _buildDetailRow('Price', '\$${booking['price']}'),
                _buildDetailRow('Status', booking['status']),
                if (booking['rating'] != null)
                  _buildDetailRow('Rating', '${booking['rating']} stars'),
                SizedBox(height: 20),
                if (booking['status'] != 'Completed') ...[
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2E86AB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('Contact Worker', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: 12),
                ],
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey[400]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _cancelBooking(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cancel Booking'),
        content: Text('Are you sure you want to cancel this booking with ${booking['workerName']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Keep Booking'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                upcomingBookings.removeWhere((b) => b['id'] == booking['id']);
                cancelledBookings.add({...booking, 'status': 'Cancelled'});
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Booking cancelled successfully')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Cancel Booking', style: TextStyle(color: Colors.white)),
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