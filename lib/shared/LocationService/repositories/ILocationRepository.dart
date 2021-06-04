mixin ILocationRepository<T> {
  Future<T> determinePosition();
}
