
import SwiftUI

struct imageFrames: View {
    @State var viewState: CGFloat = 0
    @State var viewStateY: CGFloat = 0
    @State var showDeleteButton: Bool = false
    @State var shadowColor: Color = .black
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height
    @State private var widthOfLine: CGFloat = 0
    
    var body: some View {
        VStack {
            Text("ViewState: \(viewState)")
            Text("ABS ViewState: \(abs(viewState))")

            ZStack(alignment: .center) { // Центрируем элементы относительно друг друга
                GeometryReader { geometry in
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 50) // Ограничиваем высоту
                        .onAppear {
                            widthOfLine = geometry.size.width
                        }
                }
                .frame(height: 50) // Гарантируем, что высота фиксирована
                .offset(x: viewState, y: viewStateY)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let sensivity = 0.2
                            viewState = value.translation.width * sensivity
                            checkRegion(viewState, viewStateY)

                            showDeleteButton = viewState < 0
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                viewState = .zero
                                shadowColor = .black
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    withAnimation(.spring()) {
                                        showDeleteButton = false
                                    }
                                }
                            }
                        }
                )

                if showDeleteButton {
                    DeleteButton(
                        viewState: $viewState,
                        xSize: max(50, abs(viewState / 2)), // Размер кнопки увеличивается
                        ySize: 50 // Фиксированная высота кнопки
                    )
                    .opacity(showDeleteButton ? 1 : 0)
                    .animation(.easeInOut(duration: 0.2), value: showDeleteButton)
                    .offset(
                        x: viewState + widthOfLine / 2, // Привязка к правому краю линии
                        y: 0 // Выравнивание по центру относительно серой линии
                    )
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
#Preview {
    imageFrames()
}
