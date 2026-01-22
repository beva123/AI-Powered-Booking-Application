import 'package:flutter/material.dart';
import 'recommended_professionals_screen.dart';

class HouseCleaningQuestionnaireScreen extends StatefulWidget {
  const HouseCleaningQuestionnaireScreen({Key? key}) : super(key: key);

  @override
  _HouseCleaningQuestionnaireScreenState createState() => _HouseCleaningQuestionnaireScreenState();
}

class _HouseCleaningQuestionnaireScreenState extends State<HouseCleaningQuestionnaireScreen> {
  int currentStep = 1;
  final int totalSteps = 7;

  // Step 1: Service type
  String selectedServiceType = '';

  // Step 2: Home size
  String selectedHomeSize = '';

  // Step 3: Frequency
  String selectedFrequency = '';

  // Step 4: Special requests
  final TextEditingController _specialRequestsController = TextEditingController();

  // Step 5: Urgency
  String selectedUrgency = '';

  // Step 6: Budget
  String selectedBudget = '';

  // Step 7: Photos
  List<String> uploadedPhotos = [];

  final List<String> _serviceTypes = [
    'Regular house cleaning',
    'Deep cleaning',
    'Move-in/move-out cleaning',
    'Post-construction cleanup',
    'Carpet cleaning',
    'Window cleaning',
    'Other'
  ];

  final List<String> _homeSizes = [
    'Studio/1 bedroom',
    '2 bedrooms',
    '3 bedrooms',
    '4+ bedrooms',
    'Commercial space'
  ];

  final List<String> _frequencies = [
    'One-time service',
    'Weekly',
    'Bi-weekly',
    'Monthly',
    'Seasonal'
  ];

  final List<String> _urgencyOptions = [
    'Emergency (within 2 hours)',
    'Same day',
    'Within a week',
    'Flexible timing'
  ];

