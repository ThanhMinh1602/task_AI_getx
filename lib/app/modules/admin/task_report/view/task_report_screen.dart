import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/modules/admin/task_report/controller/task_report_controller.dart';
import 'package:task/core/constants/app_style.dart';
import 'package:task/core/widgets/custom_button.dart';
import 'package:task/core/widgets/custom_dropdown_button.dart';
import 'package:task/core/widgets/custom_text_field.dart';

class TaskReportScreen extends StatelessWidget {
  TaskReportScreen({super.key});
  final TaskReportController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Báo cáo Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() {
              return controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            controller.reportContent.value.isEmpty
                                ? 'Response will appear here.'
                                : controller.reportContent.value,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    );
            }),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 5,
                  child: CustomTextField(
                    prefixIcon: const Icon(Icons.emoji_emotions_outlined),
                    controller: controller.promptController,
                    hintText: 'Enter your prompt...',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Obx(
                    () => DropdownButtonFormField<GeminiType>(
                      value: controller.typeGemini.value,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      items: [
                        DropdownMenuItem<GeminiType>(
                            value: GeminiType.report,
                            child: Text(
                              'Gemini report',
                              style: AppStyle.regular14,
                            )),
                        DropdownMenuItem<GeminiType>(
                            value: GeminiType.chat,
                            child: Text(
                              'Gemini chat',
                              style: AppStyle.regular14,
                            )),
                      ],
                      onChanged: (p0) {
                        controller.changeTypeGemini(p0!);
                      },
                    ),
                  ),
                ),
              ],
            ),
            CustomButton(
              onPressed: () {
                controller.generateGemini();
              },
              label: 'Send',
            ),
          ],
        ),
      ),
    );
  }
}
