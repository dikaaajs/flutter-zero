import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zero/components/navbar.dart';
import 'package:zero/components/note-detail.dart';
import 'package:zero/services/auth_provider.dart';
import 'package:http/http.dart' as http;

class Notepage extends StatefulWidget {
  final String id;
  const Notepage({super.key, required this.id});

  @override
  State<Notepage> createState() => _NotepageState();
}

class Note {
  final String id;
  final String title;
  final String text;

  Note({required this.id, required this.title, required this.text});

  factory Note.fromJson(Map<String, dynamic> json) {
    debugPrint('Response: $json');
    return Note(
      id: json['_id'],
      title: json['headline'],
      text: json['valueNote'][0]['value'],
    );
  }
}

class _NotepageState extends State<Notepage> {
  Note? note; // Ubah ke Note? untuk menampung satu note
  bool isLoading = true;
  String? uid;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = Provider.of<Auth_Provider>(context, listen: false).user;
      uid = user?.uid;
      if (uid != null) {
        fetchNote();
      }
    });
  }

  Future<void> fetchNote() async {
    try {
      final response = await http.get(
        Uri.parse('${dotenv.env['API']}/api/note?d=${widget.id}'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          note = Note.fromJson(data); // Set data sebagai satu note
          isLoading = false;
        });
      } else {
        // Handle error response
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(note);
    final isLoggedIn =
        Provider.of<Auth_Provider>(context, listen: true).isLoggedIn;

    if (!isLoggedIn) context.go('/login');

    return Scaffold(
        appBar: const Navbar(
          title: "Home",
        ),
        backgroundColor: Colors.white,
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : note == null
                ? const Center(child: Text("No note found."))
                : NoteDetail(headline: note!.title, paragraph: note!.text));
  }
}
