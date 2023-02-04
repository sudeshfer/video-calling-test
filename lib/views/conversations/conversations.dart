import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_calling/providers/notification_provider.dart';
import 'package:video_calling/views/conversations/widgets/header_widget.dart';

import 'widgets/conversation_card.dart';

class Conversations extends StatefulWidget {
  const Conversations({super.key});

  @override
  State<Conversations> createState() => _ConversationsState();
}

class _ConversationsState extends State<Conversations> {
  @override
  void initState() {
    //----get and update device token
    Provider.of<NotificationProvider>(context, listen: false).initNotifications(context);

    //---handling foreground notifications
    Provider.of<NotificationProvider>(context, listen: false).foregroundHandler();

    //---handling when clicked on notifications to open the app from background
    Provider.of<NotificationProvider>(context, listen: false).onClickedOpenedApp(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const HeaderWidget(),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return const ConversationCard();
                },
                separatorBuilder: (context, index) => const SizedBox(height: 20),
                itemCount: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
