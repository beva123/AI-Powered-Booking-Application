import 'package:flutter/material.dart';
import 'recommended_professionals_screen.dart';

class HandymanQuestionnaireScreen extends StatefulWidget {
  const HandymanQuestionnaireScreen({Key? key}) : super(key: key);

  @override
  _HandymanQuestionnaireScreenState createState() => _HandymanQuestionnaireScreenState();
}

class _HandymanQuestionnaireScreenState extends State<HandymanQuestionnaireScreen> {
  int currentStep = 1;
  final int totalSteps = 7;

  // Step 1: Work types (multiple selection)
  List<String> selectedWorkTypes = [];

  // Step 2: Project size
  String selectedProjectSize = '';

  // Step 3: Materials/supplies
  String materialsStatus = '';

  // Step 4: Work description
  final TextEditingController _descriptionController = TextEditingController();

  // Step 5: Urgency
  String selectedUrgency = '';

  // Step 6: Budget
  String selectedBudget = '';

  // Step 7: Photos
  List<String> uploadedPhotos = [];

  final List<String> _workTypes = [
    'Furniture assembly',
    'Picture hanging',
    'Shelf installation',
    'Door/window repair',
    'Drywall repair',
    'Minor plumbing',
    'Minor electrical',
    'Painting touch-ups',
    'Other repairs'
  ];

  final List<String> _projectSizes = [
    'Small (1-2 hours)',
    'Medium (half day)',
    'Large (full day)',
    'Multi-day project'
  ];

  final List<String> _materialsOptions = [
    'Yes, I have everything',
    'I have some materials',
    'No, please bring materials',
    'Not sure what\'s needed'
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
              'Handyman',
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
        return _buildWorkTypeStep();
      case 2:
        return _buildProjectSizeStep();
      case 3:
        return _buildMaterialsStep();
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

  Widget _buildWorkTypeStep() {
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
                  text: 'What type of work do you need? (Select all that apply)',
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
                children: _workTypes.map((workType) =>
                    CheckboxListTile(
                      title: Text(workType),
                      value: selectedWorkTypes.contains(workType),
                      onChanged: (value) {
                        setState(() {
                          if (value ?? false) {
                            selectedWorkTypes.add(workType);
                          } else {
                            selectedWorkTypes.remove(workType);
                          }
                        });
                      },
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

  Widget _buildProjectSizeStep() {
    return _buildQuestionCard(
      question: 'How would you describe the project size?',
      options: _projectSizes,
      selectedValue: selectedProjectSize,
      onChanged: (value) {
        setState(() {
          selectedProjectSize = value;
        });
      },
    );
  }

  Widget _buildMaterialsStep() {
    return _buildQuestionCard(
      question: 'Do you have the materials/supplies needed?',
      options: _materialsOptions,
      selectedValue: materialsStatus,
      onChanged: (value) {
        setState(() {
          materialsStatus = value;
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
              RichText(
                text: TextSpan(
                  text: 'Please describe the work needed',
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
              TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Be as specific as possible about what needs to be done',
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
        return selectedWorkTypes.isNotEmpty;
      case 2:
        return selectedProjectSize.isNotEmpty;
      case 3:
        return materialsStatus.isNotEmpty;
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
      'service': 'Handyman',
      'workTypes': selectedWorkTypes,
      'projectSize': selectedProjectSize,
      'materialsStatus': materialsStatus,
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