// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class LatestEuroQuery: GraphQLQuery {
  public static let operationName: String = "LatestEuro"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query LatestEuro { latest { __typename date baseCurrency quoteCurrency quote } }"#
    ))

  public init() {}

  public struct Data: SwopAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { SwopAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("latest", [Latest].self),
    ] }

    /// Returns the latest rates
    public var latest: [Latest] { __data["latest"] }

    /// Latest
    ///
    /// Parent Type: `Rate`
    public struct Latest: SwopAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { SwopAPI.Objects.Rate }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("date", SwopAPI.Date.self),
        .field("baseCurrency", String.self),
        .field("quoteCurrency", String.self),
        .field("quote", SwopAPI.BigDecimal.self),
      ] }

      public var date: SwopAPI.Date { __data["date"] }
      public var baseCurrency: String { __data["baseCurrency"] }
      public var quoteCurrency: String { __data["quoteCurrency"] }
      public var quote: SwopAPI.BigDecimal { __data["quote"] }
    }
  }
}
