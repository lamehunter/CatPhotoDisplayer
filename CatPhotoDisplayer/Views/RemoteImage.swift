import SwiftUI

struct RemoteImage: View {
  private enum LoadState {
    case isLoading, success, failure
  }
  
  private class Loader: ObservableObject {
    var data = Data()
    var state = LoadState.isLoading
    
    init(url: String) {
      if let parsedURL = URL(string: url)  {
        URLSession.shared.dataTask(with: parsedURL) { data, response, error in
          if let data = data, data.count > 0 {
            self.data = data
            self.state = .success
          } else {
            self.state = .failure
          }
          DispatchQueue.main.async {
            self.objectWillChange.send()
          }
        }
        .resume()
      }
      else {
        state = .failure
      }
    }
  }
  
  @StateObject private var loader: Loader
  var loading: Image
  var failure: Image
  
  var body: some View {
    selectImage()
      .resizable()
  }
  
  init(url: String,
       loading: Image = Image(systemName: "photo"),
       failure: Image = Image(systemName: "multiply.circle")) {
    _loader = StateObject(wrappedValue: Loader(url: url))
    self.loading = loading
    self.failure = failure
  }
  
  private func selectImage() -> Image {
    switch loader.state {
    case .isLoading:
      return loading
    case .failure:
      return failure
    default:
      if let image = UIImage(data: loader.data) {
        return Image(uiImage: image)
      } else {
        return failure
      }
    }
  }
}
