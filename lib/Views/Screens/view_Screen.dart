import 'package:flutter/material.dart';

class View_Screen extends StatefulWidget {
  const View_Screen({Key? key}) : super(key: key);

  @override
  State<View_Screen> createState() => _View_ScreenState();
}

class _View_ScreenState extends State<View_Screen> {
  // _save() async {
  //   var status = await Permission.storage.request();
  //   if (status.isGranted) {
  //     var response = await Dio().get(
  //         "https://www.metoffice.gov.uk/binaries/content/gallery/metofficegovuk/hero-images/advice/maps-satellite-images/satellite-image-of-globe.jpg",
  //         options: Options(responseType: ResponseType.bytes));
  //     final result = await ImageGallerySaver.saveImage(
  //         Uint8List.fromList(response.data),
  //         quality: 60,
  //         name: "hello");
  //     print(result);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    String Image = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(Image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 50,
              left: 16,
            ),
            child: Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white.withOpacity(0.5),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: Container(
      //   height: 50,
      //   width: 50,
      //   alignment: Alignment.center,
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(15),
      //     color: Colors.blue.shade700,
      //   ),
      //   child: GestureDetector(
      //     onTap: () {
      //       _save();
      //     },
      //     child: const Icon(
      //       Icons.download,
      //       color: Colors.white,
      //       size: 30,
      //     ),
      //   ),
      // ),
    );
  }
}
