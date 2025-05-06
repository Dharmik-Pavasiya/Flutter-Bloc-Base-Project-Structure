abstract class Either<L, R> {
  const Either();

  // Factory constructors with named parameters
  factory Either.left({required L value}) = Left<L, R>;

  factory Either.right({required R value}) = Right<L, R>;

  // Pattern matching with named parameters
  T fold<T>({
    required T Function(L) ifLeft,
    required T Function(R) ifRight,
    void Function()? whenDone,
  }) {
    final result = isLeft() ? ifLeft(getLeft() as L) : ifRight(getRight() as R);

    whenDone?.call();
    return result;
  }

  // Alternative fold with whenDone as positional callback
  T foldWithDone<T>(
    T Function(L) onLeft,
    T Function(R) onRight,
    void Function() whenDone,
  ) {
    final result = fold(ifLeft: onLeft, ifRight: onRight);
    whenDone();
    return result;
  }

  // Helper methods
  bool isLeft() => fold(ifLeft: (_) => true, ifRight: (_) => false);

  bool isRight() => fold(ifLeft: (_) => false, ifRight: (_) => true);

  L? getLeft() => fold(ifLeft: (l) => l, ifRight: (_) => null);

  R? getRight() => fold(ifLeft: (_) => null, ifRight: (r) => r);

  // Transformations with named parameters
  Either<L, R2> map<R2>({required R2 Function(R) f}) => fold(
    ifLeft: (left) => Left(value: left),
    ifRight: (right) => Right(value: f(right)),
  );

  Either<L2, R> mapLeft<L2>({required L2 Function(L) f}) => fold(
    ifLeft: (left) => Left(value: f(left)),
    ifRight: (right) => Right(value: right),
  );

  Either<L, R2> flatMap<R2>({required Either<L, R2> Function(R) f}) =>
      fold(ifLeft: (left) => Left(value: left), ifRight: (right) => f(right));

  // Convert to nullable
  R? toNullable() => fold(ifLeft: (_) => null, ifRight: (r) => r);

  // Standalone whenDone operator
  Either<L, R> whenDone(void Function() callback) {
    fold(ifLeft: (_) => callback(), ifRight: (_) => callback());
    return this;
  }
}

class Left<L, R> extends Either<L, R> {
  final L value;

  const Left({required this.value});

  @override
  T fold<T>({
    required T Function(L) ifLeft,
    required T Function(R) ifRight,
    void Function()? whenDone,
  }) {
    final result = ifLeft(value);
    whenDone?.call();
    return result;
  }
}

class Right<L, R> extends Either<L, R> {
  final R value;

  const Right({required this.value});

  @override
  T fold<T>({
    required T Function(L) ifLeft,
    required T Function(R) ifRight,
    void Function()? whenDone,
  }) {
    final result = ifRight(value);
    whenDone?.call();
    return result;
  }
}
