import 'package:appwrite/appwrite.dart';
import 'package:better_appwrite/better_appwrite.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final client = Client()
    ..setEndpoint('[YOUR APPWRITE ENDPOINT]')
    // ..setSelfSigned() // If you are using self signed
    ..setProject('[YOUR APPWRITE PROJECT]');
  final storage = Storage(client);

  // Optional: Specify a global Appwrite storage service
  AppwritePreviewImageProvider.setDefaultStorage(storage);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppwritePreviewImage Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'AppwritePreviewImage Demo Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: const Center(
        child: Column(
          children: [
            _UseImageProvider(),
            _UseWidget(),
          ],
        ),
      ),
    );
  }
}

Widget _loading(
  BuildContext context,
  Widget child,
  ImageChunkEvent? loadingProgress,
) {
  // Note: Appwrite SDK currently does not support download progress monitoring.
  // DO NOT rely on ImageChunkEvent to display download progress.
  // But you can know whether the image loading is done through the API.
  if (loadingProgress != null) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
  return child;
}

class _UseImageProvider extends StatelessWidget {
  const _UseImageProvider();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Image(
        image: AppwritePreviewImageProvider(
          bucketId: '6525f227ce998a3942bf',
          fileId: '652ce6f7135a54ac8b08',
          width: 100,
          height: 100,
          output: OutputFormat.png,
        ),
        loadingBuilder: _loading,
      ),
    );
  }
}

class _UseWidget extends StatelessWidget {
  const _UseWidget();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: AppwritePreviewImage(
        bucketId: '6525f227ce998a3942bf',
        fileId: '6525f8815ea49f2c3a53',
        previewWidth: 200,
        previewHeight: 200,
        output: OutputFormat.webp,
        loadingBuilder: _loading,
        errorBuilder: (context, error, stackTrace) {
          return AspectRatio(
            aspectRatio: 1,
            child: Container(
              alignment: Alignment.center,
              color: Colors.red,
              child: error is AppwriteException
                  ? Text('appwrite image load failed: ${error.type}')
                  : const Text('Unknown'),
            ),
          );
        },
      ),
    );
  }
}
