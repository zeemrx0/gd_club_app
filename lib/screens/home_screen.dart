import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gd_club_app/providers/events.dart';
import 'package:gd_club_app/widgets/events/event_card.dart';
import 'package:gd_club_app/widgets/events/event_item.dart';
import 'package:gd_club_app/widgets/events/trending_event_list.dart';
import 'package:gd_club_app/widgets/glass_app_bar.dart';
import 'package:gd_club_app/widgets/app_drawer.dart';
import 'package:gd_club_app/widgets/events/event_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Events>(context, listen: false).fetchEvents();
      _isInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("Rebuild");
    var allEvents = Provider.of<Events>(context).allEvents;
    var trendingEvents =
        allEvents.length >= 6 ? allEvents.sublist(0, 5) : allEvents;

    var registeredEvents = Provider.of<Events>(context).registeredEvents;
    if (registeredEvents.length >= 2) {
      registeredEvents = registeredEvents.sublist(0, 1);
    }

    return Scaffold(
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: AppDrawer(),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            GlassAppBar(
              title: const Text(
                'Sắc màu Gia Định',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: Text(
                      'Đã đăng ký',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: Column(
                      children: [
                        ...registeredEvents.map(
                          (event) => Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                            ),
                            child: ChangeNotifierProvider.value(
                              value: event,
                              child: EventItem(
                                isEdit: false,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  // Trending events
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: Text(
                      'Nổi bật',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 248,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ...trendingEvents.map(
                            (event) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                              ),
                              child: ChangeNotifierProvider.value(
                                value: event,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    right: 8,
                                  ),
                                  child: EventCard(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: Text(
                      'Có thể bạn sẽ thích',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: Column(
                      children: [
                        ...allEvents.map(
                          (event) => Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                            ),
                            child: ChangeNotifierProvider.value(
                              value: event,
                              child: EventItem(
                                isEdit: false,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
