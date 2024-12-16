import SwiftUI

struct DoughnutChart: View {
    let categories: [CategorySpending]
    let lineWidth: CGFloat = 40
    
    private var total: Double {
        categories.reduce(0) { $0 + $1.amount }
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                let radius = min(geometry.size.width, geometry.size.height) / 2
                let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                
                // Boş qrafik (boz rəngdə)
                Path { path in
                    path.addArc(
                        center: center,
                        radius: radius - lineWidth/2,
                        startAngle: Angle(degrees: -90),
                        endAngle: Angle(degrees: 270),
                        clockwise: false
                    )
                }
                .stroke(Color.gray.opacity(0.2), lineWidth: lineWidth)
                
                // Kateqoriyaların xərcləri
                if total > 0 {
                    ForEach(categories.indices, id: \.self) { index in
                        let category = categories[index]
                        let percentage = category.calculatePercentage(of: total)
                        let startAngle = self.startAngle(at: index)
                        let endAngle = self.endAngle(at: index)
                        
                        Path { path in
                            path.addArc(
                                center: center,
                                radius: radius - lineWidth/2,
                                startAngle: Angle(degrees: startAngle),
                                endAngle: Angle(degrees: endAngle),
                                clockwise: false
                            )
                        }
                        .stroke(category.category.color, lineWidth: lineWidth)
                        
                        // Faiz göstəricisi
                        if percentage >= 5 { // 5%-dən böyük olanlar
                            let angle = (startAngle + endAngle) / 2
                            let xOffset = cos(angle * .pi / 180) * (radius - lineWidth/2)
                            let yOffset = sin(angle * .pi / 180) * (radius - lineWidth/2)
                            
                            Text("\(Int(percentage))%")
                                .font(.system(size: 13, weight: .medium, design: .default))
                                .foregroundColor(.gray)
                                .background(Color(.systemBackground))
                                .offset(x: xOffset, y: yOffset)
                        }
                    }
                }
            }
            
            // Mərkəzdəki məlumat
            VStack(spacing: 4) {
                Text("Ümumi xərc")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
                Text("$\(total, specifier: "%.2f")")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .padding()
    }
    
    private func startAngle(at index: Int) -> Double {
        let proportions = categories.prefix(index).map { $0.calculatePercentage(of: total) / 100 }
        let sumOfProportions = proportions.reduce(0, +)
        return sumOfProportions * 360 - 90
    }
    
    private func endAngle(at index: Int) -> Double {
        let proportions = categories.prefix(index + 1).map { $0.calculatePercentage(of: total) / 100 }
        let sumOfProportions = proportions.reduce(0, +)
        return sumOfProportions * 360 - 90
    }
} 