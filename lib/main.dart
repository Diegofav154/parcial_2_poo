import 'package:flutter/material.dart';
import 'dart:html' as html;

void main() {
  runApp(const MuseoApp());
}

class MuseoApp extends StatelessWidget {
  const MuseoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Museos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(), // Modo claro
      home: const CatalogoMuseosScreen(),
    );
  }
}

// Modelo simple de Museo
class Museo {
  final String nombre;
  final String descripcion;
  final String latitud;
  final String longitud;
  final String urlWeb;
  final String urlImagen;

  const Museo({
    required this.nombre,
    required this.descripcion,
    required this.latitud,
    required this.longitud,
    required this.urlWeb,
    required this.urlImagen,
  });
}

// Datos de los 4 museos
final List<Museo> listaMuseos = [
  const Museo(
    nombre: 'Museo de Arte del Río',
    descripcion:
        'Colección de pintura y escultura moderna, con salas dedicadas al arte del siglo XX y a exposiciones temporales.',
    latitud: '4.5981',
    longitud: '-74.0760',
    urlWeb: 'https://museudeartedorio.org.br/',
    urlImagen: 'https://picsum.photos/id/1043/400/300',
  ),
  const Museo(
    nombre: 'Museo de Historia Natural Andina',
    descripcion:
        'Especímenes de fauna, flora y geología de la región andina, organizados para consulta del público y de investigadores.',
    latitud: '6.2518',
    longitud: '-75.5636',
    urlWeb: 'http://historianatural.unal.edu.co/',
    urlImagen: 'https://picsum.photos/id/1067/400/300',
  ),
  const Museo(
    nombre: 'Museo Arqueológico del Altiplano',
    descripcion:
        'Piezas arqueológicas de cerámica, orfebrería y piedra, conservadas como patrimonio de las culturas del altiplano.',
    latitud: '5.0703',
    longitud: '-75.5138',
    urlWeb: 'https://www.banrepcultural.org/bogota/museo-botero',
    urlImagen: 'https://picsum.photos/id/1059/400/300',
  ),
  const Museo(
    nombre: 'Casa Museo del Patrimonio Local',
    descripcion:
        'Exposición permanente sobre la evolución urbana, fotográfica y cultural del municipio a lo largo de los siglos.',
    latitud: '3.4516',
    longitud: '-76.5320',
    urlWeb: 'https://museodeindependencia.mincultura.gov.co',
    urlImagen: 'https://picsum.photos/id/1018/400/300',
  ),
];

class CatalogoMuseosScreen extends StatelessWidget {
  const CatalogoMuseosScreen({super.key});

  void _abrirUrlWeb(String url) {
    html.window.open(url, '_blank');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guía de Museos'),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                // Fila con Barra de Búsqueda y Contador de Museos
                Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        enabled: false, // Visual únicamente
                        decoration: InputDecoration(
                          hintText: 'Buscar museo...',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Widget indicador de cantidad
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue.shade300),
                      ),
                      child: Text(
                        '${listaMuseos.length} Museos',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900],
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                // Grilla de 2 en 2
                Expanded(
                  child: GridView.builder(
                    itemCount: listaMuseos.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,
                    ),
                    itemBuilder: (context, index) {
                      final museo = listaMuseos[index];
                      return Card(
                        elevation: 2,
                        child: InkWell(
                          onTap: () => _abrirUrlWeb(museo.urlWeb),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Image.network(
                                    museo.urlImagen,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Center(child: Icon(Icons.museum, size: 40)),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  museo.nombre,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  museo.descripcion,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[700],
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${museo.latitud}, ${museo.longitud}',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}