import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'ApiResponse/photo_response.dart';
import 'AppConfigurations/app_configurations.dart';
import 'Models/photo.dart';
import 'Services/PhotoServices/IPhotoService.dart';
import 'Services/PhotoServices/PhotoService.dart';
import 'Services/api_client.dart';

void main() {
  configureInjection();
  runApp(const MainApp());
}

void configureInjection() {
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());
  getIt.registerLazySingleton<PhotoService>(
      () => PhotoService(getIt<ApiClient>()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Piggy Bank",
      home: HomeUI(),
    );
  }
}

class HomeUI extends StatefulWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  final ImagePicker photoSelector = ImagePicker();
  List<XFile> selectedPhotos = [];
  List<Photo> photos = [];

  final IPhotoService _photoService = getIt.get<IPhotoService>();

  @override
  void initState() {
    super.initState();
    getPhotos();
  }

  Future<void> createPhoto(PhotoResponse photoInfo) async {
    try {
      final response = await _photoService.createPhoto(photoInfo);
      if (response.hasError == false) {
        _showDialog(context);
        getPhotos(); // Refresh the photo list after successful upload
      } else {
        print(response.errorMessage);
      }
    } catch (e) {
      print(e);
    }
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("The photo uploaded successfully"),
          actions: <Widget>[
            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> selectFromCamera() async {
    try {
      final photo = await photoSelector.pickImage(source: ImageSource.camera);
      if (photo != null) {
        setState(() {
          selectedPhotos.add(photo);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> selectFromGallery() async {
    try {
      final photos = await photoSelector.pickMultiImage();
      if (photos != null) {
        setState(() {
          selectedPhotos.addAll(photos);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> removePhoto(String photoPath) async {
    setState(() {
      selectedPhotos.removeWhere((element) => element.path == photoPath);
    });
  }

  Future<void> uploadPhotos() async {
    try {
      if (selectedPhotos.isEmpty) {
        print('No photos to upload');
        return;
      }

      for (var file in selectedPhotos) {
        final response = await _photoService.createPhoto(
          PhotoResponse(
            photo: Photo(
              id: 0, // Adjust this if needed
              photoName: file.name,
              photoImage: file.path,
            ),
          ),
        );

        if (response.hasError == true) {
          print('Upload failed: ${response.errorMessage}');
        } else {
          print('Photos uploaded successfully');
          fetchPhotos(); // Refresh the list after upload
        }
      }
    } catch (e) {
      print('Error during upload: $e');
    }
  }

  Future<void> fetchPhotos() async {
    try {
      final response = await _photoService.getPhotos();
      if (response.hasError == false) {
        setState(() {
          photos = response.data ?? [];
        });
      } else {
        print('Failed to fetch photos: ${response.message}');
      }
    } catch (e) {
      print('Error fetching photos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Piggy Bank',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: selectFromCamera,
                    child: const Text('Camera'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: selectFromGallery,
                    child: const Text('Gallery'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: uploadPhotos,
                child: const Text('Upload'),
              ),
              const SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final imageUrl =
                      _photoService.getUploadUrl(photos[index].photoImage);
                  return Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: imageUrl,
                        height: 200,
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () async {
                            await _photoService.deletePhoto(photos[index].id);
                            fetchPhotos(); // Refresh the list after deletion
                          },
                          child: Container(
                            color: const Color.fromARGB(255, 248, 130, 122),
                            width: 20,
                            height: 20,
                            child: const Center(child: Text('x')),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 10);
                },
                itemCount: photos.length,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getPhotos() async {
    try {
      final response = await _photoService.getPhotos();
      if (response.hasError == false) {
        setState(() {
          photos = response.data ?? [];
        });
      } else {
        print('Failed to fetch photos: ${response.message}');
      }
    } catch (e) {
      print('Error fetching photos: $e');
    }
  }
}
