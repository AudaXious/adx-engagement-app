enum ViewState { idle, loading, error }

extension ViewStateExtension on ViewState {
  bool get isIdle => this == ViewState.idle;
  bool get isLoading => this == ViewState.loading;
  bool get isError => this == ViewState.error;
}