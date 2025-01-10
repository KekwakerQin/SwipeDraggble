import SwiftUICore
import SwiftUI

struct DeleteButton : View {
    @State var offset: CGSize = .zero
    @Binding var viewState: CGFloat
    @State var xSize: CGFloat = 0
    @State var ySize: CGFloat = 0
    @State private var position: CGPoint = .zero
    @State var spaceOfCenter: CGFloat = 0
    
    
    var body: some View {
        
        ZStack {
            Button(action: {
                print("Delete button was tapped")
            }) {
                Image(systemName: "trash")
                    .font(.system(size: 50 / 2))
                    .foregroundColor(.gray)
                    .frame(width: abs(viewState) * 2, // Динамическая ширина
                        height: 50)
                    .background(Color.black)
                    .offset(x: offset.width / 2, y: offset.height)
            }
        }
    }
}

func checkRegion(_ x: CGFloat, _ y: CGFloat){
    
}

#Preview {
}
