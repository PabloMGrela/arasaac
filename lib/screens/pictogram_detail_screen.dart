import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/pictogram.dart';
import '../services/download_service.dart';

class PictogramDetailScreen extends StatefulWidget {
  final Pictogram pictogram;

  const PictogramDetailScreen({
    super.key,
    required this.pictogram,
  });

  @override
  State<PictogramDetailScreen> createState() => _PictogramDetailScreenState();
}

class _PictogramDetailScreenState extends State<PictogramDetailScreen> {
  bool _showColor = true;

  Future<void> _downloadImage(String url, String filename) async {
    final success = await DownloadService.downloadImage(url, filename);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                success ? Icons.check_circle : Icons.error,
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  success ? 'Descargado: $filename' : 'Error al descargar',
                ),
              ),
            ],
          ),
          backgroundColor: success ? const Color(0xFF059669) : Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(widget.pictogram.firstKeyword),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(Icons.download),
              onPressed: () {
                _downloadImage(
                  widget.pictogram.getImageUrl(color: _showColor),
                  '${widget.pictogram.firstKeyword}_${widget.pictogram.id}.png',
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 400,
                    maxHeight: 400,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.pictogram.getImageUrl(color: _showColor),
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    errorWidget: (context, url, error) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.broken_image_outlined,
                          size: 100,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Imagen no disponible',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              setState(() {
                                _showColor = !_showColor;
                              });
                            },
                            icon: Icon(_showColor ? Icons.palette : Icons.palette_outlined),
                            label: Text(_showColor ? 'Ver en B/N' : 'Ver en Color'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.all(16),
                              side: BorderSide(color: Colors.grey[300]!),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Información',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 20),
                  const SizedBox(height: 16),
                  _buildInfoRow('ID', widget.pictogram.id.toString()),
                  if (widget.pictogram.keywords.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    _buildInfoSection(
                      'Palabras clave',
                      widget.pictogram.keywords.join(', '),
                    ),
                  ],
                  if (widget.pictogram.categories.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    _buildInfoSection(
                      'Categorías',
                      widget.pictogram.categories.join(', '),
                    ),
                  ],
                  const SizedBox(height: 12),
                  _buildInfoRow('Creado', _formatDate(widget.pictogram.created)),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    'Última actualización',
                    _formatDate(widget.pictogram.lastUpdated),
                  ),
                  if (widget.pictogram.bestseller != null) ...[
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      'Bestseller',
                      widget.pictogram.bestseller! ? 'Sí' : 'No',
                    ),
                  ],
                  if (widget.pictogram.schematic != null) ...[
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      'Esquemático',
                      widget.pictogram.schematic! ? 'Sí' : 'No',
                    ),
                  ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  _downloadImage(
                                    widget.pictogram.getImageUrl(color: true),
                                    '${widget.pictogram.firstKeyword}_${widget.pictogram.id}_color.png',
                                  );
                                },
                                icon: const Icon(Icons.download),
                                label: const Text('Descargar Color'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  _downloadImage(
                                    widget.pictogram.getImageUrl(color: false),
                                    '${widget.pictogram.firstKeyword}_${widget.pictogram.id}_bn.png',
                                  );
                                },
                                icon: const Icon(Icons.download),
                                label: const Text('Descargar B/N'),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.all(16),
                                  side: BorderSide(color: Colors.grey[300]!),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          child: Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
