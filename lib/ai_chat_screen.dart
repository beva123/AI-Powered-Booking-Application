import 'package:flutter/material.dart';
import 'dart:io';
import 'search_results_screen.dart';

class AIChatScreen extends StatefulWidget {
  @override
  _AIChatScreenState createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<ChatMessage> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  void _initializeChat() {
    _messages = [
      ChatMessage(
        text: 'Hi! I\'m your AI assistant. I can help you find the right worker for any job. What do you need help with today?',
        isFromAI: true,
        timestamp: DateTime.now().subtract(Duration(minutes: 1)),
      ),
    ];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'AI Chat',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildAIAssistantHeader(),
          _buildQuickActions(),
          Expanded(
            child: _messages.isEmpty
                ? _buildEmptyState()
                : _buildChatMessages(),
          ),
          _buildPhotoUploadSection(),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildAIAssistantHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xFF2E86AB),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(Icons.smart_toy, color: Colors.white, size: 20),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI Assistant',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Get personalized worker recommendations',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    final quickActions = [
      {'title': 'Plumbing Issue', 'color': Colors.blue},
      {'title': 'Electrical Problem', 'color': Colors.orange},
      {'title': 'Cleaning Service', 'color': Colors.green},
      {'title': 'Emergency Repair', 'color': Colors.red},
    ];

    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: quickActions.map((action) =>
                _buildQuickActionChip(action['title'] as String, action['color'] as Color)
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionChip(String title, Color color) {
    return GestureDetector(
      onTap: () => _handleQuickAction(title),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            'Start a conversation',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Describe your issue or tap a quick action above',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildChatMessages() {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.all(16),
      itemCount: _messages.length + (_isTyping ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _messages.length && _isTyping) {
          return _buildTypingIndicator();
        }
        return _buildMessageBubble(_messages[index]);
      },
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final isFromAI = message.isFromAI;

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isFromAI ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isFromAI) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Color(0xFF2E86AB),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(Icons.smart_toy, color: Colors.white, size: 16),
            ),
            SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isFromAI ? Colors.white : Color(0xFF2E86AB),
                borderRadius: BorderRadius.circular(18).copyWith(
                  bottomLeft: isFromAI ? Radius.circular(4) : Radius.circular(18),
                  bottomRight: isFromAI ? Radius.circular(18) : Radius.circular(4),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: isFromAI ? Colors.black : Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  if (message.suggestions != null) ...[
                    SizedBox(height: 12),
                    ...message.suggestions!.map((suggestion) =>
                        Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: GestureDetector(
                            onTap: () => _handleSuggestionTap(suggestion),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Color(0xFF2E86AB).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Color(0xFF2E86AB).withOpacity(0.3)),
                              ),
                              child: Text(
                                suggestion,
                                style: TextStyle(
                                  color: Color(0xFF2E86AB),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ),
                  ],
                  SizedBox(height: 4),
                  Text(
                    _formatTime(message.timestamp),
                    style: TextStyle(
                      color: isFromAI ? Colors.grey[500] : Colors.white.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!isFromAI) ...[
            SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 16,
              child: Icon(Icons.person, color: Colors.white, size: 16),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Color(0xFF2E86AB),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.smart_toy, color: Colors.white, size: 16),
          ),
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18).copyWith(
                bottomLeft: Radius.circular(4),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDot(0),
                SizedBox(width: 4),
                _buildDot(1),
                SizedBox(width: 4),
                _buildDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildPhotoUploadSection() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(Icons.file_upload_outlined, size: 32, color: Colors.grey[500]),
            SizedBox(height: 8),
            Text(
              'Upload issue photo for AI analysis',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _handlePhotoUpload,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Color(0xFF2E86AB)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Choose Photo',
                style: TextStyle(color: Color(0xFF2E86AB)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.camera_alt, color: Colors.grey[600]),
              onPressed: _handleCameraCapture,
            ),
            IconButton(
              icon: Icon(Icons.mic, color: Colors.grey[600]),
              onPressed: _handleVoiceInput,
            ),
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Describe your issue...',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                maxLines: null,
                onSubmitted: (text) => _sendMessage(),
              ),
            ),
            SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF2E86AB),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.send, color: Colors.white),
                onPressed: _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleQuickAction(String action) {
    _messageController.text = 'I need help with: $action';
    _sendMessage();
  }

  void _handlePhotoUpload() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Photo upload - Coming Soon! Camera and gallery integration needed.')),
    );
  }

  void _handleCameraCapture() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Camera capture - Coming Soon!')),
    );
  }

  void _handleVoiceInput() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Voice input - Coming Soon!')),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final userMessage = _messageController.text.trim();

    setState(() {
      _messages.add(
        ChatMessage(
          text: userMessage,
          isFromAI: false,
          timestamp: DateTime.now(),
        ),
      );
      _isTyping = true;
    });

    _messageController.clear();

    // Scroll to bottom
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    // Simulate AI response
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isTyping = false;
          _messages.add(
            ChatMessage(
              text: _getAIResponse(userMessage),
              isFromAI: true,
              timestamp: DateTime.now(),
              suggestions: _getSuggestions(userMessage),
            ),
          );
        });

        // Scroll to bottom after AI response
        Future.delayed(Duration(milliseconds: 100), () {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
    });
  }

  String _getAIResponse(String userMessage) {
    final message = userMessage.toLowerCase();

    if (message.contains('plumbing') || message.contains('leak') || message.contains('pipe')) {
      return 'I can help you find a qualified plumber! Based on your description, it sounds like you might need emergency plumbing services. I\'ve found several highly-rated plumbers in your area.';
    } else if (message.contains('electrical') || message.contains('power') || message.contains('outlet')) {
      return 'Electrical issues can be serious! Let me find you a licensed electrician who can safely handle this. I recommend getting this looked at as soon as possible.';
    } else if (message.contains('cleaning') || message.contains('clean')) {
      return 'I can connect you with professional cleaning services! Whether you need regular maintenance or deep cleaning, I\'ve found some excellent options near you.';
    } else if (message.contains('emergency') || message.contains('urgent')) {
      return 'This sounds urgent! I\'m finding emergency service providers who are available 24/7 in your area. They typically respond within 15-30 minutes.';
    } else {
      return 'Thanks for describing your issue! I\'m analyzing your needs and finding the best workers in your area. Let me show you some options that match your requirements.';
    }
  }

  List<String>? _getSuggestions(String userMessage) {
    final message = userMessage.toLowerCase();

    if (message.contains('plumbing')) {
      return ['Find Emergency Plumbers', 'View Plumbing Services', 'Get Price Estimates'];
    } else if (message.contains('electrical')) {
      return ['Find Licensed Electricians', 'Emergency Electrical Help', 'Schedule Inspection'];
    } else if (message.contains('cleaning')) {
      return ['Book House Cleaning', 'Deep Cleaning Services', 'Regular Maintenance'];
    } else {
      return ['Find Workers Near Me', 'Get Instant Quote', 'Emergency Services'];
    }
  }

  void _handleSuggestionTap(String suggestion) {
    // Navigate to appropriate screen based on suggestion
    if (suggestion.contains('Find') || suggestion.contains('View') || suggestion.contains('Book')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultsScreen(query: suggestion.split(' ').last.toLowerCase()),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$suggestion - Feature coming soon!')),
      );
    }
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String text;
  final bool isFromAI;
  final DateTime timestamp;
  final List<String>? suggestions;

  ChatMessage({
    required this.text,
    required this.isFromAI,
    required this.timestamp,
    this.suggestions,
  });
}