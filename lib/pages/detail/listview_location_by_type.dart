import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_vietnam_app/models/location.dart';
import 'package:flutter_vietnam_app/pages/detail/detail_speciality_page.dart';
import 'package:flutter_vietnam_app/utils/locator.dart';
import 'package:flutter_vietnam_app/view_models/listview_location_by_type_notifier.dart';
import 'package:provider/provider.dart';

class ListViewLocationByType extends StatefulWidget {
  const ListViewLocationByType({super.key, required this.filter});
  final String filter;

  @override
  State<ListViewLocationByType> createState() => _ListViewLocationByTypeState();
}

class _ListViewLocationByTypeState extends State<ListViewLocationByType> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListviewLocationByTypeNotifer>(
      create: (BuildContext context) =>
          serviceLocator<ListviewLocationByTypeNotifer>()..init(widget.filter),
      child: Scaffold(
        body: Consumer<ListviewLocationByTypeNotifer>(
          builder: (BuildContext context, ListviewLocationByTypeNotifer vm, _) {
            if (vm.listLocation == null || vm.listLocation!.isEmpty == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Stack(
              children: <Widget>[
                Container(
                  height: 50,
                  padding: const EdgeInsets.only(left: 15),
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_rounded,
                        ),
                      ),
                      const SizedBox(width: 50),
                      Text(
                        widget.filter,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: AnimationLimiter(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: vm.listLocation!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: YourListChild(vm.listLocation![index]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class YourListChild extends StatelessWidget {
  const YourListChild(this.location, {super.key});
  final Location location;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) =>
                DetailSpecialityPage(location: location),
          ),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Stack(
          children: <Widget>[
            Image.network(location.images![0].toString()),
            Container(
              margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
              color: Colors.black.withOpacity(0.7),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                location.name ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
