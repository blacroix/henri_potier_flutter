enum OfferType {
  percentage,
  minus,
  slice,
}

class Offer {
  final OfferType type;
  final int value;
  final int sliceValue;

  Offer(this.type, this.value, this.sliceValue);

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
      OfferType.values
          .firstWhere((ot) => ot.toString() == "OfferType.${json['type']}"),
      json['value'],
      json['sliceValue']);

  @override
  String toString() {
    switch (type) {
      case OfferType.percentage:
        return "$value %";
      case OfferType.minus:
        return "-$value €";
      case OfferType.slice:
        return "$value € every $sliceValue €";
    }
    return "";
  }
}
