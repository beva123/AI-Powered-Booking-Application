import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'professional_profile_screen.dart';

class BecomeProfessionalScreen extends StatefulWidget {
  @override
  _BecomeProfessionalScreenState createState() => _BecomeProfessionalScreenState();
}

class _BecomeProfessionalScreenState extends State<BecomeProfessionalScreen> {
  int currentStep = 1;
  final int totalSteps = 5;

  // Step 1: Business Information
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String selectedBusinessType = 'Individual';

  // Step 2: Services
  List<String> selectedServices = [];

  // Step 3: Location & Availability
  final TextEditingController _locationController = TextEditingController();
  String selectedRadius = '10';
  Map<String, bool> workingDays = {
    'Monday': true,
    'Tuesday': true,
    'Wednesday': true,
    'Thursday': true,
    'Friday': true,
    'Saturday': false,
    'Sunday': false,
  };
  Map<String, Map<String, String>> workingHours = {
    'Monday': {'start': '08:00 AM', 'end': '06:00 PM'},
    'Tuesday': {'start': '08:00 AM', 'end': '06:00 PM'},
    'Wednesday': {'start': '08:00 AM', 'end': '06:00 PM'},
    'Thursday': {'start': '08:00 AM', 'end': '06:00 PM'},
    'Friday': {'start': '08:00 AM', 'end': '06:00 PM'},
    'Saturday': {'start': '08:00 AM', 'end': '06:00 PM'},
    'Sunday': {'start': '08:00 AM', 'end': '06:00 PM'},
  };

  // Step 4: Pricing
  final TextEditingController _hourlyRateController = TextEditingController();
  final TextEditingController _minimumChargeController = TextEditingController();
  final TextEditingController _emergencyRateController = TextEditingController();

  // Step 5: Qualifications
  Map<String, bool> qualifications = {
    'Licensed Professional': false,
    'Certified Technician': false,
    'Bonded & Insured': false,
    'Background Checked': false,
    'Industry Certification': false,
    'Specialized Training': false,
    'Safety Certified': false,
    'Environmental Certified': false,
    'Insured': false,
    'Licensed': false,
  };

  final List<Map<String, dynamic>> availableServices = [
    {'name': 'Plumbing', 'icon': Icons.plumbing, 'color': Colors.blue},
    {'name': 'Electrical', 'icon': Icons.electrical_services, 'color': Colors.orange},
    {'name': 'House Cleaning', 'icon': Icons.cleaning_services, 'color': Colors.green},
    {'name': 'Handyman', 'icon': Icons.handyman, 'color': Colors.orange},
    {'name': 'HVAC', 'icon': Icons.ac_unit, 'color': Colors.purple},
    {'name': 'Carpentry', 'icon': Icons.carpenter, 'color': Colors.brown},
    {'name': 'Painting', 'icon': Icons.format_paint, 'color': Colors.pink},
    {'name': 'Landscaping', 'icon': Icons.grass, 'color': Colors.green},
    {'name': 'Appliance Repair', 'icon': Icons.settings, 'color': Colors.grey},
    {'name': 'Pest Control', 'icon': Icons.bug_report, 'color': Colors.red},
  ];

