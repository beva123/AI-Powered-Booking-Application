import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'customer_home_screen.dart';
import 'become_professional_screen.dart';

class UserTypeSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How will you use FixMate?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Choose your primary purpose',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 40),
                // Looking for Services Option
                _buildServiceCard(
                  context: context,
                  backgroundColor: Color(0xFF2E86AB).withOpacity(0.1),
                  iconColor: Color(0xFF2E86AB),
                  buttonColor: Color(0xFF2E86AB),
                  icon: Icons.search,
                  title: 'Looking for Services',
                  description: 'Find skilled professionals for your home repairs, maintenance, and improvement projects',
                  features: ['Find Workers', 'Get Quotes', 'Book Services'],
                  buttonText: 'I Need Services',
                  userType: 'customer',
                ),
                SizedBox(height: 24),
                // Providing Services Option
                _buildServiceCard(
                  context: context,
                  backgroundColor: Color(0xFFF57C00).withOpacity(0.1),
                  iconColor: Color(0xFFF57C00),
                  buttonColor: Color(0xFFF57C00),
                  icon: Icons.build,
                  title: 'Providing Services',
                  description: 'Offer your skills and grow your business by connecting with clients who need your expertise',
                  features: ['Get Clients', 'Send Quotes', 'Earn More'],
                  buttonText: 'I Provide Services',
                  userType: 'worker',
                ),
                SizedBox(height: 40),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Text(
                      '💡 You can always switch between modes later in your profile',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 20), // Extra bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required BuildContext context,
    required Color backgroundColor,
    required Color iconColor,
    required Color buttonColor,
    required IconData icon,
    required String title,
    required String description,
    required List<String> features,
    required String buttonText,
    required String userType,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              size: 40,
              color: iconColor,
            ),
          ),
          SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: features.map((feature) => _buildFeatureChip(feature)).toList(),
          ),
          SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () => _selectUserType(context, userType),
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            size: 14,
            color: Colors.green,
          ),
          SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: Colors.green[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _selectUserType(BuildContext context, String userType) async {
    // Save user type
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_type', userType);

    if (userType == 'customer') {
      // Navigate to Customer Home Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CustomerHomeScreen()),
      );
    } else {
      // Navigate to Become Professional Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BecomeProfessionalScreen()),
      );
    }
  }
}