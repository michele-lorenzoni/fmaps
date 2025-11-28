import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import './styles/app_theme.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: MapScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const LatLng _italianCentralPoint = LatLng(42.504154, 12.646361);
  final String _mapboxUserId = dotenv.env['MAPBOX_USER_ID'] ?? '';
  String _mapboxStyleId = 'cmi8moylp006d01s99vudhvur';
  final String _mapboxAccessToken = dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? '';

  late String _mapboxUrlTemplate;
  final TextEditingController _styleIdController = TextEditingController();
  
  LatLng? _currentPosition;
  bool _isLoadingPosition = true;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _mapboxUrlTemplate =
        'https://api.mapbox.com/styles/v1/$_mapboxUserId/$_mapboxStyleId/tiles/256/{z}/{x}/{y}?access_token=$_mapboxAccessToken';
    _styleIdController.text = _mapboxStyleId;
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _isLoadingPosition = false;
      });
    } catch (e) {
      print('Errore nel recupero della posizione: $e');
      setState(() {
        _currentPosition = _italianCentralPoint;
        _isLoadingPosition = false;
      });
    }
  }

  @override
  void dispose() {
    _styleIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingPosition) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentPosition ?? _italianCentralPoint,
              initialZoom: 13.0,
              maxZoom: 18.0,
              minZoom: 5.0,
            ),
            children: [
              TileLayer(
                key: ValueKey(_mapboxStyleId),
                urlTemplate: _mapboxUrlTemplate,
                userAgentPackageName: 'com.example.flutter_map_example',
              ),
              // Marker per la posizione corrente
              if (_currentPosition != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _currentPosition!,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.my_location,
                        color: Colors.blue,
                        size: 40,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}