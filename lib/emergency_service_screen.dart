import 'package:flutter/material.dart';
import 'worker_profile_screen.dart';
import 'chat_screen.dart';

class EmergencyServiceScreen extends StatefulWidget {
  @override
  _EmergencyServiceScreenState createState() => _EmergencyServiceScreenState();
}

class _EmergencyServiceScreenState extends State<EmergencyServiceScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  String selectedUrgency = 'High';
  String selectedCategory = '';
  bool isLoading = false;
  List<Map<String, dynamic>> availableWorkers = [];

  final List<Map<String, dynamic>> emergencyCategories = [
    {
      'name': 'Plumbing Emergency',
      'icon': Icons.plumbing,
      'color': Colors.blue,
      'examples': ['Burst pipe', 'Water leak', 'No hot water', 'Sewage backup']
    },
    {
      'name': 'Electrical Emergency',
      'icon': Icons.electrical_services,
      'color': Colors.orange,
      'examples': ['Power outage', 'Sparking outlet', 'Circuit breaker tripping', 'Burning smell']
    },
    {
      'name': 'HVAC Emergency',
      'icon': Icons.ac_unit,
      'color': Colors.purple,
      'examples': ['No heating in winter', 'AC not working', 'Gas leak', 'Carbon monoxide alarm']
    },
    {
      'name': 'Security Emergency',
      'icon': Icons.security,
      'color': Colors.red,
      'examples': ['Broken lock', 'Door won\'t close', 'Window broken', 'Alarm system failure']
    },
    {
      'name': 'Other Emergency',
      'icon': Icons.emergency,
      'color': Colors.amber,
      'examples': ['Flooding', 'Roof leak', 'Structural damage', 'Other urgent issues']
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Emergency Service',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.phone, color: Colors.white),
            onPressed: () {
              _showEmergencyContacts();
            },
          ),
        ],
      ),
      body: selectedCategory.isEmpty
          ? _buildCategorySelection()
          : availableWorkers.isEmpty && !isLoading
          ? _buildEmergencyForm()
          : _buildWorkersList(),
    );
  }

  Widget _buildCategorySelection() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: Colors.red),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'For life-threatening emergencies, call 911 immediately',
                    style: TextStyle(
                      color: Colors.red[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          Text(
            'What type of emergency are you experiencing?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          ...emergencyCategories.map((category) => _buildCategoryCard(category)),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: () {
            setState(() {
              selectedCategory = category['name'];
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: category['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        category['icon'],
                        color: category['color'],
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        category['name'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  'Common issues: ${category['examples'].join(', ')}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmergencyForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    selectedCategory = '';
                  });
                },
              ),
              Text(
                selectedCategory,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Text(
            'Urgency Level',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: ['Low', 'Medium', 'High', 'Critical'].map((urgency) {
              final isSelected = selectedUrgency == urgency;
              Color getColor() {
                switch (urgency) {
                  case 'Low': return Colors.green;
                  case 'Medium': return Colors.orange;
                  case 'High': return Colors.red;
                  case 'Critical': return Colors.red[900]!;
                  default: return Colors.grey;
                }
              }

              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: urgency != 'Critical' ? 8 : 0),
                  child: FilterChip(
                    label: Text(urgency),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedUrgency = urgency;
                      });
                    },
                    selectedColor: getColor().withOpacity(0.2),
                    checkmarkColor: getColor(),
                    labelStyle: TextStyle(
                      color: isSelected ? getColor() : Colors.grey[700],
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 24),
          Text(
            'Describe the Problem',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _descriptionController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Please describe the emergency situation in detail. Include location, what happened, and any immediate safety concerns.',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
            ),
          ),
          SizedBox(height: 24),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _findEmergencyWorkers,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: isLoading
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Finding Emergency Workers...',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Find Emergency Workers',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            '💡 Emergency workers are available 24/7 and prioritize urgent calls',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWorkersList() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          color: Colors.green.withOpacity(0.1),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  '${availableWorkers.length} emergency workers found near you',
                  style: TextStyle(
                    color: Colors.green[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: availableWorkers.length,
            itemBuilder: (context, index) {
              return _buildEmergencyWorkerCard(availableWorkers[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmergencyWorkerCard(Map<String, dynamic> worker) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.withOpacity(0.3)),
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
              Stack(
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
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(
                        Icons.emergency,
                        size: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
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
                        SizedBox(width: 4),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '24/7',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${worker['service']} • Emergency Specialist',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 16),
                        Text(' ${worker['rating']} (${worker['reviews']})'),
                        SizedBox(width: 16),
                        Icon(Icons.location_on, color: Colors.red, size: 16),
                        Text(
                          ' ${worker['distance']} mi • ${worker['eta']} ETA',
                          style: TextStyle(color: Colors.red[700]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                '\$${worker['emergencyRate']}/hr',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.access_time, color: Colors.green, size: 16),
                SizedBox(width: 8),
                Text(
                  'Available now • Can arrive in ${worker['eta']}',
                  style: TextStyle(
                    color: Colors.green[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    _bookEmergencyService(worker);
                  },
                  icon: Icon(Icons.emergency, color: Colors.white),
                  label: Text('Book Emergency', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
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
                  icon: Icon(Icons.chat, color: Colors.red),
                  label: Text('Chat Now', style: TextStyle(color: Colors.red)),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _findEmergencyWorkers() {
    if (_descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please describe the emergency situation')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Simulate finding emergency workers
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
        availableWorkers = [
          {
            'name': 'Emergency Pro Services',
            'initial': 'EP',
            'service': 'Multi-Service',
            'rating': 4.9,
            'reviews': 234,
            'distance': 0.5,
            'eta': '15-20 min',
            'emergencyRate': 120,
            'id': 'emergency_pro'
          },
          {
            'name': 'John Martinez',
            'initial': 'JM',
            'service': 'Plumbing',
            'rating': 4.9,
            'reviews': 127,
            'distance': 0.8,
            'eta': '20-25 min',
            'emergencyRate': 110,
            'id': 'john_martinez'
          },
          {
            'name': '24/7 Fix Team',
            'initial': '24',
            'service': 'Emergency Repairs',
            'rating': 4.8,
            'reviews': 312,
            'distance': 1.2,
            'eta': '25-30 min',
            'emergencyRate': 100,
            'id': 'fix_team'
          },
        ];
      });
    });
  }

  void _bookEmergencyService(Map<String, dynamic> worker) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 8),
            Text('Confirm Emergency Booking'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Worker: ${worker['name']}'),
            Text('Service: Emergency ${selectedCategory.split(' ')[0]}'),
            Text('Rate: \$${worker['emergencyRate']}/hour'),
            Text('ETA: ${worker['eta']}'),
            SizedBox(height: 16),
            Text(
              'The worker will call you immediately to confirm details and provide an accurate arrival time.',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _confirmEmergencyBooking(worker);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Confirm Emergency', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _confirmEmergencyBooking(Map<String, dynamic> worker) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Emergency Service Booked!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 48),
            SizedBox(height: 16),
            Text(
              '${worker['name']} has been notified of your emergency and will call you within 2 minutes.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Expected arrival: ${worker['eta']}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Go back to home
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showEmergencyContacts() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Emergency Contacts'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.local_fire_department, color: Colors.red),
              title: Text('Fire Department'),
              subtitle: Text('911'),
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Calling Fire Department...')),
              ),
            ),
            ListTile(
              leading: Icon(Icons.local_police, color: Colors.blue),
              title: Text('Police'),
              subtitle: Text('911'),
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Calling Police...')),
              ),
            ),
            ListTile(
              leading: Icon(Icons.local_hospital, color: Colors.green),
              title: Text('Medical Emergency'),
              subtitle: Text('911'),
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Calling Medical Emergency...')),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}