class ProductRepository {
  Future<List<String>> getDefaultProduct() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return List.generate(10, (index) => 'default : $index');
  }

  Future<List<String>?> getPayProduct(bool haslicense) async {
    if (haslicense) {
      await Future.delayed(const Duration(milliseconds: 500));
      return List.generate(10, (index) => 'pay : $index');
    } else {
      return null;
    }
  }
}
