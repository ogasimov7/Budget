import SwiftUI

struct CircularChart: View {
    let categories: [CategorySpending]
    
    var body: some View {
        Canvas { context, size in
            let total = categories.reduce(0) { $0 + $1.amount }
            let center = CGPoint(x: size.width/2, y: size.height/2)
            let radius = min(size.width, size.height) * 0.4
            
            var startAngle = Angle.degrees(-90)
            
            for category in categories {
                let angle = Angle.degrees(360 * (category.amount / total))
                let endAngle = startAngle + angle
                
                let path = Path { p in
                    p.move(to: center)
                    p.addArc(center: center,
                            radius: radius,
                            startAngle: startAngle,
                            endAngle: endAngle,
                            clockwise: false)
                    p.closeSubpath()
                }
                
                context.fill(path, with: .color(category.category.color))
                
                let midAngle = startAngle + (angle / 2)
                let labelRadius = radius * 1.3
                let x = center.x + cos(midAngle.radians) * labelRadius
                let y = center.y + sin(midAngle.radians) * labelRadius
                
                let percentage = Int(category.percentage)
                let text = Text("\(percentage)%")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                context.draw(text, at: CGPoint(x: x, y: y))
                
                startAngle = endAngle
            }
        }
    }
}

#Preview {
    CircularChart(categories: [])
        .frame(height: 300)
} 