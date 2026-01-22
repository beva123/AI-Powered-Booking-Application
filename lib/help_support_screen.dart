import 'package:flutter/material.dart';

class HelpSupportScreen extends StatefulWidget {
  @override
  _HelpSupportScreenState createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  String selectedCategory = '';
  bool markAsUrgent = false;

  final Map<String, List<Map<String, String>>> helpTopics = {
    'Booking & Services': [
      {
        'question': 'How do I book a service?',
        'answer': 'Select a service category, fill out the questionnaire, and choose from recommended professionals.',
      },
      {
        'question': 'What if I need to cancel a booking?',
        'answer': 'You can cancel bookings up to 2 hours before the scheduled time in the Bookings tab.',
      },
      {
        'question': 'How do I update my location?',
        'answer': 'Tap the location icon at the top of the home screen to update your service area.',
      },
    ],
    'Payment & Billing': [
      {
        'question': 'How are payments processed?',
        'answer': 'Payments are securely processed through our platform after service completion.',
      },
      {
        'question': 'Can I add multiple payment methods?',
        'answer': 'Yes, you can add multiple cards and payment methods in your profile settings.',
      },
      {
        'question': 'What if there\'s an issue with my payment?',
        'answer': 'Contact our support team immediately if you notice any payment discrepancies.',
      },
    ],
    'Account & Profile': [
      {
        'question': 'How do I become a professional?',
        'answer': 'Tap "Switch to Professional" in your profile and complete the onboarding process.',
      },
      {
        'question': 'How do I update my location?',
        'answer': 'Tap the location icon at the top of the home screen to update your service area.',
      },
      {
        'question': 'How do I change my profile information?',
        'answer': 'Go to Profile > Edit Profile to update your personal information.',
      },
    ],
    'Technical Issues': [
      {
        'question': 'The app is running slowly',
        'answer': 'Try restarting the app or clearing your device cache. Contact support if issues persist.',
      },
      {
        'question': 'I can\'t receive notifications',
        'answer': 'Check your notification settings in both the app and your device settings.',
      },
      {
        'question': 'Login issues',
        'answer': 'Try resetting your password or contact support for assistance.',
      },
    ],
  };

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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Help & Support',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Get help with FixMate',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            if (selectedCategory.isEmpty) ...[
              // Contact Support Section
              _buildSection(
                title: 'Contact Support',
                child: Column(
                  children: [
                    _buildContactOption(
                      icon: Icons.chat_bubble_outline,
                      title: 'Live Chat',
                      subtitle: 'Chat with our support team',
                      availability: 'Available 24/7',
                      iconColor: Color(0xFF2E86AB),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Starting live chat...')),
                        );
                      },
                    ),
                    SizedBox(height: 12),
                    _buildContactOption(
                      icon: Icons.phone_outlined,
                      title: 'Phone Support',
                      subtitle: 'Call us for immediate help',
                      availability: 'Mon-Fri 9AM-6PM PST',
                      iconColor: Colors.green,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Calling support...')),
                        );
                      },
                    ),
                    SizedBox(height: 12),
                    _buildContactOption(
                      icon: Icons.email_outlined,
                      title: 'Email Support',
                      subtitle: 'Send us a detailed message',
                      availability: 'Response within 24 hours',
                      iconColor: Colors.purple,
                      onTap: () {
                        // Scroll to message form
                        _scrollToMessageForm();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Browse Help Topics Section
              _buildSection(
                title: 'Browse Help Topics',
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    _buildHelpTopicCard(
                      title: 'Booking & Services',
                      subtitle: 'Questions about booking, canceling, or managing services',
                      icon: Icons.calendar_today,
                      iconColor: Color(0xFF2E86AB),
                    ),
                    _buildHelpTopicCard(
                      title: 'Payment & Billing',
                      subtitle: 'Issues with payments, refunds, or billing',
                      icon: Icons.payment,
                      iconColor: Colors.green,
                    ),
                    _buildHelpTopicCard(
                      title: 'Account & Profile',
                      subtitle: 'Account settings, profile updates, verification',
                      icon: Icons.person_outline,
                      iconColor: Colors.purple,
                    ),
                    _buildHelpTopicCard(
                      title: 'Technical Issues',
                      subtitle: 'App problems, bugs, or technical difficulties',
                      icon: Icons.error_outline,
                      iconColor: Colors.red,
                    ),
                  ],
                ),
              ),
            ] else ...[
              // Selected Category View
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Browse Help Topics',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Category cards - highlight selected
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.1,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      children: [
                        _buildHelpTopicCard(
                          title: 'Booking & Services',
                          subtitle: 'Questions about booking, canceling, or managing services',
                          icon: Icons.calendar_today,
                          iconColor: Color(0xFF2E86AB),
                          isSelected: selectedCategory == 'Booking & Services',
                        ),
                        _buildHelpTopicCard(
                          title: 'Payment & Billing',
                          subtitle: 'Issues with payments, refunds, or billing',
                          icon: Icons.payment,
                          iconColor: Colors.green,
                          isSelected: selectedCategory == 'Payment & Billing',
                        ),
                        _buildHelpTopicCard(
                          title: 'Account & Profile',
                          subtitle: 'Account settings, profile updates, verification',
                          icon: Icons.person_outline,
                          iconColor: Colors.purple,
                          isSelected: selectedCategory == 'Account & Profile',
                        ),
                        _buildHelpTopicCard(
                          title: 'Technical Issues',
                          subtitle: 'App problems, bugs, or technical difficulties',
                          icon: Icons.error_outline,
                          iconColor: Colors.red,
                          isSelected: selectedCategory == 'Technical Issues',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: 16),
            // FAQ Section
            _buildFAQSection(),
            SizedBox(height: 16),
            // Send Message Section
            _buildSendMessageSection(),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
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
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required String availability,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    availability,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpTopicCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    bool isSelected = false,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = selectedCategory == title ? '' : title;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? iconColor : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
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
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
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
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search help articles...',
                prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          SizedBox(height: 16),
          if (selectedCategory.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    selectedCategory = '';
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back, size: 16),
                    SizedBox(width: 4),
                    Text('Back to all categories'),
                  ],
                ),
              ),
            ),
          ],
          _buildFAQList(),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildFAQList() {
    List<Map<String, String>> questionsToShow = [];

    if (selectedCategory.isNotEmpty) {
      questionsToShow = helpTopics[selectedCategory] ?? [];
    } else {
      // Show questions from all categories
      helpTopics.values.forEach((questions) {
        questionsToShow.addAll(questions);
      });
    }

    // Filter by search query
    if (_searchController.text.isNotEmpty) {
      questionsToShow = questionsToShow.where((q) =>
      q['question']!.toLowerCase().contains(_searchController.text.toLowerCase()) ||
          q['answer']!.toLowerCase().contains(_searchController.text.toLowerCase())
      ).toList();
    }

    if (questionsToShow.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'No help articles found. Try a different search term.',
          style: TextStyle(color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Column(
      children: questionsToShow.map((question) => _buildFAQItem(question)).toList(),
    );
  }

  Widget _buildFAQItem(Map<String, String> question) {
    return ExpansionTile(
      title: Text(
        question['question']!,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              question['answer']!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSendMessageSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
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
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send us a Message',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _subjectController,
              decoration: InputDecoration(
                labelText: 'Subject',
                hintText: 'Brief description of your issue',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'your.email@example.com',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _messageController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Message',
                hintText: 'Please describe your issue in detail...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: markAsUrgent,
                  onChanged: (value) {
                    setState(() {
                      markAsUrgent = value ?? false;
                    });
                  },
                ),
                Text('Mark as urgent'),
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _sendMessage,
                icon: Icon(Icons.send, color: Colors.white),
                label: Text(
                  'Send Message',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2E86AB),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _scrollToMessageForm() {
    // This would scroll to the message form
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Scrolling to message form...')),
    );
  }

  void _sendMessage() {
    if (_subjectController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    // Clear form
    _subjectController.clear();
    _emailController.clear();
    _messageController.clear();
    setState(() {
      markAsUrgent = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Message sent! We\'ll get back to you soon.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _subjectController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}