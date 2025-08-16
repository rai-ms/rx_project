

part of 'home_tab.dart';

mixin HomeControllerMixin<T extends StatefulWidget> on State<T> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for each field
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneNumberController;
  late final TextEditingController addressController;
  late final TextEditingController bioController;
  late final TextEditingController roleController;
  late final TextEditingController profilePictureUrlController;

  late final ProfileManageBloc _profileManageBloc;

  @override
  void initState() {
    // Initialize all controllers
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    addressController = TextEditingController();
    bioController = TextEditingController();
    roleController = TextEditingController();
    profilePictureUrlController = TextEditingController();
    _profileManageBloc = context.read<ProfileManageBloc>();
    super.initState();
  }

  @override
  void dispose() {
    // Dispose all controllers
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    bioController.dispose();
    roleController.dispose();
    profilePictureUrlController.dispose();
    
    super.dispose();
  }

  void onSaved(String? value, FormFieldType field) {
    if (value == null) return;
    
    switch (field) {
      case FormFieldType.firstName:
        firstNameController.text = value;
        break;
      case FormFieldType.lastName:
        lastNameController.text = value;
        break;
      case FormFieldType.email:
        emailController.text = value;
        break;
      case FormFieldType.phoneNumber:
        phoneNumberController.text = value;
        break;
      case FormFieldType.address:
        addressController.text = value;
        break;
      case FormFieldType.bio:
        bioController.text = value;
        break;
      case FormFieldType.role:
        roleController.text = value;
        break;
      case FormFieldType.profilePictureUrl:
        profilePictureUrlController.text = value;
        break;
    }
  }


  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // if (_profileManageBloc.state.data?.id == null) {
      //   _profileManageBloc.add(CreateUserEvent(
      //       userProfile: UserProfileModel()
      //   )
      // );
      // } else {
      //
      // }

      _profileManageBloc.add(UpdateUserEvent(
          userProfile: UserProfileModel(
            address: addressController.text,
            bio: bioController.text,
            email: emailController.text,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            phoneNumber: phoneNumberController.text,
            profilePictureUrl: profilePictureUrlController.text,
            role: roleController.text,
          ).createdNew()
      )
      );


    }
  }





}