import 'package:flutter/material.dart';
import 'recommended_professionals_screen.dart';

class HVACQuestionnaireScreen extends StatefulWidget {
  const HVACQuestionnaireScreen({Key? key}) : super(key: key);

  @override
  _HVACQuestionnaireScreenState createState() => _HVACQuestionnaireScreenState();
}

class _HVACQuestionnaireScreenState extends State<HVACQuestionnaireScreen> {
  int currentStep = 1;
  final int totalSteps = 7;

  // Step 1: HVAC system type
  String selectedSystemType = '';

  // Step 2: Issue type
  String selectedIssueType = '';

  // Step 3: System age
  String selectedSystemAge = '';

  // Step 4: Problem description
  final TextEditingController _descriptionController = TextEditingController();

  // Step 5: Urgency
  String selectedUrgency = '';

  // Step 6: Budget
  String selectedBudget = '';

  // Step 7: Photos
  List<String> uploadedPhotos = [];

  final List<String> _systemTypes = [
    'Central air/heating',
    'Window units',
    'Ductless mini-split',
    'Boiler/radiator',
    'Heat pump',
    'Not sure'
  ];

  final List<String> _issueTypes = [
    'Not heating/cooling',
    'Poor airflow',
    'Strange noises',
    'High energy bills',
    'Bad air quality',
    'Installation needed',
    'Maintenance/tune-up'
  ];

  final List<String> _systemAges = [
    'Less than 5 years',
    '5-10 years',
    '10-15 years',
    'Over 15 years',
    'Not sure'
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
              'HVAC',
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
        return _buildSystemTypeStep();
      case 2:
        return _buildIssueTypeStep();
      case 3:
        return _buildSystemAgeStep();
      case 4:
        return _buildDescriptionStep();
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

  Widget _buildSystemTypeStep() {
    return _buildQuestionCard(
      question: 'What type of HVAC system do you have?',
      options: _systemTypes,
      selectedValue: selectedSystemType,
      onChanged: (value) {
        setState(() {
          selectedSystemType = value;
        });
      },
    );
  }

  Widget _buildIssueTypeStep() {
    return _buildQuestionCard(
      question: 'What issue are you experiencing?',
      options: _issueTypes,
      selectedValue: selectedIssueType,
      onChanged: (value) {
        setState(() {
          selectedIssueType = value;
        });
      },
    );
  }

  Widget _buildSystemAgeStep() {
    return _buildQuestionCard(
      question: 'How old is your HVAC system?',
      options: _systemAges,
      selectedValue: selectedSystemAge,
      onChanged: (value) {
        setState(() {
          selectedSystemAge = value;
        });
      },
    );
  }

  Widget _buildDescriptionStep() {
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
                'Please describe the problem in detail',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Include when it started, any sounds, temperature issues, etc.',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
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
        _buildInfoCard(),
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
              Text(
                question,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
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

  Widget _buildInfoCard() {
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
                  'These details help us match you with the right professional and ensure they come prepared with the right tools and knowledge.',
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
                  ),
                  child: Text('Previous'),
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
        return selectedSystemType.isNotEmpty;
      case 2:
        return selectedIssueType.isNotEmpty;
      case 3:
        return selectedSystemAge.isNotEmpty;
      case 4:
        return _descriptionController.text.isNotEmpty;
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
      'service': 'HVAC',
      'systemType': selectedSystemType,
      'issueType': selectedIssueType,
      'systemAge': selectedSystemAge,
      'description': _descriptionController.text,
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
    _descriptionController.dispose();
    super.dispose();
  }
}