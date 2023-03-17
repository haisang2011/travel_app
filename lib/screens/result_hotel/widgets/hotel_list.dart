import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';
import 'package:travel_app/data/di/config.dart';
import 'package:travel_app/screens/detail_hotel/bloc/detail_hotel_bloc.dart';
import 'package:travel_app/screens/result_hotel/bloc/result_hotel_bloc.dart';
import 'package:travel_app/screens/result_hotel/widgets/hotel_card.dart';
import 'package:travel_app/utils/common_utils.dart';
import 'package:travel_app/widgets/bottom_loading_tile.dart';

class HotelList extends StatefulWidget {
  const HotelList({super.key});

  @override
  State<HotelList> createState() => _HotelListState();
}

class _HotelListState extends State<HotelList> {
  final _scrollController = ScrollController();

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll > maxScroll * 0.9;
  }

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    getIt<ResultHotelBloc>().add(ResultHotelFetched());
    super.initState();
  }

  void _onScroll() {
    if (_isBottom) {
      getIt<ResultHotelBloc>().add(ResultHotelFetched());
    }
  }

  Widget _buildListView(BuildContext context, ResultHotelState state) {
    if (state.status == FetchStatus.initial) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state.hotels.isEmpty) {
      return Center(
        child: Text(
          'Not found any matched hotels!',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }
    return ListView.builder(
      itemCount:
          state.hasReachedMax ? state.hotels.length : state.hotels.length + 1,
      padding: EdgeInsets.symmetric(horizontal: Sizes.paddingLgSize),
      controller: _scrollController,
      itemBuilder: (context, index) {
        if (index >= state.hotels.length) return const BottomLoadingTile();
        final hotel = state.hotels[index];
        return HotelCard(
          id: hotel.id!,
          address: hotel.address,
          imageUrl: hotel.images != null && hotel.images!.isNotEmpty
              ? hotel.images![0]
              : null,
          name: hotel.name,
          price: hotel.price,
          numberReviewers: hotel.numberReviewers,
          star: hotel.star,
          distance: (state.currentLocation != null && hotel.location != null)
              ? calculateDistance(state.currentLocation!, hotel.location!)
              : null,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResultHotelBloc, ResultHotelState>(
      listener: (context, state) {
        if (state.status == FetchStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  'Error when fetching hotels!',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorPalette.whiteColor,
                      ),
                ),
              ),
            );
        }
      },
      builder: _buildListView,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }
}
