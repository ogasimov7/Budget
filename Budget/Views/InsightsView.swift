import SwiftUI

struct InsightsView: View {
    @ObservedObject var categoryVM: CategoryViewModel
    @State private var showingAddCategory = false
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    // Doughnut Chart kartı - kənardan-kənara
                    VStack(spacing: 20) {
                        DoughnutChart(categories: categoryVM.categories)
                            .frame(height: 250)
                            .padding(.top, 8)
                        
                        // Kateqoriya statistikası
                        HStack(spacing: 24) {
                            VStack(spacing: 4) {
                                Text("\(categoryVM.categories.count)")
                                    .font(.system(size: 24, weight: .bold, design: .rounded))
                                Text("Kateqoriya")
                                    .font(.system(size: 13, weight: .medium, design: .rounded))
                                    .foregroundColor(.secondary)
                            }
                            
                            Divider()
                                .frame(height: 40)
                            
                            VStack(spacing: 4) {
                                Text("$\(categoryVM.totalSpending, specifier: "%.2f")")
                                    .font(.system(size: 24, weight: .bold, design: .rounded))
                                Text("Ümumi xərc")
                                    .font(.system(size: 13, weight: .medium, design: .rounded))
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 20)
                    
                    // Kateqoriyalar bölməsi
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Xərc Kateqoriyaları")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .padding(.horizontal)
                        
                        LazyVGrid(
                            columns: [
                                GridItem(.flexible(), spacing: 16),
                                GridItem(.flexible(), spacing: 16)
                            ],
                            spacing: 16
                        ) {
                            // Yeni kateqoriya düyməsi
                            Button(action: { showingAddCategory = true }) {
                                VStack(spacing: 16) {
                                    ZStack {
                                        Circle()
                                            .fill(Color.blue.opacity(0.1))
                                            .frame(width: 56, height: 56)
                                        Image(systemName: "plus")
                                            .font(.system(size: 24, weight: .medium))
                                            .foregroundColor(.blue)
                                    }
                                    
                                    Text("Yeni kateqoriya")
                                        .font(.system(size: 15, weight: .medium, design: .rounded))
                                        .foregroundColor(.blue)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .background(Color(.systemBackground))
                                .cornerRadius(20)
                                .shadow(color: Color.black.opacity(0.05), radius: 8)
                            }
                            
                            // Kateqoriya kartları
                            ForEach(categoryVM.categories) { category in
                                CategoryCard(
                                    spending: category,
                                    totalSpending: categoryVM.totalSpending
                                )
                                .shadow(color: Color.black.opacity(0.05), radius: 8)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Kateqoriya")
            .navigationBarTitleDisplayMode(.large)
            .background(Color(.systemGroupedBackground))
        }
        .sheet(isPresented: $showingAddCategory) {
            AddCategoryView(categories: $categoryVM.categories)
        }
    }
}

// CategoryViewModel-ə əlavə
extension CategoryViewModel {
    var totalSpending: Double {
        categories.reduce(0) { $0 + $1.amount }
    }
}

#Preview {
    InsightsView(categoryVM: CategoryViewModel())
} 