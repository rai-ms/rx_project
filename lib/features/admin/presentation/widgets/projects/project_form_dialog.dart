import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:rx_project/features/admin/presentation/manager/projects_bloc/projects_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text.dart';
import '../../../domain/model/request/home_project_model.dart';

class ProjectFormDialog extends StatefulWidget {
  final HomeProjectModel? project;
  final Function(HomeProjectModel, XFile?) onSubmit;
  final Function() onImageUpload;
  final String? imageUrl;
  final bool isLoading;
  final bool isUploadingImage;

  const ProjectFormDialog({
    super.key,
    this.project,
    required this.onSubmit,
    required this.onImageUpload,
    this.imageUrl,
    this.isLoading = false,
    this.isUploadingImage = false,
  });

  @override
  State<ProjectFormDialog> createState() => _ProjectFormDialogState();
}

class _ProjectFormDialogState extends State<ProjectFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _imageLink;
  late TextEditingController _descriptionController;
  final ValueNotifier<String?> _imageUrl = ValueNotifier<String?>(null);
  Uint8List? localImageBytes;
  XFile? file;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.project?.name ?? '');
    _imageLink = TextEditingController(text: widget.project?.imageUrl ?? '');
    _descriptionController =
        TextEditingController(text: widget.project?.description ?? '');
    _imageUrl.value = widget.imageUrl ?? widget.project?.imageUrl;
  }

  @override
  void didUpdateWidget(covariant ProjectFormDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.imageUrl != oldWidget.imageUrl) {
      _imageUrl.value = widget.imageUrl;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }


  Future<XFile?> getFile() async {
    XFile? pickedFile = await ImagePickerPlugin().getImageFromSource(source: ImageSource.gallery);
    return pickedFile;
  }


  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await getFile();

    if (pickedFile != null) {
      localImageBytes = await pickedFile.readAsBytes();
      file = pickedFile;
      widget.onImageUpload();
      setState(() {

      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final project = HomeProjectModel(
        id: widget.project?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        imageUrl: _imageLink.text,
        status: widget.project?.status ?? 'active',
      );
      // widget.onSubmit(project, file);
     context.pop(project);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.project == null ? AppText.addProject : AppText.editProject,
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image Preview and Upload
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: ValueListenableBuilder(
                    valueListenable: _imageUrl,
                    builder: (context, value, child) {
                      return _buildImageContent();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _imageLink,
                decoration: const InputDecoration(
                  labelText: AppText.imageLink,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppText.fieldRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: AppText.projectName,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppText.fieldRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: AppText.projectDescription,
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppText.fieldRequired;
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: widget.isLoading ? null : () => Navigator.pop(context),
          child: const Text(AppText.cancel),
        ),
        ElevatedButton(
          onPressed: widget.isLoading ? null : _submitForm,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.darkCharcoal,
            foregroundColor: Colors.white,
          ),
          child: widget.isLoading
              ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
              : const Text(AppText.save),
        ),
      ],
    );
  }

  Widget _buildImageContent() {
    if (widget.isUploadingImage) {
      return const Center(child: CircularProgressIndicator());
    }

    if (localImageBytes != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.memory(
          localImageBytes!,
          fit: BoxFit.cover,
          // remove width: double.infinity
        ),
      );
    } else if (_imageUrl.value?.isNotEmpty == true) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          _imageUrl.value!,
          fit: BoxFit.cover,
          // remove width: double.infinity
          errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
        ),
      );
    }

    return _buildPlaceholder();
  }


  Widget _buildPlaceholder() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.add_photo_alternate, size: 40, color: Colors.grey),
        SizedBox(height: 8),
        Text(
          'Tap to add image',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
