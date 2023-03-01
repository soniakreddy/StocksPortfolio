//
//  BarChart.swift
//  Stocks
//
//  Created by sokolli on 2/28/23.
//

import Foundation
import SwiftUI
import Charts

struct BarChart: View {
    let stocks: [Stock]
    
    var body: some View {
        Chart {
            ForEach(stocks) { stock in
                BarMark(
                    x: .value("Price", stock.quantity ?? 0),
                    y: .value("Name", stock.ticker)
                )
                .annotation(position: .trailing) {
                    if let quantity = stock.quantity  {
                        Text(String(format: "$%.0f", quantity > 0 ? stock.currentPrice * Double(quantity) : ""))
                            .font(.system(size: Constants.extraSmallFontSize, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
            }
        }.foregroundStyle(Color.brightRedColor)
            .chartXAxisLabel(position: .bottom, alignment: .center) {
                Text(Constants.numberOfSharesText)
                    .foregroundColor(.mustardYellowColor)
                    .fontWeight(.medium)
                    .font(.system(size: Constants.extraSmallFontSize))
            }.background(Color.navyBlueColor)
            .chartYAxis {
                AxisMarks() {
                    let value = $0.as(String.self)!
                    AxisValueLabel {
                        Text("\(value)")
                            .foregroundColor(Color.gray)
                    }
                    AxisGridLine().foregroundStyle(.gray)
                }
            }
            .chartXAxis {
                AxisMarks() {
                    let value = $0.as(Int.self)!
                    AxisValueLabel {
                        Text("\(value)")
                            .foregroundColor(Color.gray)
                    }
                    AxisGridLine().foregroundStyle(.gray)
                }
            }
    }
}
