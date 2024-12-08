import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/data/models/task_model.dart';
import 'package:task/app/modules/controllers/task_controller.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/constants/app_style.dart';
import 'package:task/core/extensions/build_context_extension.dart';
import 'package:task/core/utils/validator.dart';
import 'package:task/core/widgets/custom_appbar.dart';
import 'package:task/core/widgets/custom_background.dart';
import 'package:task/core/widgets/custom_button.dart';
import 'package:task/core/widgets/custom_card.dart';
import 'package:task/core/widgets/custom_dialog.dart';
import 'package:task/core/widgets/custom_dropdown_button.dart';
import 'package:task/core/widgets/custom_text_field.dart';

class AdminTaskDetailScreen extends StatefulWidget {
  final TaskModel? taskModel;

  const AdminTaskDetailScreen({super.key, this.taskModel});

  @override
  State<AdminTaskDetailScreen> createState() => _AdminTaskDetailScreenState();
}

class _AdminTaskDetailScreenState extends State<AdminTaskDetailScreen> {
  final TaskController taskController = Get.find<TaskController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: widget.taskModel?.title ?? 'Add New Task'),
      body: CustomBackground(
        child: GestureDetector(
          onTap: () => context.unFocus,
          child: Form(
            key: taskController.formKey,
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
              child: CustomCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleField(),
                    const SizedBox(height: 12.0),
                    const Divider(color: AppColor.kDCE1EF),
                    const SizedBox(height: 20.0),
                    _buildTaskDescription(),
                    const SizedBox(height: 20.0),
                    _buildDropdownSection(),
                    const SizedBox(height: 20.0),
                    _buildDeadlineField(context),
                    const SizedBox(height: 24.0),
                    if (widget.taskModel != null)
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              label: 'Delete',
                              backgroundColor: Colors.red,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  useRootNavigator: true,
                                  builder: (context) {
                                    return CustomDialog(
                                      title: 'Delete',
                                      content:
                                          'Are you sure you want to delete?',
                                      onConfirm: () {},
                                      // onConfirm: () => taskController
                                      //     .onDelete(widget.taskModel!.id),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: CustomButton(
                                label: 'Update',
                                onPressed: () {
                                  // taskController
                                  //     .updateTask(widget.taskModel!.id);
                                }),
                          ),
                        ],
                      )
                    else
                      CustomButton(
                          label: 'Add new member',
                          onPressed: () {
                            // taskController.addTask();
                          }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Title', style: AppStyle.medium14),
        const SizedBox(height: 10.0),
        CustomTextField(
          controller: taskController.titleController,
          validator: (value) => Validator.validateEmpty(value!),
        ),
      ],
    );
  }

  Widget _buildTaskDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Task Description', style: AppStyle.medium14),
        const SizedBox(height: 10.0),
        CustomTextField(
          controller: taskController.descriptionController,
          maxLines: 5,
          validator: (value) => Validator.validateEmpty(value!),
        ),
      ],
    );
  }

  Widget _buildDropdownSection() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: _buildDropdown(
            label: 'Assigned to',
            value: taskController.selectedUserId.value.isEmpty
                ? null
                : taskController.selectedUserId.value,
            items: taskController.users.map((user) => DropdownMenuItem<String>(
                  value: user.id,
                  child: Text(
                    user.name,
                  ),
                )),
            onChanged: (value) {},
            hint: 'Choose user',
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          flex: 2,
          child: _buildDropdown(
            label: 'Status',
            value: taskController.selectedStatus.value.isEmpty
                ? null
                : taskController.selectedStatus.value,
            items:
                taskController.statues.map((status) => DropdownMenuItem<String>(
                      value: status.label,
                      child: Text(status.label),
                    )),
            onChanged: (value) {},
            hint: 'Choose status',
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required Iterable<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyle.medium14),
        const SizedBox(height: 10.0),
        CustomDropdownButton(
          validator: (value) => Validator.validateEmpty(value!),
          selectedValue: value,
          items: [
            DropdownMenuItem<String>(
              value: null,
              child:
                  Text(hint, style: const TextStyle(color: AppColor.kDCE1EF)),
            ),
            ...items,
          ],
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildDeadlineField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Deadline', style: AppStyle.medium14),
        const SizedBox(height: 10.0),
        CustomTextField(
          readOnly: true,
          prefixIcon: const Icon(Icons.calendar_today),
          controller: taskController.dueDateController,
          onTap: () {},
        ),
      ],
    );
  }
}
