// import 'package:flutter/material.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Generative AI Content Generator',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: GenerativeAIContentScreen(),
//     );
//   }
// }

// class GenerativeAIContentScreen extends StatefulWidget {
//   @override
//   _GenerativeAIContentScreenState createState() =>
//       _GenerativeAIContentScreenState();
// }

// class _GenerativeAIContentScreenState extends State<GenerativeAIContentScreen> {
//   final TextEditingController _promptController = TextEditingController();
//   String _response = '';
//   bool _isLoading = false;

//   final String _apiKey = 'YOUR_API_KEY_HERE'; // Replace with your API key
//   late GenerativeModel _model;

//   @override
//   void initState() {
//     super.initState();
//     _initializeModel();
//   }

//   void _initializeModel() {
//     _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: _apiKey);
//   }

//   Future<void> _generateContent() async {
//     final prompt = _promptController.text.trim();
//     if (prompt.isEmpty) {
//       setState(() {
//         _response = 'Please enter a prompt!';
//       });
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//       _response = '';
//     });

//     try {
//       final content = [Content.text(prompt)];
//       final result = await _model.generateContent(content);
//       setState(() {
//         _response = result.text ?? 'No response received.';
//       });
//     } catch (e) {
//       setState(() {
//         _response = 'Error: $e';
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Generative AI Content'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _promptController,
//               decoration: const InputDecoration(
//                 labelText: 'Enter your prompt',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 2,
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _isLoading ? null : _generateContent,
//               child: _isLoading
//                   ? CircularProgressIndicator(color: Colors.white)
//                   : Text('Generate Content'),
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     _response.isEmpty
//                         ? 'Response will appear here.'
//                         : _response,
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
