import SwiftUI
import UIKit

// MARK: - First Screen

struct GreetingView: View {
  var body: some View {
    NavigationView {
      ZStack {
        LinearGradient(
          gradient: .init(colors: [.gray, .white]),
          startPoint: .bottom,
          endPoint: .top)

        ContentCard()
      }
    }
  }
}

struct ContentCard: View {
  @State var isHandImageVisible = true
  @State var handImageColor: Color = .blue

  var body: some View {
    HStack(spacing: 10) {
      if isHandImageVisible {
        HandImage(foregroundColor: $handImageColor)
          .transition(
            AnyTransition.scale
              .combined(with: .move(edge: .leading))
              .combined(with: .slide)
          )
      }

      VStack(spacing: 20) {
        TitleView()
        SubtitleView()

        NavigationLink(destination: SecondView(),
                       label: { Text("Move to the Second View") })
          .padding(.bottom, 20)
      }
    }
    .fillHorizontally()
    .background(Color.white)
    .cornerRadius(20)
    .padding()
    .onTapGesture {
      withAnimation {
        self.isHandImageVisible.toggle()
      }

      self.handImageColor = .yellow
    }
  }
}

struct HandImage: View {
  @Binding var foregroundColor: Color

  var body: some View {
    return Image(systemName: "hand.thumbsup.fill")
      .font(.largeTitle)
      .foregroundColor(foregroundColor)
      .onAppear(perform: fetchImage)
  }

  private func fetchImage() { }
}

struct TitleView: View {
  var body: some View {
    Text("Hello Mobiconf!")
      .font(.largeTitle)
      .fontWeight(.bold)
      .padding(.top, 20)
      .foregroundColor(.blue)
  }
}

struct SubtitleView: View {
  var body: some View {
    Text("How u doin'?")
      .font(.title)
      .padding(.bottom, 20)
  }
}

// MARK: - Second Screen

struct SecondView: View {
  let names = ["Jack", "Richard", "James"]

  var body: some View {
    List(names, id: \.self) { name in
      Text(name)
        .foregroundColor(.red)
    }
  }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    GreetingView()
  }
}

// MARK: - Custom View Modifier

extension View {
  func fillHorizontally() -> some View {
    self.modifier(FillHorizontally())
  }
}

struct FillHorizontally: ViewModifier {
  func body(content: Content) -> some View {
    content.frame(minWidth: 0, maxWidth: .infinity)
  }
}
