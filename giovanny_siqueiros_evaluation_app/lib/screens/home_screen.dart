import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:giovanny_siqueiros_evaluation_app/providers/character_provider.dart';
import 'package:giovanny_siqueiros_evaluation_app/screens/character_detail_screen.dart';
import 'package:giovanny_siqueiros_evaluation_app/screens/recently_viewed_screen.dart';
import 'package:connectivity/connectivity.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  String _searchTerm = '';
  String _connectionStatus = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        context.read<CharacterProvider>().fetchCharacters();
      }
    });
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _connectionStatus = 'No hay conexión a Internet';
      });
    } else {
      setState(() {
        _connectionStatus = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Personajes')),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: _connectionStatus.isNotEmpty
          ? Center(
        child: Text(
          _connectionStatus,
          style: TextStyle(fontSize: 18),
        ),
      )
          : Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/rickmortybgspace4.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Búsqueda por nombre',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchTerm = value.toLowerCase();
                  });
                },
              ),
            ),
            Expanded(
              child: Consumer<CharacterProvider>(
                builder: (context, provider, child) {
                  final characters = provider.characters.where((character) {
                    return character.name.toLowerCase().contains(_searchTerm);
                  }).toList();

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: characters.length,
                    itemBuilder: (context, index) {
                      final character = characters[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            provider.addRecentlyViewed(character);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CharacterDetailScreen(character: character),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(character.image),
                              ),
                              title: Text(character.name, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            if (context.watch<CharacterProvider>().isLoading)
              Center(child: CircularProgressIndicator()),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecentlyViewedScreen(),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  'Últimos Vistos',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.yellow,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
