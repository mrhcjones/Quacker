import 'package:flutter/material.dart';
import 'package:quacker/constants.dart';
import 'package:quacker/generated/l10n.dart';
import 'package:quacker/home/home_screen.dart';
import 'package:quacker/subscriptions/_groups.dart';
import 'package:quacker/subscriptions/_import.dart';
import 'package:quacker/subscriptions/_list.dart';
import 'package:quacker/subscriptions/users_model.dart';
import 'package:provider/provider.dart';

class SubscriptionsScreen extends StatelessWidget {
  final ScrollController scrollController;

  const SubscriptionsScreen({Key? key, required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.current.subscriptions),
        actions: [
          IconButton(
            icon: const Icon(Icons.cloud_download),
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) => const SubscriptionImportScreen(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<SubscriptionsModel>().refreshSubscriptionData(),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'name',
                child: Text(L10n.of(context).name),
              ),
              PopupMenuItem(
                value: 'screen_name',
                child: Text(L10n.of(context).username),
              ),
              PopupMenuItem(
                value: 'created_at',
                child: Text(L10n.of(context).date_subscribed),
              ),
            ],
            onSelected: (value) => context.read<SubscriptionsModel>().changeOrderSubscriptionsBy(value),
          ),
          IconButton(
            icon: const Icon(Icons.sort_by_alpha),
            onPressed: () => context.read<SubscriptionsModel>().toggleOrderSubscriptionsAscending(),
          ),
          ...createCommonAppBarActions(context)
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SubscriptionGroups(
            scrollController: scrollController,
          ),
          SubscriptionUsers()
        ],
      ),
    );
  }
}
