import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationSettingsScreen extends StatefulWidget {
  @override
  _NotificationSettingsScreenState createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  // General settings
  bool pushNotifications = true;
  bool emailNotifications = true;
  bool smsNotifications = false;

  // Activity settings
  bool bookingUpdates = true;
  bool messages = true;
  bool payments = true;
  bool reviews = true;

  // Special settings
  bool emergencyAlerts = true;
  bool reminders = true;
  bool marketing = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      pushNotifications = prefs.getBool('push_notifications') ?? true;
      emailNotifications = prefs.getBool('email_notifications') ?? true;
      smsNotifications = prefs.getBool('sms_notifications') ?? false;
      bookingUpdates = prefs.getBool('booking_updates') ?? true;
      messages = prefs.getBool('messages') ?? true;
      payments = prefs.getBool('payments') ?? true;
      reviews = prefs.getBool('reviews') ?? true;
      emergencyAlerts = prefs.getBool('emergency_alerts') ?? true;
      reminders = prefs.getBool('reminders') ?? true;
      marketing = prefs.getBool('marketing') ?? false;
    });
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notification Settings',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Manage how you receive notifications',
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
          children: [
            SizedBox(height: 16),
            // General Section
            _buildSection(
              title: 'General',
              children: [
                _buildSwitchTile(
                  icon: Icons.notifications,
                  title: 'Push Notifications',
                  subtitle: 'Receive notifications on your device',
                  value: pushNotifications,
                  onChanged: (value) {
                    setState(() {
                      pushNotifications = value;
                    });
                    _saveSettings();
                  },
                  iconColor: Color(0xFF2E86AB),
                ),
                _buildSwitchTile(
                  icon: Icons.email,
                  title: 'Email Notifications',
                  subtitle: 'Receive notifications via email',
                  value: emailNotifications,
                  onChanged: (value) {
                    setState(() {
                      emailNotifications = value;
                    });
                    _saveSettings();
                  },
                  iconColor: Colors.green,
                ),
                _buildSwitchTile(
                  icon: Icons.sms,
                  title: 'SMS Notifications',
                  subtitle: 'Receive text message notifications',
                  value: smsNotifications,
                  onChanged: (value) {
                    setState(() {
                      smsNotifications = value;
                    });
                    _saveSettings();
                  },
                  iconColor: Colors.orange,
                ),
              ],
            ),
            SizedBox(height: 16),
            // Activity Section
            _buildSection(
              title: 'Activity',
              children: [
                _buildSwitchTile(
                  icon: Icons.calendar_today,
                  title: 'Booking Updates',
                  subtitle: 'Get notified about booking changes',
                  value: bookingUpdates,
                  onChanged: (value) {
                    setState(() {
                      bookingUpdates = value;
                    });
                    _saveSettings();
                  },
                  iconColor: Color(0xFF2E86AB),
                ),
                _buildSwitchTile(
                  icon: Icons.message,
                  title: 'Messages',
                  subtitle: 'New messages from workers or clients',
                  value: messages,
                  onChanged: (value) {
                    setState(() {
                      messages = value;
                    });
                    _saveSettings();
                  },
                  iconColor: Colors.green,
                ),
                _buildSwitchTile(
                  icon: Icons.payment,
                  title: 'Payments',
                  subtitle: 'Payment confirmations and receipts',
                  value: payments,
                  onChanged: (value) {
                    setState(() {
                      payments = value;
                    });
                    _saveSettings();
                  },
                  iconColor: Colors.purple,
                ),
                _buildSwitchTile(
                  icon: Icons.star,
                  title: 'Reviews',
                  subtitle: 'New reviews and rating notifications',
                  value: reviews,
                  onChanged: (value) {
                    setState(() {
                      reviews = value;
                    });
                    _saveSettings();
                  },
                  iconColor: Colors.orange,
                ),
              ],
            ),
            SizedBox(height: 16),
            // Special Section
            _buildSection(
              title: 'Special',
              children: [
                _buildSwitchTile(
                  icon: Icons.warning,
                  title: 'Emergency Alerts',
                  subtitle: 'Important service alerts and updates',
                  value: emergencyAlerts,
                  onChanged: (value) {
                    setState(() {
                      emergencyAlerts = value;
                    });
                    _saveSettings();
                  },
                  iconColor: Colors.red,
                ),
                _buildSwitchTile(
                  icon: Icons.access_time,
                  title: 'Reminders',
                  subtitle: 'Upcoming appointments and deadlines',
                  value: reminders,
                  onChanged: (value) {
                    setState(() {
                      reminders = value;
                    });
                    _saveSettings();
                  },
                  iconColor: Color(0xFF2E86AB),
                ),
                _buildSwitchTile(
                  icon: Icons.campaign,
                  title: 'Marketing',
                  subtitle: 'Promotional offers and updates',
                  value: marketing,
                  onChanged: (value) {
                    setState(() {
                      marketing = value;
                    });
                    _saveSettings();
                  },
                  iconColor: Colors.purple,
                ),
              ],
            ),
            SizedBox(height: 24),
            // Save Button
            Container(
              margin: EdgeInsets.all(16),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _saveSettings();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Notification settings saved'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2E86AB),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Save Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
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
          ...children,
          SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required Color iconColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
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
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Color(0xFF2E86AB),
            activeTrackColor: Color(0xFF2E86AB).withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  void _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('push_notifications', pushNotifications);
    await prefs.setBool('email_notifications', emailNotifications);
    await prefs.setBool('sms_notifications', smsNotifications);
    await prefs.setBool('booking_updates', bookingUpdates);
    await prefs.setBool('messages', messages);
    await prefs.setBool('payments', payments);
    await prefs.setBool('reviews', reviews);
    await prefs.setBool('emergency_alerts', emergencyAlerts);
    await prefs.setBool('reminders', reminders);
    await prefs.setBool('marketing', marketing);
  }
}