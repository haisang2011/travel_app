import 'package:equatable/equatable.dart';
import 'package:travel_app/utils/common_utils.dart';

enum HotelColumn {
  name('name'),
  address('address'),
  numberReviewers('number_reviewers'),
  price('price'),
  star('star'),
  images('images');

  final String columnName;
  const HotelColumn(this.columnName);
}

class Hotel extends Equatable {
  const Hotel({
    this.name,
    this.address,
    this.numberReviewers,
    this.price,
    this.star,
    this.images,
  });

  static const collectionName = 'hotel';
  final String? name;
  final String? address;
  final int? numberReviewers;
  final int? price;
  final double? star;
  final List<String>? images;

  static Hotel fromJson(Map<String, dynamic> json) {
    return Hotel(
      name: json[HotelColumn.name.columnName],
      address: json[HotelColumn.address.columnName],
      numberReviewers: json[HotelColumn.numberReviewers.columnName],
      price: json[HotelColumn.price.columnName],
      star: json[HotelColumn.star.columnName],
      images: (json[HotelColumn.images.columnName] as List<dynamic>?)
          ?.map((image) => image.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      HotelColumn.name.columnName: name,
      HotelColumn.address.columnName: address,
      HotelColumn.numberReviewers.columnName: numberReviewers,
      HotelColumn.price.columnName: price,
      HotelColumn.star.columnName: star,
      HotelColumn.images.columnName: images,
    };
  }

  static Hotel fromDomain(Hotel domain) {
    return Hotel(
      name: domain.name,
      address: domain.address,
      numberReviewers: domain.numberReviewers,
      price: domain.price,
      star: domain.star,
      images: domain.images,
    );
  }

  Hotel toDomain() {
    return Hotel(
      name: name,
      address: address,
      numberReviewers: numberReviewers,
      price: price,
      star: star,
      images: images,
    );
  }

  @override
  List<Object?> get props => [
        name,
        address,
        numberReviewers,
        price,
        star,
        images,
      ];
}
