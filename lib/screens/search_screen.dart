import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram/utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchControllerTE = TextEditingController();
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Padding(
          padding: const EdgeInsets.all(20),
          child: TextField(
            controller: searchControllerTE,
            decoration: const InputDecoration(labelText: 'Search for a user'),
            onSubmitted: (String _) {
              isShow = true;
              setState(() {});
            },
          ),
        ),
      ),
      body: isShow
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('username',
                      isGreaterThanOrEqualTo: searchControllerTE.text)
                  .get(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            snapshot.data?.docs[index]['profilePic'] ?? ['']),
                      ),
                      title: Text(snapshot.data?.docs[index]['username']),
                    );
                  },
                );
              })
          : FutureBuilder(
              future: FirebaseFirestore.instance.collection('posts').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return MasonryGridView.count(
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 2,
                  crossAxisCount: 3, // Define the number of columns
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            snapshot.data!.docs[index]['postURL'],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }),
    );
  }
}
