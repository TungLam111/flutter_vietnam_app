import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/models/location.dart';
import 'package:flutter_vietnam_app/pages/detail/detail_speciality_page.dart';
import 'package:flutter_vietnam_app/pages/detail/listview_location_by_type.dart';
import 'package:flutter_vietnam_app/utils/locator.dart';
import 'package:flutter_vietnam_app/view_models/detail_speciality_notifier.dart';
import 'package:provider/provider.dart';

class InfoWidget extends StatefulWidget {
  const InfoWidget({super.key, required this.location});
  final Location location;

  @override
  State<InfoWidget> createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<InfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<DetailSpecialityViewModel>(
        create: (BuildContext context) =>
            serviceLocator<DetailSpecialityViewModel>()
              ..init(widget.location.typeDish),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.location.name ?? '',
                  style: const TextStyle(fontSize: 30),
                ),
                Text(
                  widget.location.origin ?? '',
                  style: const TextStyle(fontSize: 20),
                ),
                Container(
                  height: 150,
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    children: widget.location.images!
                        .map(
                          (String e) => GestureDetector(
                            onTap: () async {
                              await showDialog(
                                context: context,
                                builder: (_) => ImageDialog(imgUrl: e),
                              );
                            },
                            child: Container(
                              width: 120,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'https://media.istockphoto.com/vectors/image-preview-icon-picture-placeholder-for-website-or-uiux-design-vector-id1222357475?k=6&m=1222357475&s=612x612&w=0&h=p8Qv0TLeMRxaES5FNfb09jK3QkJrttINH2ogIBXZg-c=',
                                  ),
                                ),
                              ),
                              child: Image.network(
                                e.toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Text(widget.location.subtitle ?? ''),
                Column(
                  children: widget.location.description!
                      .map((Map<String, dynamic> e) {
                    if (e['type'] == 'text') {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(e['value'].toString()),
                      );
                    } else if (e['type'] == 'image') {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Column(
                          children: <Widget>[
                            Image.network(
                              e['value'].toString(),
                            ),
                            const SizedBox(height: 5),
                            Text(e['title'].toString())
                          ],
                        ),
                      );
                    }
                    return const SizedBox();
                  }).toList(),
                ),
                const Divider(color: Colors.black),
                Wrap(
                  children: widget.location.related!
                      .map(
                        (String e) => GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10, left: 8),
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: colorsList[
                                  widget.location.related!.indexOf(e) % 5],
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              '#$e',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const Divider(color: Colors.black),
                const Text('You might have interest'),
                const Divider(color: Colors.black),
                Consumer<DetailSpecialityViewModel>(
                  builder: (_, DetailSpecialityViewModel vm, Widget? __) =>
                      ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: vm.listDishType.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) =>
                                      ListViewLocationByType(
                                    filter: vm.listDishType[index].typeDish!,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                color: colorsList.last,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.only(
                                      bottom: 10,
                                      top: 10,
                                    ),
                                    child: Text(
                                      vm.listDishType[index].typeDish ?? '',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 25,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 200,
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            child: vm.listDishType[index].listLocation
                                        ?.isNotEmpty ==
                                    true
                                ? ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        (vm.listDishType[index].listLocation ??
                                                <Location>[])
                                            .length,
                                    itemBuilder:
                                        (BuildContext context, int idx) {
                                      return LocationListTile(
                                        vm.listDishType[index]
                                            .listLocation![idx],
                                      );
                                    },
                                  )
                                : const SizedBox(),
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LocationListTile extends StatelessWidget {
  @override
  const LocationListTile(this.location, {Key? key}) : super(key: key);
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
        width: 150,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]!, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: <Widget>[
            Container(
              width: 150,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    location.images![0],
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Text(
                location.name.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ImageDialog extends StatelessWidget {
  const ImageDialog({required this.imgUrl, Key? key}) : super(key: key);
  final String imgUrl;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imgUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

const List<Color> colorsList = <Color>[
  Color(0xff292e32),
  Colors.grey,
  Color(0xff7aa0c4),
  Color(0xff34568f),
  Color(0xff2f425e)
];
