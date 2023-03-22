import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/data/di/config.dart';
import 'package:travel_app/screens/home/bloc/home_bloc.dart';
import 'package:travel_app/screens/home/widgets/destination_item.dart';

class DestinationList extends StatefulWidget {
  const DestinationList({super.key});

  @override
  State<DestinationList> createState() => _DestinationListState();
}

class _DestinationListState extends State<DestinationList> {
  @override
  void initState() {
    super.initState();
    getIt<HomeBloc>().add(FetchDestinationData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.status) {
          case FetchStatus.pending:
            return const Center(
              child: CircularProgressIndicator(
                color: ColorPalette.thirdColor,
              ),
            );
          case FetchStatus.success:
            return MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 2.5.h,
              crossAxisSpacing: 2.5.h,
              itemCount: state.destinations.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) => DestinationItem(
                item: state.destinations[index],
              ),
            );
          case FetchStatus.failure:
            return Center(
              child: Text(
                'No found destination item',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          default:
            return Container();
        }
      },
    );
  }
}
