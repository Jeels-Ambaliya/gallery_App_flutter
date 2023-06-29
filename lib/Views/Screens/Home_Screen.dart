import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gallery_app/Controller/Helper/api_Helper.dart';
import 'package:gallery_app/Controller/Provider/theme_Provider.dart';
import 'package:gallery_app/Modal/Global/Global.dart';
import 'package:gallery_app/Modal/api_Modal.dart';
import 'package:provider/provider.dart';

import '../../Controller/Provider/category_Provider.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  late Future Data;

  @override
  void initState() {
    super.initState();

    Data = Api_Helper.api_helper.getImage(category: "popular");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          (Provider.of<ThemeProvider>(context).themeModal.isDark == false)
              ? Colors.white
              : Colors.black,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                      "https://www.metoffice.gov.uk/binaries/content/gallery/metofficegovuk/hero-images/advice/maps-satellite-images/satellite-image-of-globe.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 60,
                  left: 15,
                  right: 15,
                  bottom: 15,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Hello Jeels",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Provider.of<ThemeProvider>(context, listen: false)
                                .changeTheme();
                          },
                          child: Icon(
                            (Provider.of<ThemeProvider>(context)
                                        .themeModal
                                        .isDark ==
                                    false)
                                ? Icons.sunny
                                : Icons.wb_sunny_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: TextFormField(
                        onChanged: (val) async {
                          setState(() {
                            Data =
                                Api_Helper.api_helper.getImage(category: val);
                          });
                        },
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: "Search Here..",
                          hintStyle: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 20,
                          ),
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: (Provider.of<ThemeProvider>(context)
                                        .themeModal
                                        .isDark ==
                                    false)
                                ? Colors.black
                                : Colors.white,
                            size: 30,
                          ),
                          filled: true,
                          fillColor: (Provider.of<ThemeProvider>(context)
                                      .themeModal
                                      .isDark ==
                                  false)
                              ? Colors.grey.shade50
                              : Colors.black,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: (Provider.of<ThemeProvider>(context)
                                          .themeModal
                                          .isDark ==
                                      false)
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: Globals.map(
                  (e) => Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                        left: 16,
                        bottom: 10,
                      ),
                      child: Consumer<CategoryProvider>(
                          builder: (context, categoryProvider, _) {
                        return GestureDetector(
                          onTap: () {
                            int cat = Globals.indexOf(e);
                            categoryProvider.changeCategory(i: cat);
                            setState(() {
                              Data =
                                  Api_Helper.api_helper.getImage(category: e);
                            });
                          },
                          child: Container(
                            height: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: (Provider.of<ThemeProvider>(context)
                                            .themeModal
                                            .isDark ==
                                        false)
                                    ? Colors.black
                                    : Colors.white,
                                width: 1.2,
                              ),
                              color: (categoryProvider.Index.Index ==
                                      Globals.indexOf(e))
                                  ? (Provider.of<ThemeProvider>(context)
                                              .themeModal
                                              .isDark ==
                                          false)
                                      ? Colors.grey.shade400
                                      : Colors.white
                                  : (Provider.of<ThemeProvider>(context)
                                              .themeModal
                                              .isDark ==
                                          false)
                                      ? Colors.white
                                      : Colors.grey.shade400,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade500,
                                  offset: const Offset(2, 3),
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                )
                              ],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Center(
                                child: Text(
                                  e,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  }),
                ).toList(),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: FutureBuilder(
              future: Data,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error Ouccured:${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  List<ApiModal> allData = snapshot.data;
                  return MasonryGridView.count(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(8),
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    itemCount: allData.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            'View_Screen',
                            arguments: allData[index].Image,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: (Provider.of<ThemeProvider>(context)
                                          .themeModal
                                          .isDark ==
                                      false)
                                  ? Colors.black
                                  : Colors.white,
                              width: 1.2,
                            ),
                            borderRadius: BorderRadius.circular(6),
                            image: DecorationImage(
                              image: NetworkImage(allData[index].Image),
                              opacity: 0.9,
                              colorFilter:
                                  const ColorFilter.srgbToLinearGamma(),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Image(
                            image: NetworkImage(allData[index].Image),
                            fit: BoxFit.fitHeight,
                            color: Colors.white.withOpacity(0.0),
                            colorBlendMode: BlendMode.modulate,
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                    strokeWidth: 2,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