  @override
  void initState() {
    super.initState();
    _locationController.text = 'San Francisco, CA';
    _hourlyRateController.text = '75';
    _minimumChargeController.text = '100';
    _emergencyRateController.text = '125';
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
              'Become a Professional',
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
            padding: EdgeInsets.all(16),
            color: Colors.white,
            child: LinearProgressIndicator(
              value: currentStep / totalSteps,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E86AB)),
              minHeight: 6,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: _buildCurrentStepContent(),
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
        return _buildBusinessInformationStep();
      case 2:
        return _buildServicesStep();
      case 3:
        return _buildLocationAvailabilityStep();
      case 4:
        return _buildPricingStep();
      case 5:
        return _buildQualificationsStep();
      default:
        return Container();
    }
  }

  Widget _buildBusinessInformationStep() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Color(0xFF2E86AB).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.business,
                  color: Color(0xFF2E86AB),
                  size: 24,
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Business Information',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Tell us about your business',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 32),
          // Business Name
          Text(
            'Business Name',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _businessNameController,
            decoration: InputDecoration(
              hintText: 'e.g., Smith Plumbing Services',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
            ),
          ),
          SizedBox(height: 24),
          // Business Type
          Text(
            'Business Type',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedBusinessType = 'Individual';
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: selectedBusinessType == 'Individual'
                          ? Colors.black
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Text(
                      'Individual',
                      style: TextStyle(
                        color: selectedBusinessType == 'Individual'
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedBusinessType = 'Company';
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: selectedBusinessType == 'Company'
                          ? Colors.black
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Text(
                      'Company',
                      style: TextStyle(
                        color: selectedBusinessType == 'Company'
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          // Years of Experience
          Text(
            'Years of Experience',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _experienceController,
            decoration: InputDecoration(
              hintText: 'e.g., 5',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 24),
          // Business Description
          Text(
            'Business Description',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _descriptionController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Describe your services and what makes you unique...',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesStep() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.build,
                  color: Colors.orange,
                  size: 24,
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Services Offered',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Select the services you provide',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 32),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
            itemCount: availableServices.length,
            itemBuilder: (context, index) {
              final service = availableServices[index];
              final isSelected = selectedServices.contains(service['name']);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      selectedServices.remove(service['name']);
                    } else {
                      selectedServices.add(service['name']);
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? Color(0xFF2E86AB) : Colors.grey[300]!,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: (service['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          service['icon'] as IconData,
                          color: service['color'] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        service['name'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (isSelected) ...[
                        SizedBox(height: 8),
                        Icon(
                          Icons.check_circle,
                          color: Color(0xFF2E86AB),
                          size: 20,
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 16),
          Text(
            'Selected: ${selectedServices.length} services',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationAvailabilityStep() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Color(0xFF2E86AB).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.location_on,
                  color: Color(0xFF2E86AB),
                  size: 24,
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location & Availability',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Where and when do you work?',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 32),
          // Service Location
          Text(
            'Service Location',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _locationController,
            decoration: InputDecoration(
              hintText: 'e.g., San Francisco, CA',
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 24),
          // Service Radius
          Text(
            'Service Radius (miles)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: selectedRadius,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            items: ['5', '10', '15', '20', '25', '30'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedRadius = newValue!;
              });
            },
          ),
          SizedBox(height: 24),
          // Working Hours
          Text(
            'Working Hours',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16),
          Column(
            children: workingDays.keys.map((day) {
              return Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 24,
                      child: Checkbox(
                        value: workingDays[day],
                        onChanged: (bool? value) {
                          setState(() {
                            workingDays[day] = value!;
                          });
                        },
                        activeColor: Color(0xFF2E86AB),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        day,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    if (workingDays[day]!) ...[
                      Text(
                        workingHours[day]!['start']!,
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(' to ', style: TextStyle(fontSize: 12)),
                      Text(
                        workingHours[day]!['end']!,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingStep() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Color(0xFF2E86AB).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.attach_money,
                  color: Color(0xFF2E86AB),
                  size: 24,
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pricing',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Set your service rates',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 32),
          // Hourly Rate
          Text(
            'Hourly Rate (\$)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _hourlyRateController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 24),
          // Minimum Charge
          Text(
            'Minimum Charge (\$)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _minimumChargeController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 24),
          // Emergency Rate
          Text(
            'Emergency Rate (\$/hr)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _emergencyRateController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 8),
          Text(
            'Rate for after hours or emergency calls',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQualificationsStep() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Color(0xFF2E86AB).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.verified,
                  color: Color(0xFF2E86AB),
                  size: 24,
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Qualifications',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Showcase your credentials',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 32),
          Text(
            'Professional Qualifications',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 3.5,
            ),
            itemCount: qualifications.length,
            itemBuilder: (context, index) {
              String qualification = qualifications.keys.elementAt(index);
              return Row(
                children: [
                  SizedBox(
                    width: 20,
                    child: Checkbox(
                      value: qualifications[qualification],
                      onChanged: (bool? value) {
                        setState(() {
                          qualifications[qualification] = value!;
                        });
                      },
                      activeColor: Color(0xFF2E86AB),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      qualification,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 32),
          Text(
            'Portfolio Photos',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!, width: 2),
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[50],
            ),
            child: InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Photo upload - Coming Soon!')),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.upload, color: Colors.grey[400], size: 32),
                  SizedBox(height: 8),
                  Text(
                    'Upload work photos',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
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
                  onPressed: () {
                    setState(() {
                      currentStep--;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(color: Colors.grey[400]!),
                  ),
                  child: Text(
                    'Back',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
              ),
              SizedBox(width: 16),
            ],
            Expanded(
              flex: currentStep == 1 ? 1 : 1,
              child: ElevatedButton(
                onPressed: _handleNextStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: currentStep == totalSteps ? Colors.green : Color(0xFF2E86AB),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      currentStep < totalSteps ? 'Continue' : 'Complete Setup',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      currentStep < totalSteps ? Icons.arrow_forward : Icons.check,
                      color: Colors.white,
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

  void _handleNextStep() {
    if (currentStep == 1) {
      if (_businessNameController.text.isEmpty ||
          _experienceController.text.isEmpty ||
          _descriptionController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill in all required fields')),
        );
        return;
      }
    } else if (currentStep == 2) {
      if (selectedServices.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select at least one service')),
        );
        return;
      }
    } else if (currentStep == 4) {
      if (_hourlyRateController.text.isEmpty ||
          _minimumChargeController.text.isEmpty ||
          _emergencyRateController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill in all pricing fields')),
        );
        return;
      }
    }

    if (currentStep < totalSteps) {
      setState(() {
        currentStep++;
      });
    } else {
      _submitApplication();
    }
  }

  void _submitApplication() async {
    // Save professional status
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_professional', true);
    await prefs.setString('business_name', _businessNameController.text);
    await prefs.setString('business_type', selectedBusinessType);
    await prefs.setString('experience_years', _experienceController.text);
    await prefs.setString('business_description', _descriptionController.text);
    await prefs.setStringList('selected_services', selectedServices);
    await prefs.setString('service_location', _locationController.text);
    await prefs.setString('service_radius', selectedRadius);
    await prefs.setString('hourly_rate', _hourlyRateController.text);
    await prefs.setString('minimum_charge', _minimumChargeController.text);
    await prefs.setString('emergency_rate', _emergencyRateController.text);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Setup Complete!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 48),
            SizedBox(height: 16),
            Text(
              'Your professional account has been set up successfully. You can now start accepting bookings!',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfessionalProfileScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF2E86AB)),
            child: Text('View Profile', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _businessNameController.dispose();
    _experienceController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _hourlyRateController.dispose();
    _minimumChargeController.dispose();
    _emergencyRateController.dispose();
    super.dispose();
  }
}