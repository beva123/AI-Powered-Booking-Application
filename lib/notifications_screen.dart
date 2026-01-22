import 'package:flutter/material.dart';
import 'notification_settings_screen.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  int selectedTabIndex = 0;

  List<NotificationItem> allNotifications = [
    NotificationItem(
      id: '1',
      type: NotificationType.message,
      title: 'New message from John Martinez',
      description: 'Thanks for choosing our service! I\'ll be there at 2 PM.',
      timestamp: '2 min ago',
      isUnread: true,
      hasAction: true,
      actionText: 'Action required',
      avatar: 'JM',
      avatarColor: Color(0xFF2E86AB),
    ),
    NotificationItem(
      id: '2',
      type: NotificationType.booking,
      title: 'Booking confirmed',
      description: 'Your plumbing service is confirmed for tomorrow at 2 PM.',
      timestamp: '1 hour ago',
      isUnread: true,
      hasAction: false,
      avatar: 'JM',
      avatarColor: Color(0xFF2E86AB),
    ),
    NotificationItem(
      id: '3',
      type: NotificationType.payment,
      title: 'Payment processed',
      description: 'Payment of \$150 has been processed successfully.',
      timestamp: '3 hours ago',
      isUnread: false,
      hasAction: false,
      icon: Icons.attach_money,
      iconColor: Colors.green,
    ),
    NotificationItem(
      id: '4',
      type: NotificationType.review,
      title: 'Review reminder',
      description: 'Please rate your recent service with John Martinez.',
      timestamp: '1 day ago',
      isUnread: false,
      hasAction: true,
      actionText: 'Action required',
      avatar: 'SC',
      avatarColor: Colors.grey[600]!,
    ),
    NotificationItem(
      id: '5',
      type: NotificationType.profile,
      title: 'Profile verification',
      description: 'Add payment method to book services faster.',
      timestamp: '2 days ago',
      isUnread: false,
      hasAction: true,
      actionText: 'Action required',
      icon: Icons.warning_outlined,
      iconColor: Colors.orange,
    ),
    NotificationItem(
      id: '6',
      type: NotificationType.booking,
      title: 'Upcoming appointment',
      description: 'Your HVAC service is scheduled for tomorrow at 10 AM.',
      timestamp: '1 day ago',
      isUnread: false,
      hasAction: false,
      avatar: 'MT',
      avatarColor: Color(0xFF2E86AB),
    ),
  ];

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
              'Notifications',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${_getUnreadCount()} unread notifications',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationSettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTabSection(),
          _buildMarkAllAsReadSection(),
          Expanded(
            child: _buildNotificationsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        isScrollable: false,
        labelColor: Color(0xFF2E86AB),
        unselectedLabelColor: Colors.grey[600],
        labelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        indicatorColor: Color(0xFF2E86AB),
        tabs: [
          Tab(text: 'All'),
          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Unread'),
                if (_getUnreadCount() > 0) ...[
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${_getUnreadCount()}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Tab(text: 'Messages'),
          Tab(text: 'Bookings'),
        ],
      ),
    );
  }

  Widget _buildMarkAllAsReadSection() {
    if (selectedTabIndex != 1 || _getUnreadCount() == 0) return SizedBox.shrink();

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(Icons.done_all, color: Colors.grey[600], size: 20),
          SizedBox(width: 8),
          GestureDetector(
            onTap: _markAllAsRead,
            child: Text(
              'Mark all as read',
              style: TextStyle(
                color: Color(0xFF2E86AB),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList() {
    List<NotificationItem> filteredNotifications = _getFilteredNotifications();

    if (filteredNotifications.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: filteredNotifications.length,
      itemBuilder: (context, index) {
        return _buildNotificationCard(filteredNotifications[index]);
      },
    );
  }

  Widget _buildNotificationCard(NotificationItem notification) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: notification.isUnread ? Colors.blue[50] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: notification.isUnread
            ? Border.all(color: Colors.blue[100]!, width: 1)
            : null,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              _buildNotificationAvatar(notification),
              if (notification.isUnread)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Color(0xFF2E86AB),
                      shape: BoxShape.circle,
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
                  notification.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  notification.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      notification.timestamp,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                    if (notification.hasAction) ...[
                      SizedBox(width: 16),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Color(0xFF2E86AB).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          notification.actionText,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF2E86AB),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationAvatar(NotificationItem notification) {
    if (notification.avatar != null) {
      return CircleAvatar(
        backgroundColor: notification.avatarColor,
        radius: 20,
        child: Text(
          notification.avatar!,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      );
    } else if (notification.icon != null) {
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: notification.iconColor?.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          notification.icon,
          color: notification.iconColor,
          size: 20,
        ),
      );
    }
    return SizedBox(width: 40, height: 40);
  }

  Widget _buildEmptyState() {
    String message;
    switch (selectedTabIndex) {
      case 1:
        message = 'No unread notifications';
        break;
      case 2:
        message = 'No message notifications';
        break;
      case 3:
        message = 'No booking notifications';
        break;
      default:
        message = 'No notifications';
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_outlined,
            size: 48,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  List<NotificationItem> _getFilteredNotifications() {
    switch (selectedTabIndex) {
      case 1: // Unread
        return allNotifications.where((n) => n.isUnread).toList();
      case 2: // Messages
        return allNotifications.where((n) =>
        n.type == NotificationType.message || n.type == NotificationType.review
        ).toList();
      case 3: // Bookings
        return allNotifications.where((n) => n.type == NotificationType.booking).toList();
      default: // All
        return allNotifications;
    }
  }

  int _getUnreadCount() {
    return allNotifications.where((n) => n.isUnread).length;
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in allNotifications) {
        notification.isUnread = false;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('All notifications marked as read')),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

enum NotificationType {
  message,
  booking,
  payment,
  review,
  profile,
}

class NotificationItem {
  final String id;
  final NotificationType type;
  final String title;
  final String description;
  final String timestamp;
  bool isUnread;
  final bool hasAction;
  final String actionText;
  final String? avatar;
  final Color? avatarColor;
  final IconData? icon;
  final Color? iconColor;

  NotificationItem({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.isUnread,
    required this.hasAction,
    this.actionText = '',
    this.avatar,
    this.avatarColor,
    this.icon,
    this.iconColor,
  });
}