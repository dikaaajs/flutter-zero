import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:zero/components/navbar.dart';
import 'package:zero/services/auth_provider.dart';

// Model untuk note
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

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Note> notes = [];
  bool isLoading = true;
  String? uid;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = Provider.of<Auth_Provider>(context, listen: false).user;
      uid = user?.uid;
      if (uid != null) {
        fetchNotes();
      }
    });
  }

  Future<void> fetchNotes() async {
    try {
      final response =
          await http.get(Uri.parse('${dotenv.env['API']}/api/note?v=$uid'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          notes = data.map((note) => Note.fromJson(note)).toList();
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
    final isLoggedIn =
        Provider.of<Auth_Provider>(context, listen: true).isLoggedIn;

    if (!isLoggedIn) context.go('/login');
    return Scaffold(
      appBar: const Navbar(
        title: "Home",
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Tampilkan loading indicator
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return Card(
                  margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  elevation: 5,
                  color: Colors.white,
                  child: InkWell(
                      onTap: () {
                        context.go('/note/${note.id}');
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                            child: Text(
                              note.title,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w900),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 0, 10, 20),
                            child: Text(note.text),
                          ),
                        ],
                      )),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          context.go('/upload');
        },
      ),
    );
  }
}
