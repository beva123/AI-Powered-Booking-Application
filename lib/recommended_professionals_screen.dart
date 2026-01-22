import 'package:flutter/material.dart';
// Make sure these imports match your actual file structure
import 'worker_profile_screen.dart';
import 'request_quote_screen.dart'; // Add this import

class RecommendedProfessionalsScreen extends StatefulWidget {
  final Map<String, dynamic> questionnaire;

  const RecommendedProfessionalsScreen({Key? key, required this.questionnaire}) : super(key: key);

  @override
  _RecommendedProfessionalsScreenState createState() => _RecommendedProfessionalsScreenState();
}

class _RecommendedProfessionalsScreenState extends State<RecommendedProfessionalsScreen> {
  String selectedSortOption = 'Sort by rating';
  List<Map<String, dynamic>> professionals = [];

  @override
  void initState() {
    super.initState();
    _generateRecommendations();
  }

  void _generateRecommendations() {
    // Generate mock professionals based on questionnaire
    professionals = [
      {
        'id': 'john_martinez',
        'name': 'John Martinez',
        'initial': 'JM',
        'company': 'Martinez Plumbing Pro',
        'service': 'Plumbing',
        'rating': 4.9,
        'reviews': 127,
        'distance': 0.8,
        'responseTime': '< 30 min',
        'hourlyRate': 85,
        'matchPercentage': 98,
        'specialties': ['Emergency Repairs', 'Pipe Installation'],
        'availability': 'Available now',
        'verified': true,
        'isAvailable': true,
      },
      {
        'id': 'emily_rodriguez',
        'name': 'Emily Rodriguez',
        'initial': 'ER',
        'company': 'Rodriguez Expert Care',
        'service': 'House Cleaning',
        'rating': 4.9,
        'reviews': 234,
        'distance': 3.2,
        'responseTime': '< 1 hr',
        'hourlyRate': 90,
        'matchPercentage': 90,
        'specialties': ['Premium Service', 'Warranty Work'],
        'availability': 'Available now',
        'verified': true,
        'isAvailable': true,
      },
      {
        'id': 'sarah_chen',
        'name': 'Sarah Chen',
        'initial': 'SC',
        'company': 'Chen Professional Services',
        'service': 'Electrical',
        'rating': 4.8,
        'reviews': 89,
        'distance': 1.2,
        'responseTime': '< 1 hr',
        'hourlyRate': 75,
        'matchPercentage': 85,
        'specialties': ['Residential', 'Commercial'],
        'availability': 'Available today',
        'verified': true,
        'isAvailable': true,
      },
      {
        'id': 'mike_thompson',
        'name': 'Mike Thompson',
        'initial': 'MT',
        'company': 'Thompson Repair Solutions',
        'service': 'HVAC',
        'rating': 4.7,
        'reviews': 156,
        'distance': 2.1,
        'responseTime': '< 2 hrs',
        'hourlyRate': 80,
        'matchPercentage': 82,
        'specialties': ['Maintenance', 'Upgrades'],
        'availability': 'Available tomorrow',
        'verified': true,
        'isAvailable': false,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final matchedCount = professionals.length;
    final serviceName = widget.questionnaire['service'] ?? 'Services';

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Recommended Professionals',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$serviceName • $matchedCount matches found',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Filter and Sort bar
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                OutlinedButton.icon(
                  onPressed: _showFilterDialog,
                  icon: Icon(Icons.filter_list, size: 18),
                  label: Text('Filter'),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey[400]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _showSortDialog,
                    icon: Icon(Icons.sort, size: 18),
                    label: Text(
                      selectedSortOption,
                      overflow: TextOverflow.ellipsis,
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey[400]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Requirements summary
          if (_hasRequirements())
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF2E86AB).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFF2E86AB).withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Based on your requirements:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2E86AB),
                    ),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: _buildRequirementChips(),
                  ),
                ],
              ),
            ),
          // Professionals list
          Expanded(
            child: professionals.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: professionals.length,
              itemBuilder: (context, index) {
                return _buildProfessionalCard(professionals[index]);
              },
            ),
          ),
          // Bottom actions
          if (professionals.isNotEmpty) _buildBottomActions(),
        ],
      ),
    );
  }

  bool _hasRequirements() {
    return widget.questionnaire['issueType'] != null ||
        widget.questionnaire['location'] != null ||
        widget.questionnaire['urgency'] != null;
  }

  List<Widget> _buildRequirementChips() {
    List<Widget> chips = [];

    if (widget.questionnaire['issueType'] != null) {
      chips.add(_buildRequirementChip(widget.questionnaire['issueType']));
    }
    if (widget.questionnaire['location'] != null) {
      chips.add(_buildRequirementChip(widget.questionnaire['location']));
    }
    if (widget.questionnaire['urgency'] != null) {
      chips.add(_buildRequirementChip(widget.questionnaire['urgency']));
    }

    // Add "more" button if there are additional requirements
    if (_getAdditionalRequirementsCount() > 0) {
      chips.add(
        TextButton(
          onPressed: _showAllRequirements,
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            '+${_getAdditionalRequirementsCount()} more',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF2E86AB),
            ),
          ),
        ),
      );
    }

    return chips;
  }

  int _getAdditionalRequirementsCount() {
    int count = 0;
    if (widget.questionnaire['budget'] != null) count++;
    if (widget.questionnaire['description'] != null) count++;
    if (widget.questionnaire['serviceType'] != null) count++;
    return count;
  }

  Widget _buildRequirementChip(String text) {
    if (text.isEmpty) return SizedBox.shrink();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF2E86AB).withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: Color(0xFF2E86AB),
        ),
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
            'No professionals found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Try adjusting your search criteria',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionalCard(Map<String, dynamic> professional) {
    return GestureDetector(
      onTap: () => _viewProfessionalProfile(professional),
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFF2E86AB), width: 2),
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
          children: [
            // Match percentage header
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${professional['matchPercentage']}% Match',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _toggleFavorite(professional['id']),
                    child: Icon(Icons.favorite_border, color: Colors.white, size: 16),
                  ),
                ],
              ),
            ),
            // Professional info
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Profile picture and status
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0xFF2E86AB),
                            radius: 20,
                            child: Text(
                              professional['initial'] ?? '',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (professional['verified'] == true)
                            Positioned(
                              right: -2,
                              top: -2,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 1),
                                ),
                                child: Icon(
                                  Icons.verified,
                                  size: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              professional['name'] ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              professional['company'] ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Online status
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: (professional['isAvailable'] == true) ? Colors.green : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  // Rating and details row
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 16),
                        SizedBox(width: 4),
                        Text(
                          '${professional['rating'] ?? 0} (${professional['reviews'] ?? 0})',
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(width: 16),
                        Icon(Icons.location_on, color: Colors.grey, size: 16),
                        SizedBox(width: 4),
                        Text(
                          '${professional['distance'] ?? 0} mi',
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(width: 16),
                        Icon(Icons.access_time, color: Colors.grey, size: 16),
                        SizedBox(width: 4),
                        Text(
                          professional['responseTime'] ?? '',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  // Specialties
                  if (professional['specialties'] != null)
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: (professional['specialties'] as List<dynamic>).map<Widget>((specialty) =>
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              specialty.toString(),
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.blue[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ).toList(),
                    ),
                  SizedBox(height: 12),
                  // Availability and rate
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              professional['availability'] ?? '',
                              style: TextStyle(
                                fontSize: 12,
                                color: (professional['isAvailable'] == true) ? Colors.green[700] : Colors.orange[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '\$${professional['hourlyRate'] ?? 0}/hr',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            child: OutlinedButton(
                              onPressed: () => _openChat(professional),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                side: BorderSide(color: Color(0xFF2E86AB)),
                                shape: CircleBorder(),
                              ),
                              child: Icon(
                                Icons.message,
                                size: 16,
                                color: Color(0xFF2E86AB),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            width: 32,
                            height: 32,
                            child: OutlinedButton(
                              onPressed: () => _callProfessional(professional),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                side: BorderSide(color: Colors.green),
                                shape: CircleBorder(),
                              ),
                              child: Icon(
                                Icons.phone,
                                size: 16,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () => _requestQuote(professional),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF2E86AB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Get Quote',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ],
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

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('Refine Search'),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: _contactTopMatch,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2E86AB),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Contact Top Match',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Filter Options',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Distance'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Rating'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text('Price Range'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text('Availability'),
              onTap: () => Navigator.pop(context),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showSortDialog() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Sort By',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Text('Rating'),
              trailing: selectedSortOption.contains('rating') ? Icon(Icons.check, color: Color(0xFF2E86AB)) : null,
              onTap: () {
                setState(() {
                  selectedSortOption = 'Sort by rating';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Distance'),
              trailing: selectedSortOption.contains('distance') ? Icon(Icons.check, color: Color(0xFF2E86AB)) : null,
              onTap: () {
                setState(() {
                  selectedSortOption = 'Sort by distance';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Price'),
              trailing: selectedSortOption.contains('price') ? Icon(Icons.check, color: Color(0xFF2E86AB)) : null,
              onTap: () {
                setState(() {
                  selectedSortOption = 'Sort by price';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Availability'),
              trailing: selectedSortOption.contains('availability') ? Icon(Icons.check, color: Color(0xFF2E86AB)) : null,
              onTap: () {
                setState(() {
                  selectedSortOption = 'Sort by availability';
                });
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showAllRequirements() {
    final requirements = <String, dynamic>{};

    if (widget.questionnaire['service'] != null) requirements['Service'] = widget.questionnaire['service'];
    if (widget.questionnaire['issueType'] != null) requirements['Issue'] = widget.questionnaire['issueType'];
    if (widget.questionnaire['location'] != null) requirements['Location'] = widget.questionnaire['location'];
    if (widget.questionnaire['urgency'] != null) requirements['Urgency'] = widget.questionnaire['urgency'];
    if (widget.questionnaire['budget'] != null) requirements['Budget'] = widget.questionnaire['budget'];
    if (widget.questionnaire['description'] != null) requirements['Description'] = widget.questionnaire['description'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Your Requirements'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: requirements.entries.map((entry) =>
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text('${entry.key}: ${entry.value}'),
                )
            ).toList(),
          ),
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

  void _viewProfessionalProfile(Map<String, dynamic> professional) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkerProfileScreen(
          workerId: professional['id'] ?? '',
          workerData: professional,
        ),
      ),
    );
  }

  void _openChat(Map<String, dynamic> professional) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening chat with ${professional['name']}...')),
    );
  }

  void _callProfessional(Map<String, dynamic> professional) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Calling ${professional['name']}...')),
    );
  }

  // FIXED: This method now properly navigates to RequestQuoteScreen
  void _requestQuote(Map<String, dynamic> professional) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RequestQuoteScreen(
          professional: professional,
          questionnaire: widget.questionnaire,
        ),
      ),
    );
  }

  void _contactTopMatch() {
    if (professionals.isNotEmpty) {
      _requestQuote(professionals.first);
    }
  }

  void _toggleFavorite(String professionalId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Favorite toggled')),
    );
  }
}