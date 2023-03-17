import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:travel_app/utils/common_utils.dart';

enum HotelField {
  id('id'),
  name('name'),
  address('address'),
  numberReviewers('number_reviewers'),
  price('price'),
  star('star'),
  images('images');

  final String value;
  const HotelField(this.value);
}

class Hotel extends Equatable {
  Hotel({
    this.id,
    this.name,
    this.address,
    this.numberReviewers,
    this.price,
    this.star,
    this.images,
    this.location,
  });

  static const collectionName = 'hotel';
  final String? id;
  final String? name;
  final String? address;
  final int? numberReviewers;
  final int? price;
  final double? star;
  final List<String>? images;
  final Location? location;

  static Hotel fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json[HotelField.id.value],
      name: json[HotelField.name.value],
      address: json[HotelField.address.value],
      numberReviewers: json[HotelField.numberReviewers.value],
      price: json[HotelField.price.value],
      star: json[HotelField.star.value].toDouble(),
      images: (json[HotelField.images.value] as List<dynamic>?)
          ?.map((image) => image.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      HotelField.id.value: id,
      HotelField.name.value: name,
      HotelField.address.value: address,
      HotelField.numberReviewers.value: numberReviewers,
      HotelField.price.value: price,
      HotelField.star.value: star,
      HotelField.images.value: images,
    };
  }

  static Hotel fromDomain(Hotel domain) {
    return Hotel(
      id: domain.id,
      name: domain.name,
      address: domain.address,
      numberReviewers: domain.numberReviewers,
      price: domain.price,
      star: domain.star,
      images: domain.images,
      location: domain.location,
    );
  }

  Hotel toDomain() {
    return Hotel(
      id: id,
      name: name,
      address: address,
      numberReviewers: numberReviewers,
      price: price,
      star: star,
      images: images,
      location: location,
    );
  }

  Hotel copyWith({
    String? id,
    String? name,
    String? address,
    int? numberReviewers,
    int? price,
    double? star,
    List<String>? images,
    Location? location,
  }) {
    return Hotel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      numberReviewers: numberReviewers ?? this.numberReviewers,
      price: price ?? this.price,
      star: star ?? this.star,
      images: images ?? this.images,
      location: location ?? this.location,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        numberReviewers,
        price,
        star,
        images,
        location,
      ];
}
