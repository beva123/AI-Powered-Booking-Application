import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationSelectionScreen extends StatefulWidget {
  final String currentLocation;

  const LocationSelectionScreen({Key? key, required this.currentLocation}) : super(key: key);

  @override
  _LocationSelectionScreenState createState() => _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  String selectedLocation = '';
  bool showConfirmButton = false;

  final List<Map<String, dynamic>> suggestedLocations = [
    {
      'city': 'San Francisco, CA',
      'fullAddress': 'San Francisco, California, USA',
      'distance': 'Current location',
      'isCurrent': true,
    },
    {
      'city': 'Oakland, CA',
      'fullAddress': 'Oakland, California, USA',
      'distance': '12 miles away',
      'isCurrent': false,
    },
    {
      'city': 'Berkeley, CA',
      'fullAddress': 'Berkeley, California, USA',
      'distance': '15 miles away',
      'isCurrent': false,
    },
    {
      'city': 'San Jose, CA',
      'fullAddress': 'San Jose, California, USA',
      'distance': '45 miles away',
      'isCurrent': false,
    },
    {
      'city': 'Palo Alto, CA',
      'fullAddress': 'Palo Alto, California, USA',
      'distance': '35 miles away',
      'isCurrent': false,
    },
  ];

  final List<String> recentLocations = [
    'San Francisco, CA',
    'Downtown SF',
    'Mission District, SF',
    'SOMA, San Francisco',
  ];

  @override
  void initState() {
    super.initState();
    selectedLocation = widget.currentLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Location',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Choose your service area',
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
          _buildSearchSection(),
          _buildMapPlaceholder(),
          Expanded(
            child: _buildLocationsList(),
          ),
          if (showConfirmButton) _buildConfirmButton(),
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
              hintText: 'Search for a location...',
              prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
          SizedBox(height: 12),
          GestureDetector(
            onTap: _useCurrentLocation,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.my_location, color: Color(0xFF2E86AB), size: 20),
                  SizedBox(width: 12),
                  Text(
                    'Use current location',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF2E86AB),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapPlaceholder() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Map View',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Stack(
              children: [
                // Map background
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [Colors.blue[50]!, Colors.green[50]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                // Location pins
                Positioned(
                  top: 60,
                  left: 80,
                  child: _buildMapPin(Colors.red, false),
                ),
                Positioned(
                  top: 80,
                  left: 120,
                  child: _buildMapPin(Color(0xFF2E86AB), true),
                ),
                Positioned(
                  top: 100,
                  left: 160,
                  child: _buildMapPin(Colors.blue, false),
                ),
                // Zoom controls
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.add, size: 20),
                          onPressed: () {},
                          constraints: BoxConstraints(minWidth: 32, minHeight: 32),
                        ),
                        Container(height: 1, color: Colors.grey[300]),
                        IconButton(
                          icon: Icon(Icons.remove, size: 20),
                          onPressed: () {},
                          constraints: BoxConstraints(minWidth: 32, minHeight: 32),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapPin(Color color, bool isSelected) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: isSelected ? Border.all(color: Colors.white, width: 3) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        Icons.location_on,
        color: Colors.white,
        size: 16,
      ),
    );
  }

  Widget _buildLocationsList() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSuggestedLocations(),
          SizedBox(height: 24),
          _buildRecentLocations(),
          SizedBox(height: 100), // Extra space for confirm button
        ],
      ),
    );
  }

  Widget _buildSuggestedLocations() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Suggested Locations',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12),
          Column(
            children: suggestedLocations.map((location) =>
                _buildLocationCard(
                  location['city'],
                  location['fullAddress'],
                  location['distance'],
                  location['isCurrent'],
                ),
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentLocations() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Locations',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12),
          Column(
            children: recentLocations.map((location) =>
                _buildRecentLocationCard(location),
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard(String city, String fullAddress, String distance, bool isCurrent) {
    bool isSelected = selectedLocation == city;

    return GestureDetector(
      onTap: () => _selectLocation(city),
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Color(0xFF2E86AB) : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: isSelected ? Color(0xFF2E86AB) : Colors.grey[400],
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    city,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    fullAddress,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  if (distance.isNotEmpty)
                    Text(
                      distance,
                      style: TextStyle(
                        fontSize: 12,
                        color: isCurrent ? Color(0xFF2E86AB) : Colors.grey[500],
                        fontWeight: isCurrent ? FontWeight.w500 : FontWeight.normal,
                      ),
                    ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Color(0xFF2E86AB),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentLocationCard(String location) {
    return GestureDetector(
      onTap: () => _selectLocation(location),
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.history,
              color: Colors.grey[400],
              size: 20,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                location,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _confirmLocation,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2E86AB),
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Confirm Location: $selectedLocation',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _selectLocation(String location) {
    setState(() {
      selectedLocation = location;
      showConfirmButton = location != widget.currentLocation;
    });
  }

  void _useCurrentLocation() {
    // Simulate getting current location
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Getting your current location...')),
    );

    // In a real app, you would use location services here
    Future.delayed(Duration(seconds: 1), () {
      _selectLocation('San Francisco, CA');
    });
  }

  void _confirmLocation() async {
    // Save the selected location
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_location', selectedLocation);

    // Return the selected location to the previous screen
    Navigator.pop(context, selectedLocation);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}