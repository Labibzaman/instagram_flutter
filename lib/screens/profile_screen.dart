import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('username'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1719931626206-d3874333fd00?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      ),
                    ),


                  ],
                ),
                
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      followerCounter(label: 'posts', num: 12),
                      followerCounter(label: 'followers', num: 120),
                      followerCounter(label: 'following', num: 18),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  followerCounter({required String label, required int num}) {
    return Column(
      children: [
        Text(
          num.toString(),
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
        ),
      ],
    );
  }
}
