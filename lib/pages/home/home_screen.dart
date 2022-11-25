import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_vietnam_app/models/location.dart';
import 'package:flutter_vietnam_app/common/widgets/preferred_size_appbar.dart';
import 'package:flutter_vietnam_app/common/widgets/scaffold.dart';
import 'package:flutter_vietnam_app/pages/detail/detail_speciality_page.dart';
import 'package:flutter_vietnam_app/utils/logg.dart';
import 'package:flutter_vietnam_app/view_models/home_notifier.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OBCupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: OBThemedNavigationBar(
        middle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const <Widget>[
            Text(
              'I love banana',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 25,
              ),
            )
          ],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
              child: TabBar(
                isScrollable: true,
                controller: _tabController,
                indicatorColor: Colors.grey,
                labelStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                labelColor: Colors.grey,
                tabs: const <Widget>[
                  Tab(
                    child: Text('All', style: TextStyle(fontSize: 13)),
                  ),
                  Tab(
                    child: Text(
                      'Cuisine',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Heritage',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Sightseeing',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Culture',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'History',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Ethnicity',
                      style: TextStyle(fontSize: 13),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: <Widget>[
                    _buildList(context),
                    _buildListCuisine(context),
                    _buildListHeritage(context),
                    _buildListSightseeing(context),
                    _buildListCulture(context),
                    _buildListHistory(context),
                    _buildListEthnicity(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
  ) {
    return Selector<HomePageViewModel, List<Location>?>(
      selector: (BuildContext p0, HomePageViewModel p1) => p1.listLocation,
      builder: (_, List<Location>? data, __) {
        pprint('_buildList');

        if (data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (data.isNotEmpty == true) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MasonryGridView.count(
              shrinkWrap: true,
              primary: false,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 4,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) => PlaceItem(
                index: index,
                location: data[index],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildListHeritage(BuildContext context) {
    return Selector<HomePageViewModel, List<Location>?>(
      selector: (BuildContext p0, HomePageViewModel p1) =>
          p1.listLocationHeritage,
      builder: (BuildContext ctx, List<Location>? data, Widget? _) {
        pprint('_buildListHeritage');

        if (data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (data.isNotEmpty == true) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MasonryGridView.count(
              shrinkWrap: true,
              primary: false,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 4,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) => PlaceItem(
                index: index,
                location: data[index],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildListCuisine(BuildContext context) {
    return Selector<HomePageViewModel, List<Location>?>(
      selector: (BuildContext p0, HomePageViewModel p1) =>
          p1.listLocationCuisine,
      builder: (_, List<Location>? vm, __) {
        pprint('_buildListCuisine');

        if (vm == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (vm.isNotEmpty == true) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MasonryGridView.count(
              shrinkWrap: true,
              primary: false,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 4,
              itemCount: vm.length,
              itemBuilder: (BuildContext context, int index) => PlaceItem(
                index: index,
                location: vm[index],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildListSightseeing(BuildContext context) {
    return Selector<HomePageViewModel, List<Location>?>(
      selector: (BuildContext p0, HomePageViewModel p1) =>
          p1.listLocationSightseeing,
      builder: (__, List<Location>? vm, Widget? _) {
        pprint('_buildListSightseeing');

        if (vm == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (vm.isNotEmpty == true) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MasonryGridView.count(
              shrinkWrap: true,
              primary: false,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 4,
              itemCount: vm.length,
              itemBuilder: (BuildContext context, int index) => PlaceItem(
                index: index,
                location: vm[index],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildListCulture(BuildContext context) {
    return Selector<HomePageViewModel, List<Location>?>(
      selector: (BuildContext p0, HomePageViewModel p1) =>
          p1.listLocationCulture,
      builder: (BuildContext ctx, List<Location>? vm, Widget? _) {
        pprint('_buildListCulture');
        if (vm == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (vm.isNotEmpty == true) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MasonryGridView.count(
              shrinkWrap: true,
              primary: false,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 4,
              itemCount: vm.length,
              itemBuilder: (BuildContext context, int index) => PlaceItem(
                index: index,
                location: vm[index],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildListHistory(BuildContext context) {
    return Selector<HomePageViewModel, List<Location>?>(
      selector: (BuildContext p0, HomePageViewModel p1) =>
          p1.listLocationHistory,
      builder: (BuildContext ctx, List<Location>? vm, Widget? _) {
        pprint('_buildListHistory');

        if (vm == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (vm.isNotEmpty == true) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MasonryGridView.count(
              shrinkWrap: true,
              primary: false,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 4,
              itemCount: vm.length,
              itemBuilder: (BuildContext context, int index) => PlaceItem(
                index: index,
                location: vm[index],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildListEthnicity(BuildContext context) {
    return Selector<HomePageViewModel, List<Location>?>(
      selector: (BuildContext p0, HomePageViewModel p1) =>
          p1.listLocationEthnicity,
      builder: (_, List<Location>? vm, Widget? __) {
        pprint('_buildListEthnicity');

        if (vm == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (vm.isNotEmpty == true) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MasonryGridView.count(
              shrinkWrap: true,
              primary: false,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 4,
              itemCount: vm.length,
              itemBuilder: (BuildContext context, int index) => PlaceItem(
                index: index,
                location: vm[index],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class PlaceItem extends StatelessWidget {
  const PlaceItem({required this.index, required this.location, Key? key})
      : super(key: key);
  final Location location;
  final int index;

  @override
  Widget build(BuildContext context) {
    int random2 = index % 8;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => DetailSpecialityPage(
              location: location,
            ),
          ),
        );
      },
      child: Card(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            height: 150,
                            imageUrl: location.images![0],
                            progressIndicatorBuilder: (
                              BuildContext context,
                              String url,
                              DownloadProgress downloadProgress,
                            ) =>
                                Center(
                              child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                              ),
                            ),
                            errorWidget: (
                              BuildContext context,
                              String url,
                              _,
                            ) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 150,
              color: randomList[random2].withOpacity(0.9),
              width: 100,
            ),
            Container(
              height: 150,
              padding: const EdgeInsets.only(left: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      '${location.name}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<Color> randomList = <Color>[
  Colors.red,
  Colors.yellow,
  Colors.green[900]!,
  Colors.teal,
  Colors.purple,
  Colors.orange,
  Colors.blue,
  Colors.limeAccent
];
