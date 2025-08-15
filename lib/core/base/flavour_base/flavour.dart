
abstract class Flavour {
  final String baseUrl;
  Flavour({required this.baseUrl});
}

class FlavourImpl extends Flavour{
  FlavourImpl(): super(baseUrl: "http://localhost:3000/api/v1/");
}