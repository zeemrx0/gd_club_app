import 'package:flutter/material.dart';
import 'package:gd_club_app/models/event.dart';
import 'package:gd_club_app/models/organizer.dart';
import 'package:gd_club_app/models/user.dart';
import 'package:gd_club_app/providers/auth.dart';
import 'package:gd_club_app/providers/events.dart';
import 'package:gd_club_app/providers/organizers.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class EventRegistrationInformationScreen extends StatefulWidget {
  static const routeName = '/event-information';

  @override
  State<EventRegistrationInformationScreen> createState() =>
      _EventRegistrationInformationScreenState();
}

class _EventRegistrationInformationScreenState
    extends State<EventRegistrationInformationScreen> {
  final PanelController panelController = PanelController();
  double panelMinHeight = 0.0;
  double panelMaxHeight = 0.0;
  double panelSnapPoint = 0.55;

  bool isInit = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      panelMaxHeight = MediaQuery.of(context).size.height - 132;
      panelMinHeight = 132 +
          (MediaQuery.of(context).size.height - 132 - 132) * panelSnapPoint;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isInit) {
        setState(() {
          panelMinHeight = 132;
          panelController.panelPosition = panelSnapPoint;
          isInit = false;
        });
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final String eventId = ModalRoute.of(context)!.settings.arguments as String;
    final Event event = Provider.of<Events>(context).findEventById(eventId);

    final Organizer organizer = Provider.of<Organizers>(context)
        .findOrganizerById(event.organizer!.id)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.black,
            child: Column(
              children: [
                ClipRRect(
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: event.imageUrls.isNotEmpty
                        ? Image.network(
                            event.imageUrls[0],
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: Colors.black,
                          ),
                  ),
                ),
              ],
            ),
          ),
          SlidingUpPanel(
            controller: panelController,
            snapPoint: panelSnapPoint,
            maxHeight: panelMaxHeight,
            minHeight: panelMinHeight,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            panel: Container(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Image.network(
                                  organizer.avatarUrl ??
                                      'https://img.freepik.com/free-vector/people-putting-puzzle-pieces-together_52683-28610.jpg?w=2000&t=st=1677315161~exp=1677315761~hmac=4a5f3a94713bed9e59bb8217504922d76f449947872c47739f0a1b046b553391',
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              organizer.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          event.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Ionicons.calendar_clear_outline,
                                  color: Colors.pink[400],
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(event.dateTime),
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Ionicons.time_outline,
                                  color: Colors.green[700],
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  DateFormat('HH:mm').format(event.dateTime),
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        const Text(
                          'Mô tả',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          (event.description != null && event.description != '')
                              ? event.description!
                              : '(Không có mô tả)',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Địa điểm',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          event.location,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 160,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text('Tính năng bản đồ đang phát triển'),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        if (event.isRegistered)
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: Colors.purple[400],
                            ),
                            onPressed: () {
                              // Navigator.of(context)
                              //     .pushNamed(EventQRCodeScreen.routeName);
                            },
                            child: const Text(
                              'Check in',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        if (event.isRegistered)
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: Colors.grey[400],
                            ),
                            onPressed: () {
                              Provider.of<Events>(context, listen: false)
                                  .toggleEventRegisteredStatus(event.id!);
                            },
                            child: const Text(
                              'Hủy đăng kí',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        if (!event.isRegistered)
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: Colors.purple[400],
                            ),
                            onPressed: () async {
                              await (Provider.of<Auth>(context, listen: false)
                                      .account as User)
                                  .toggleRegisteredAnEvent(eventId, context);
                            },
                            child: const Text(
                              'Đăng ký ngay',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
