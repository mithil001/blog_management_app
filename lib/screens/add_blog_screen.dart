import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/blog_controller.dart';
import '../utils/app_constants.dart';
import '../widgets/app_text_field.dart';
import '../widgets/gradient_button.dart';

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({super.key});

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  final BlogController blogController = Get.find<BlogController>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Blog title is required';
    }

    if (value.trim().length < 3) {
      return 'Title must be at least 3 characters';
    }

    return null;
  }

  String? validateContent(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Blog content is required';
    }

    if (value.trim().length < 10) {
      return 'Content must be at least 10 characters';
    }

    return null;
  }

  void submitBlog() {
    if (formKey.currentState!.validate()) {
      blogController.addBlog(
        title: titleController.text,
        content: contentController.text,
      );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColors.darkText,
        ),
        title: Text(
          'Add Blog',
          style: AppTextStyles.headingMedium.copyWith(
            fontSize: context.responsiveFont(20),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: context.screenPadding(),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(
                    context.responsiveWidth(18),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppRadius.large),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.cardShadow,
                        blurRadius: context.responsiveWidth(16),
                        offset: Offset(
                          0,
                          context.responsiveHeight(8),
                        ),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.edit_note_rounded,
                        color: AppColors.primary,
                        size: context.responsiveFont(54),
                      ),
                      SizedBox(height: context.responsiveHeight(8)),
                      Text(
                        'Create a New Blog',
                        style: AppTextStyles.headingMedium.copyWith(
                          fontSize: context.responsiveFont(21),
                        ),
                      ),
                      SizedBox(height: context.responsiveHeight(6)),
                      Text(
                        'Write your thoughts and publish them.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.body.copyWith(
                          fontSize: context.responsiveFont(14),
                          color: AppColors.lightText,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: context.responsiveHeight(24)),

                AppTextField(
                  controller: titleController,
                  label: 'Blog Title',
                  hint: 'Enter blog title',
                  icon: Icons.title_rounded,
                  validator: validateTitle,
                ),

                SizedBox(height: context.responsiveHeight(20)),

                AppTextField(
                  controller: contentController,
                  label: 'Blog Content',
                  hint: 'Write your blog content here...',
                  icon: Icons.description_outlined,
                  maxLines: 10,
                  validator: validateContent,
                ),

                SizedBox(height: context.responsiveHeight(28)),

                Obx(
                      () => GradientButton(
                    text: 'Post Blog',
                    icon: Icons.send_rounded,
                    isLoading: blogController.isLoading.value,
                    onPressed: submitBlog,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}