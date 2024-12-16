import SwiftUI

struct AddCategoryView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var categories: [CategorySpending]
    
    @State private var categoryName = ""
    @State private var selectedIcon = "creditcard.fill"
    
    // Default rənglər massivi
    private let categoryColors: [Color] = [
        .blue,
        .green,
        .orange,
        .red,
        .purple,
        .pink,
        .yellow,
        .mint,
        .indigo,
        .teal
    ]
    
    private let icons = [
        "creditcard.fill",
        "cart.fill",
        "house.fill",
        "car.fill",
        "fork.knife",
        "gift.fill",
        "medical.thermometer.fill",
        "airplane"
    ]
    
    // Növbəti rəngi seçmək üçün
    private var nextColor: Color {
        let currentCount = categories.count
        return categoryColors[currentCount % categoryColors.count]
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Kateqoriya adı", text: $categoryName)
                } header: {
                    Text("Kateqoriya məlumatları")
                }
                
                Section(header: Text("İkon")) {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))], spacing: 15) {
                        ForEach(icons, id: \.self) { icon in
                            Image(systemName: icon)
                                .font(.title2)
                                .foregroundColor(selectedIcon == icon ? nextColor : .gray) // Seçilmiş ikonun rəngini də göstəririk
                                .padding(10)
                                .background(
                                    Circle()
                                        .fill(selectedIcon == icon ? nextColor.opacity(0.2) : Color.clear)
                                )
                                .onTapGesture {
                                    selectedIcon = icon
                                }
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
            .navigationTitle("Yeni Kateqoriya")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Ləğv et") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Əlavə et") {
                        saveCategory()
                    }
                    .disabled(categoryName.isEmpty)
                }
            }
        }
    }
    
    private func saveCategory() {
        let newCategory = CategorySpending(
            category: CustomSpendingCategory(
                name: categoryName,
                icon: selectedIcon,
                color: nextColor // Növbəti rəngi təyin edirik
            ),
            amount: 0
        )
        
        categories.append(newCategory)
        dismiss()
    }
} 