  final List<String> _budgetOptions = [
    'Under \$100',
    '\$100-\$300',
    '\$300-\$500',
    '\$500-\$1000',
    'Over \$1000',
    'Get quotes first'
  ];

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
              'House Cleaning',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Step $currentStep of $totalSteps',
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
          // Progress bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.white,
            child: LinearProgressIndicator(
              value: currentStep / totalSteps,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E86AB)),
              minHeight: 4,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: _buildCurrentStepContent(),
              ),
            ),
          ),
          _buildBottomActions(),
        ],
      ),
    );
  }

  Widget _buildCurrentStepContent() {
    switch (currentStep) {
      case 1:
        return _buildServiceTypeStep();
      case 2:
        return _buildHomeSizeStep();
      case 3:
        return _buildFrequencyStep();
      case 4:
        return _buildSpecialRequestsStep();
      case 5:
        return _buildUrgencyStep();
      case 6:
        return _buildBudgetStep();
      case 7:
        return _buildPhotoStep();
      default:
        return Container();
    }
  }

  Widget _buildServiceTypeStep() {
    return _buildQuestionCard(
      question: 'What type of cleaning service do you need?',
      options: _serviceTypes,
      selectedValue: selectedServiceType,
      onChanged: (value) {
        setState(() {
          selectedServiceType = value;
        });
      },
    );
  }

  Widget _buildHomeSizeStep() {
    return _buildQuestionCard(
      question: 'What\'s the size of your home?',
      options: _homeSizes,
      selectedValue: selectedHomeSize,
      onChanged: (value) {
        setState(() {
          selectedHomeSize = value;
        });
      },
    );
  }

  Widget _buildFrequencyStep() {
    return _buildQuestionCard(
      question: 'How often do you need cleaning?',
      options: _frequencies,
      selectedValue: selectedFrequency,
      onChanged: (value) {
        setState(() {
          selectedFrequency = value;
        });
      },
    );
  }

  Widget _buildSpecialRequestsStep() {
    return Column(
      children: [
        Container(
          width: double.infinity,
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
                'Any special cleaning requests or areas of focus?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _specialRequestsController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Pet hair, deep kitchen cleaning, specific products to use/avoid, etc.',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildInfoCard(),
      ],
    );
  }

  Widget _buildUrgencyStep() {
    return _buildQuestionCard(
      question: 'How urgent is this issue?',
      options: _urgencyOptions,
      selectedValue: selectedUrgency,
      onChanged: (value) {
        setState(() {
          selectedUrgency = value;
        });
      },
    );
  }

  Widget _buildBudgetStep() {
    return _buildQuestionCard(
      question: 'What\'s your budget range for this project?',
      options: _budgetOptions,
      selectedValue: selectedBudget,
      onChanged: (value) {
        setState(() {
          selectedBudget = value;
        });
      },
    );
  }

  Widget _buildPhotoStep() {
    return Column(
      children: [
        Container(
          width: double.infinity,
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
            children: [
              Icon(
                Icons.camera_alt_outlined,
                size: 48,
                color: Colors.grey[400],
              ),
              SizedBox(height: 16),
              Text(
                'Add Photos (Optional)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Photos help professionals understand your needs better and provide more accurate quotes',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Photo upload - Camera integration coming soon!')),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, color: Colors.grey[400], size: 32),
                      SizedBox(height: 8),
                      Text(
                        'Tap to add photos',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildInfoCard(isPhotoStep: true),
      ],
    );
  }

  Widget _buildQuestionCard({
    required String question,
    required List<String> options,
    required String selectedValue,
    required Function(String) onChanged,
  }) {
    return Column(
      children: [
        Container(
          width: double.infinity,
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
              RichText(
                text: TextSpan(
                  text: question,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Column(
                children: options.map((option) =>
                    RadioListTile<String>(
                      title: Text(option),
                      value: option,
                      groupValue: selectedValue,
                      onChanged: (value) => onChanged(value!),
                      activeColor: Color(0xFF2E86AB),
                      contentPadding: EdgeInsets.zero,
                    ),
                ).toList(),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildInfoCard(),
      ],
    );
  }

  Widget _buildInfoCard({bool isPhotoStep = false}) {
    String infoText = isPhotoStep
        ? 'Photos help professionals assess the work needed and provide more accurate quotes.'
        : 'These details help us match you with the right professional and ensure they come prepared with the right tools and knowledge.';

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF2E86AB).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF2E86AB).withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: Color(0xFF2E86AB),
            size: 20,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Why we ask these questions',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2E86AB),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  infoText,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF2E86AB),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: SafeArea(
        child: Row(
          children: [
            if (currentStep > 1) ...[
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousStep,
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(color: Colors.grey[400]!),
                  ),
                  child: Text(
                    'Previous',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
              ),
              SizedBox(width: 16),
            ],
            Expanded(
              flex: currentStep == 1 ? 1 : 1,
              child: ElevatedButton(
                onPressed: _canProceed() ? (currentStep == totalSteps ? _getQuotes : _nextStep) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: currentStep == totalSteps ? Color(0xFFF57C00) : Color(0xFF2E86AB),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  disabledBackgroundColor: Colors.grey[300],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (currentStep == totalSteps) Icon(Icons.search, color: Colors.white),
                    if (currentStep == totalSteps) SizedBox(width: 8),
                    Text(
                      currentStep == totalSteps ? 'Get Quotes' : 'Next',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _canProceed() {
    switch (currentStep) {
      case 1:
        return selectedServiceType.isNotEmpty;
      case 2:
        return selectedHomeSize.isNotEmpty;
      case 3:
        return selectedFrequency.isNotEmpty;
      case 4:
        return true; // Special requests are optional
      case 5:
        return selectedUrgency.isNotEmpty;
      case 6:
        return selectedBudget.isNotEmpty;
      case 7:
        return true; // Photos are optional
      default:
        return false;
    }
  }

  void _nextStep() {
    if (_canProceed()) {
      setState(() {
        currentStep++;
      });
    }
  }

  void _previousStep() {
    setState(() {
      currentStep--;
    });
  }

  void _getQuotes() {
    // Collect all answers
    Map<String, dynamic> questionnaire = {
      'service': 'House Cleaning',
      'serviceType': selectedServiceType,
      'homeSize': selectedHomeSize,
      'frequency': selectedFrequency,
      'specialRequests': _specialRequestsController.text,
      'urgency': selectedUrgency,
      'budget': selectedBudget,
      'photos': uploadedPhotos,
    };

    // Navigate to recommended professionals
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecommendedProfessionalsScreen(
          questionnaire: questionnaire,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _specialRequestsController.dispose();
    super.dispose();
  }
}