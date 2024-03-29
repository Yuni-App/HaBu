import SwiftUI

struct CustomActivityIndicator: View {
    @State private var isAnimating = false

    var body: some View {
        VStack{
            Circle()
                .trim(from: 0, to: 0.7) // Dönme kısmının yüzdesi
                .stroke(Color.blue, lineWidth: 5) // Dönme çizgisinin rengi ve kalınlığı
                .frame(width: 50, height: 50) // Dönme çizgisinin boyutu
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0)) // Dönme efekti
                .animation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false)) // Dönme animasyonu
                .onAppear {
                    self.isAnimating = true // Animasyon başlat
                }
        }
            .frame(width: Const.width,height: Const.height)
            .background(Color.gray.opacity(0.2)) // Opak gri arka plan
    }
}

struct CustomActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        CustomActivityIndicator()
    }
}
