import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:owl_test/src/screens/all_posts_screen.dart';
import 'package:owl_test/src/screens/login.dart';
import 'package:owl_test/src/services/post_service.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  TextEditingController titlePost = TextEditingController();
  TextEditingController authorID = TextEditingController();
  TextEditingController contentPost = TextEditingController();

  void savePost() async {
    print("adgav");
    final isSaved = await PostService.savePost({
      "title": titlePost.text,
      "author_id": int.parse(authorID.text),
      "content": contentPost.text
    });

    if (isSaved) {
      print("Berhasil disimpan");
    } else {
      print("gagal");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Blog"),
        actions: [
          IconButton(
              onPressed: () async {
                await googleSignIn.signOut();

                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Login()));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: titlePost,
                decoration: const InputDecoration(hintText: "Title Post"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: authorID,
                decoration: const InputDecoration(hintText: "Author ID"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: contentPost,
                decoration: const InputDecoration(hintText: "Content Post"),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () => savePost(),
                      child: const Text("Save Post")),
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const AllPostsScreen())),
                      child: const Text("Lihat Post"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
