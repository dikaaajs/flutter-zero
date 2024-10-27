import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:zero/components/navbar.dart';
import 'package:zero/services/auth_provider.dart';

class UploadNote extends StatelessWidget {
  const UploadNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Navbar(title: "upload"),
      ),
      body: const Column(children: [FormUpload()]),
    );
  }
}

class FormUpload extends StatefulWidget {
  const FormUpload({super.key});

  @override
  State<FormUpload> createState() => _FormUploadState();
}

class _FormUploadState extends State<FormUpload> {
  final TextEditingController _headlineController = TextEditingController();
  final TextEditingController _valueNoteController = TextEditingController();

  Future<void> _submitNote() async {
    final String headline = _headlineController.text;
    final String valueText = _valueNoteController.text;
    final user = Provider.of<Auth_Provider>(context, listen: false).user;

    // JSON body yang akan dikirimkan
    final Map<String, dynamic> note = {
      'headline': headline,
      'valueNote': [
        {'typeValue': 'text', 'value': valueText},
      ],
      'creatorId': user?.uid
    };

    try {
      // Mengirim POST request ke API
      final response = await http.post(
        Uri.parse('${dotenv.env['API']}/api/note'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(note),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Note successfully uploaded!',
              style: GoogleFonts.inter(
                  textStyle:
                      const TextStyle(fontSize: 12, color: Colors.white)),
            ),
            backgroundColor: Colors.green,
          ),
        );

        GoRouter.of(context).go('/');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload note: ${response.body}')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          TextField(
            controller: _headlineController,
            decoration: InputDecoration(
                hintStyle: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold)),
                hintText: 'Headline',
                border: InputBorder.none),
            style:
                GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: _valueNoteController,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Paragraph',
                hintStyle: GoogleFonts.inter(
                    fontSize: 15, fontWeight: FontWeight.normal)),
            style:
                GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitNote,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
