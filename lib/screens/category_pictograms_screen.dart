import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../providers/pictogram_provider.dart';
import '../widgets/pictogram_card.dart';
import '../services/download_service.dart';
import 'pictogram_detail_screen.dart';

class CategoryPictogramsScreen extends StatefulWidget {
  final Category category;

  const CategoryPictogramsScreen({
    super.key,
    required this.category,
  });

  @override
  State<CategoryPictogramsScreen> createState() => _CategoryPictogramsScreenState();
}

class _CategoryPictogramsScreenState extends State<CategoryPictogramsScreen> {
  bool _isDownloading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PictogramProvider>(context, listen: false)
          .loadPictogramsByCategory(widget.category.id);
    });
  }

  Future<void> _downloadAllPictograms() async {
    final provider = Provider.of<PictogramProvider>(context, listen: false);

    if (provider.pictograms.isEmpty) return;

    setState(() {
      _isDownloading = true;
    });

    // Mostrar diálogo de progreso
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _DownloadProgressDialog(
        totalPictograms: provider.pictograms.length,
        categoryName: widget.category.text,
      ),
    );

    try {
      final sanitizedCategory = widget.category.text
          .replaceAll(RegExp(r'[<>:"/\\|?*]'), '_')
          .replaceAll(' ', '_')
          .toLowerCase();

      final success = await DownloadService.downloadPictogramsAsZip(
        provider.pictograms,
        'pictogramas_${sanitizedCategory}_${DateTime.now().millisecondsSinceEpoch}.zip',
      );

      if (mounted) {
        Navigator.of(context).pop(); // Cerrar diálogo de progreso

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
                    success
                        ? 'ZIP descargado: ${provider.pictograms.length} pictogramas'
                        : 'Error al crear el ZIP',
                  ),
                ),
              ],
            ),
            backgroundColor: success ? const Color(0xFF059669) : Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop(); // Cerrar diálogo de progreso

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.text),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          Consumer<PictogramProvider>(
            builder: (context, provider, child) {
              if (provider.pictograms.isNotEmpty && !_isDownloading) {
                return IconButton(
                  icon: const Icon(Icons.download),
                  tooltip: 'Descargar todos',
                  onPressed: _downloadAllPictograms,
                );
              }
              if (_isDownloading) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Consumer<PictogramProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${provider.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => provider.loadPictogramsByCategory(widget.category.id),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          if (provider.pictograms.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_not_supported,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No hay pictogramas en esta categoría',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${provider.pictograms.length} pictogramas encontrados',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width > 1200
                        ? 6
                        : MediaQuery.of(context).size.width > 800
                            ? 4
                            : MediaQuery.of(context).size.width > 600
                                ? 3
                                : 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: provider.pictograms.length,
                  itemBuilder: (context, index) {
                    final pictogram = provider.pictograms[index];
                    return PictogramCard(
                      pictogram: pictogram,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PictogramDetailScreen(
                              pictogram: pictogram,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DownloadProgressDialog extends StatelessWidget {
  final int totalPictograms;
  final String categoryName;

  const _DownloadProgressDialog({
    required this.totalPictograms,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 24),
            const Text(
              'Creando archivo ZIP...',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Categoría: $categoryName',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Descargando $totalPictograms pictogramas',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Por favor espera, esto puede tardar unos momentos',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
