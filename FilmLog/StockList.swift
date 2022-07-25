//
//  StockList.swift
//  FilmLog
//
//  Created by Aroon Narayanan on 12/25/21.
//

import SwiftUI

struct StockList: View {
    var viewMode: StockListViewMode
    @Environment(\.dismiss) var dismiss
    @State private var showingAddStockSheet = false
    
    var body: some View {
        NavigationView {
            List(CommonStocks) {
                StockListRow(stock: $0)
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button(action: addStock) {
                        Label("Add Stock", systemImage: "plus")
                    }
                }
            }
            .navigationTitle(Text("Film Stocks"))
            .sheet(isPresented: $showingAddStockSheet) {
                AddStock()
            }
        }
    }
    
    private func addStock() {
        showingAddStockSheet.toggle()
    }
}

struct StockListRow: View {
    var stock: FilmStock
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(stock.manufacturer).font(.caption)
                Text(stock.stockName)
            }
            Spacer()
            Text(verbatim: "ISO \(stock.ISO)")
            Circle().fill(ColorIndicator()).frame(width: 20, height: 20)
        }
    }
    
    func ColorIndicator() -> AngularGradient{
        if (stock.stockType == .ColorNegative || stock.stockType == .ColorReversal) {
            return AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
        }
        return AngularGradient(gradient: Gradient(colors: [.gray]), center: .center)
    }
}

struct StockList_Previews: PreviewProvider {
    static var previews: some View {
        StockList(viewMode: .ViewOnly)
    }
}
