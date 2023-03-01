//
//  FakeStocksData.swift
//  StocksTests
//
//  Created by sokolli on 2/28/23.
//

import Foundation

var stock1 = Stock(ticker: "BAC",
                   name: "Bank of America Corporation",
                   currency: Constants.USD,
                   currentPrice: 23.93,
                   quantity: 10,
                   currentPriceTimestamp: .now)

var stock2 = Stock(ticker: "BRKA",
                   name: "Berkshire Hathaway Inc.",
                   currency: Constants.USD,
                   currentPrice: 281000.00,
                   quantity: 1,
                   currentPriceTimestamp: .now)

var stock3 = Stock(ticker: "^DJI",
                   name: "Dow Jones Industrial Average",
                   currency: Constants.USD,
                   currentPrice: 26481.54,
                   quantity: nil,
                   currentPriceTimestamp: .now)

var stock4 = Stock(ticker: "EXPE",
                   name: "Expedia Group Inc",
                   currency: Constants.USD,
                   currentPrice: 81.65,
                   quantity: nil,
                   currentPriceTimestamp: .now)

var stock5 = Stock(ticker: "FIT",
                   name: "Expedia Group Inc",
                   currency: Constants.USD,
                   currentPrice: 6.78,
                   quantity: 2,
                   currentPriceTimestamp: .now)

var stock6 = Stock(ticker: "GRUB",
                   name: "GrubhubInc",
                   currency: Constants.USD,
                   currentPrice: 69.75,
                   quantity: nil,
                   currentPriceTimestamp: .now)

var stock7 = Stock(ticker: "JNJ",
                   name: "Johnson & Johnson",
                   currency: Constants.USD,
                   currentPrice: 147.40,
                   quantity: nil,
                   currentPriceTimestamp: .now)

var stock8 = Stock(ticker: "RUNWAY",
                   name: "Rent The Runaway",
                   currency: Constants.USD,
                   currentPrice: 248.19,
                   quantity: nil,
                   currentPriceTimestamp: .now)

var stock9 = Stock(ticker: "RUN",
                   name: "Run",
                   currency: Constants.USD,
                   currentPrice: 67.20,
                   quantity: 12,
                   currentPriceTimestamp: .now)

var stock10 = Stock(ticker: "RUNINC",
                   name: "Runners Inc",
                   currency: Constants.USD,
                    currentPrice: 36.14,
                   quantity: 5,
                   currentPriceTimestamp: .now)

var stocksData = StocksData(stocks: [stock1, stock2, stock3, stock4, stock5, stock6, stock7, stock8, stock9, stock10])
