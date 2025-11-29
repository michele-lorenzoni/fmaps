import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();
  LatLng? _currentPosition;
  final LatLng _italianCentralPoint = LatLng(41.9028, 12.4964);
  bool _isLoadingPosition = true;
  
  // Carica il token di accesso dal .env
  late final String _mapboxUrlTemplate;
  
  @override
  void initState() {
    super.initState();
    _initializeMap();
  }
  
  Future<void> _initializeMap() async {
    // Carica il token di accesso da .env
    final accessToken = dotenv.env['MAPBOX_ACCESS_TOKEN'];
    
    // Costruisci l'URL template con il token
    _mapboxUrlTemplate = 
        'https://api.mapbox.com/styles/v1/mapbox/streets-v12/tiles/{z}/{x}/{y}?access_token=$accessToken';
    
    // Ottieni la posizione corrente
    await _getCurrentPosition();
  }
  
  Future<void> _getCurrentPosition() async {
    setState(() {
      _isLoadingPosition = true;
    });
    
    try {
      // Controlla se i servizi di localizzazione sono abilitati
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _isLoadingPosition = false;
        });
        return;
      }

      // Controlla e richiedi i permessi
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _isLoadingPosition = false;
          });
          return;
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _isLoadingPosition = false;
        });
        return;
      }

      // Ottieni la posizione corrente con le nuove LocationSettings
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _isLoadingPosition = false;
      });
      
    } catch (e) {
      print('Errore: $e');
      setState(() {
        _isLoadingPosition = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingPosition) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _currentPosition ?? _italianCentralPoint,
            initialZoom: 11.0,
          ),
          children: [
            TileLayer(
              urlTemplate: _mapboxUrlTemplate,
              userAgentPackageName: 'com.example.flutter_map_example',
            ),
            if (_currentPosition != null)
              MarkerLayer(
                markers: [
                  Marker(
                    point: _currentPosition!,
                    width: 23,
                    height: 23,
                    child: const Icon(
                      Icons.my_location,
                      color: Colors.blue,
                      size: 23,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
  
  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}