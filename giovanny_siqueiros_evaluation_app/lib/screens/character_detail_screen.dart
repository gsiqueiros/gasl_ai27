import 'package:flutter/material.dart';
import 'package:giovanny_siqueiros_evaluation_app/models/character.dart';
import 'package:connectivity/connectivity.dart';

class CharacterDetailScreen extends StatefulWidget {
  final Character character;

  CharacterDetailScreen({required this.character});

  @override
  _CharacterDetailScreenState createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  String _connectionStatus = '';

  @override
  void initState() {
    super.initState();
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
        title: Text(widget.character.name),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(widget.character.image),
                ),
                SizedBox(height: 16),
                Text(
                  '${widget.character.name}',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.yellowAccent),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                _buildInfoBlock(
                  title: 'Información General',
                  children: [
                    _buildInfoRow('Estatus', widget.character.status),
                    _buildInfoRow('Especie', widget.character.species),
                    _buildInfoRow('Tipo', widget.character.type),
                    _buildInfoRow('Género', widget.character.gender),
                  ],
                ),
                SizedBox(height: 16),
                _buildInfoBlock(
                  title: 'Origen',
                  children: [
                    _buildInfoRow('Lugar', widget.character.origin.name),
                  ],
                ),
                SizedBox(height: 16),
                _buildInfoBlock(
                  title: 'Ubicación',
                  children: [
                    _buildInfoRow('Lugar', widget.character.location.name),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBlock({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        SizedBox(height: 8),
        ...children,
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Spacer(),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value, style: TextStyle(color: Colors.lightBlueAccent)),
          ),
        ],
      ),
    );
  }
}
