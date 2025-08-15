import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rx_project/core/constants/app_colors.dart';
import 'package:rx_project/features/admin/data/model/request/user_profile_model.dart';
import 'package:rx_project/features/admin/presentation/manager/profile_manage_bloc/profile_manage_bloc.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final _formKey = GlobalKey<FormState>();
  final _profile = UserProfileModel(); // Temporary ID for new profile
  final Map<String, TextEditingController> _controllers = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each field
    _controllers['firstName'] = TextEditingController();
    _controllers['lastName'] = TextEditingController();
    _controllers['email'] = TextEditingController();
    _controllers['phoneNumber'] = TextEditingController();
    _controllers['address'] = TextEditingController();
    _controllers['bio'] = TextEditingController();
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();


      // Create or update profile using the bloc
      final bloc = context.read<ProfileManageBloc>();
      if (_profile.id == null) {
        // Create new profile
        bloc.add(CreateUserEvent(userProfile: _profile.createdNew()));
      } else {
        // Update existing profile
        bloc.add(UpdateUserEvent(userProfile: _profile));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileManageBloc, ProfileManageState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.error}')),
          );
        } else if (state.data != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile saved successfully!')),
          );
        }
        setState(() => _isLoading = false);
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Card(
          color: AppColors.darkGrey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'User Profile',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField('First Name', 'firstName'),
                  const SizedBox(height: 12),
                  _buildTextField('Last Name', 'lastName'),
                  const SizedBox(height: 12),
                  _buildTextField(
                    'Email', 
                    'email', 
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    'Phone Number', 
                    'phoneNumber', 
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    'Address', 
                    'address', 
                    keyboardType: TextInputType.streetAddress,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    'Bio', 
                    'bio', 
                    keyboardType: TextInputType.multiline, 
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _submitForm,
                    child: _isLoading 
                        ? const CircularProgressIndicator()
                        : const Text('Save Profile'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String field, {
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: _controllers[field],
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        if (field == 'email' && !value.contains('@')) {
          return 'Please enter a valid email';
        }
        return null;
      },
      onSaved: (value) {
        switch (field) {
          case 'firstName':
            _profile.firstName = value;
            break;
          case 'lastName':
            _profile.lastName = value;
            break;
          case 'email':
            _profile.email = value;
            break;
          case 'phoneNumber':
            _profile.phoneNumber = value;
            break;
          case 'address':
            _profile.address = value;
            break;
          case 'bio':
            _profile.bio = value;
            break;
        }
      },
    );
  }
}
