import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:giovanny_siqueiros_evaluation_app/providers/character_provider.dart';
import 'package:giovanny_siqueiros_evaluation_app/screens/character_detail_screen.dart';

class RecentlyViewedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vistos Recientemente'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/rickmortybgspace4.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Consumer<CharacterProvider>(
          builder: (context, provider, child) {
            final recentlyViewed = provider.recentlyViewed;
            return ListView.builder(
              itemCount: recentlyViewed.length,
              itemBuilder: (context, index) {
                final character = recentlyViewed[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(character.image),
                  ),
                  title: Text(character.name,style: TextStyle(color: Colors.white),),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacterDetailScreen(character: character),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
