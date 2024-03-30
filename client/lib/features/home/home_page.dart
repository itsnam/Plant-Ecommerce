import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantial/features/home/api/get_plants.dart';
import 'package:plantial/models/product.dart';
import 'package:plantial/features/home/custom_card.dart';
import 'package:plantial/features/home/custom_card_3.dart';
import 'package:plantial/features/search/search_button.dart';
import 'package:plantial/features/styles/styles.dart';
import '../search/pick_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController mainListController = ScrollController();
  List<Product> newProducts = [];
  List<Product> popularProducts = [];

  @override
  initState() {
    super.initState();
  }

  Future<String> fetchData() async {
    newProducts = await getPlants();
    popularProducts = await getPlants(sortBy: 'sold');
    return Future.value("Fetched data successfully");
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              const SliverPadding(padding: EdgeInsets.all(20)),
              SliverAppBar(
                titleSpacing: 20,
                backgroundColor: const Color(0xFFececee),
                title: const Text(
                  'Plantial',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                ),
                pinned: false,
                floating: true,
                snap: false,
                forceElevated: innerBoxIsScrolled,
              ),
              const SliverPadding(padding: EdgeInsets.all(5)),
            ];
          },
          body: FutureBuilder(
            future: fetchData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primary,
                    ),
                  );
                default:
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return ListView(
                      physics: const ScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                          child: Row(children: [
                            const Expanded(child: SearchButton()),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PickImage()));
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Color(0xFFf9f9f9)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(17),
                                    child: Icon(
                                      size: 24,
                                      Iconsax.camera,
                                      color: Colors.black,
                                    ),
                                  ),
                                ))
                          ]),
                        ),
                        const SizedBox(height: 18),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Phổ biến',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 320,
                          child: ListView.builder(
                            padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                            itemCount: popularProducts.length,
                            controller: mainListController,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return CustomCard(
                                product: popularProducts[index],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            children: [
                              const Text(
                                'Mới',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20),
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  onPressed: null,
                                  child: const Icon(Iconsax.arrow_right5,
                                      size: 28, color: unselectedMenuItem))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                          child: GridView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: (1 / 1.35),
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 5,
                                      crossAxisCount: 2),
                              itemCount: newProducts.length,
                              itemBuilder: (_, index) {
                                return CustomCard3(
                                  product: newProducts[index],
                                );
                              }),
                        ),
                      ],
                    );
                  }
              }
            },
          ),
        ),
      ),
    );
  }
}
