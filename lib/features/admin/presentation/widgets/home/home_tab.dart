
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rx_project/core/constants/app_colors.dart';
import 'package:rx_project/features/admin/domain/enums/form_fields_enum.dart';
import 'package:rx_project/features/admin/presentation/manager/profile_manage_bloc/profile_manage_bloc.dart';
import 'package:rx_project/features/admin/presentation/widgets/home/custom_form_field.dart';
import '../../../data/model/request/user_profile_model.dart';

part 'home_controller_mixin.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with HomeControllerMixin<HomeTab> {


  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileManageBloc, ProfileManageState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error!)),
          );
        }
      },
      child: Container(
        color: AppColors.darkGrey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<ProfileManageBloc, ProfileManageState>(
            builder: (context, ProfileManageState profileState) {
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildTextField(
                          'First Name',
                          FormFieldType.firstName,
                          controller: firstNameController,
                          initialValue: profileState.data?.firstName
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                          'Last Name',
                          FormFieldType.lastName,
                          controller: lastNameController,
                          initialValue: profileState.data?.lastName
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                          'Email',
                          FormFieldType.email,
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          initialValue: profileState.data?.email
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                          'Phone Number',
                          FormFieldType.phoneNumber,
                          keyboardType: TextInputType.phone,
                          controller: phoneNumberController,
                          initialValue: profileState.data?.phoneNumber
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                          'Address',
                          FormFieldType.address,
                          maxLines: 3,
                          controller: addressController,
                          initialValue: profileState.data?.address
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                          'Bio',
                          FormFieldType.bio,
                          maxLines: 3,
                          controller: bioController,
                          initialValue: profileState.data?.bio
                      ),
                      const SizedBox(height: 16),
                      _buildTextField('Role', FormFieldType.role, controller: roleController,
                          initialValue: profileState.data?.role),
                      const SizedBox(height: 16),
                      _buildTextField(
                          'Profile Picture URL',
                          FormFieldType.profilePictureUrl,
                          keyboardType: TextInputType.url,
                          initialValue: profileState.data?.profilePictureUrl,
                          controller: profilePictureUrlController
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: profileState.isLoading ? null : _submitForm,
                        child: profileState.isLoading
                            ? const CircularProgressIndicator()
                            : const Text('Save Profile'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  
  Widget _buildTextField(
    String label,
    FormFieldType field, {
    TextInputType? keyboardType,
    int? maxLines,
    String? initialValue,
    TextEditingController? controller,
  }) {
    // If we have both controller and initialValue, update the controller's text
    if (controller != null && initialValue != null) {
      if (controller.text != initialValue) {
        controller.text = initialValue;
      }
    }

    return CustomFormField(
      label: label,
      field: field,
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      keyboardType: keyboardType,
      maxLines: maxLines,
      onSaved: (value) => onSaved(value, field),
    );
  }
}
