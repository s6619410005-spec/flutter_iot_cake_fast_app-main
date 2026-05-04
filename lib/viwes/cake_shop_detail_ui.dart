import 'package:flutter/material.dart';
import 'package:flutter_iot_cake_fast_app/models/cake_shop.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class CakeShopDetailUi extends StatefulWidget {
  //สร้างตัวแปรรับข้อมูลส่งมาจากหน้า CakeShopListUi
  CakeShop? cakeShopDetail;

  //เอาตัวแปร
  CakeShopDetailUi({super.key, this.cakeShopDetail});

  @override
  State<CakeShopDetailUi> createState() => _CakeShopDetailUiState();
}

class _CakeShopDetailUiState extends State<CakeShopDetailUi> {
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  MapController? mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 166, 255, 160),
        title: Text(
          widget.cakeShopDetail!.name!,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(45),
        child: Center(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  //'assets/images/' + widget.cakeShopDetail!.image1!,
                  'assets/images/${widget.cakeShopDetail!.image1!}',
                  width: 150,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      //'assets/images/' + widget.cakeShopDetail!.image2!,
                      'assets/images/${widget.cakeShopDetail!.image2!}',
                      width: 150,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      //'assets/images/' + widget.cakeShopDetail!.image3!,
                      'assets/images/${widget.cakeShopDetail!.image2!}',
                      width: 150,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(FontAwesomeIcons.shop),
                        title: Text(
                          widget.cakeShopDetail!.name!,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Icon(FontAwesomeIcons.map),
                        title: Text(
                          widget.cakeShopDetail!.address!,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        onTap: () {
                          _makePhoneCall(widget.cakeShopDetail!.phone!);
                        },
                        leading: Icon(FontAwesomeIcons.phone),
                        iconColor: Color.fromARGB(255, 0, 164, 33),
                        title: Text(
                          widget.cakeShopDetail!.phone!,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        onTap: () {
                          _launchInBrowser(
                              Uri.parse(widget.cakeShopDetail!.website!));
                        },
                        leading: Icon(FontAwesomeIcons.globe),
                        iconColor: Color.fromARGB(255, 0, 89, 255),
                        title: Text(
                          widget.cakeShopDetail!.website!,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        onTap: () {
                          _launchInBrowser(
                              Uri.parse(widget.cakeShopDetail!.facebook!));
                        },
                        leading: Icon(FontAwesomeIcons.facebook),
                        iconColor: Color.fromARGB(255, 0, 145, 255),
                        title: Text(
                          widget.cakeShopDetail!.facebook!,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: FlutterMap(
                  mapController: MapController(),
                  options: MapOptions(
                    initialCenter: LatLng(
                      double.parse(widget.cakeShopDetail!.latitude!),
                      double.parse(widget.cakeShopDetail!.longitude!),
                    ),
                    initialZoom: 15.0,
                  ),
                  //วาดแผนที่
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    RichAttributionWidget(
                      attributions: [
                        TextSourceAttribution(
                          'OpenStreetMap contributors',
                          onTap: () => _launchInBrowser(
                            Uri.parse(
                                'https://www.openstreetmap.org/copyright'),
                          ),
                        ),
                      ],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                            point: LatLng(
                              double.parse(widget.cakeShopDetail!.latitude!),
                              double.parse(widget.cakeShopDetail!.longitude!),
                            ),
                            child: InkWell(
                              onTap: () {
                                String googleMapUrl =
                                    'https://www.google.com/maps/search/?api=1&query=${widget.cakeShopDetail!.latitude},${widget.cakeShopDetail!.longitude}';
                                _launchInBrowser(Uri.parse(googleMapUrl));
                              },
                              child: Icon(
                                FontAwesomeIcons.mapMarkerAlt,
                                color: Colors.red,
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
