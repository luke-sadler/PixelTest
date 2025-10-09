//
//  DecodingTests.swift
//  PixelTestTests
//
//  Created by luke on 09/10/2025.
//

import XCTest
@testable import PixelTest

@MainActor
class DecodingTests: XCTestCase {
  
  private var rawUserJson: String {
    """
    {
    "items": [
        {
            "badge_counts": {
                "bronze": 845,
                "silver": 929,
                "gold": 185
            },
            "account_id": 3748,
            "is_employee": false,
            "last_modified_date": 1758699601,
            "last_access_date": 1759960111,
            "reputation_change_year": 4146,
            "reputation_change_quarter": 138,
            "reputation_change_month": 138,
            "reputation_change_week": 68,
            "reputation_change_day": 0,
            "reputation": 830766,
            "creation_date": 1220976258,
            "user_type": "registered",
            "user_id": 5445,
            "location": "Guatemala",
            "website_url": "http://codingspot.com",
            "link": "https://stackoverflow.com/users/5445/christian-c-salvad%c3%b3",
            "profile_image": "https://www.gravatar.com/avatar/932fb89b9d4049cec5cba357bf0ae388?s=256&d=identicon&r=PG",
            "display_name": "Christian C. Salvad&#243;"
        }
    ],
    "has_more": true,
    "quota_max": 300,
    "quota_remaining": 283
    }
    """
  }
  
  func test_user_decoding() throws {
    
    @Injected(\.networkingServiceProvider) var networkService: NetworkingService
    
    let jsonDecoder = networkService.jsonDecoder
    
    let response = try jsonDecoder.decode(UserFetchResponse.self, from: rawUserJson.data(using: .utf8)!)
    
    XCTAssertEqual(response.items.count, 1, "Expected exactly 1 user from json")
    
    guard let user = response.items.first else {
      XCTFail("Failed to get user from json")
      return
    }
    
    XCTAssertEqual(user.displayName, "Christian C. Salvad&#243;")
    XCTAssertEqual(user.presentableDisplayName, "Christian C. Salvadó")
    
    XCTAssertEqual(user.creationDate, 1220976258)
    XCTAssertEqual(user.presentableCreationDate, "9 Sep 2008") // This is one to be careful with as it could fail if ran in a different locale or timezone. Machine dependant.
    
    XCTAssertEqual(user.accountId, 3748)
    
    let badges = user.badgeCounts
    
    XCTAssertEqual(badges.gold, 185)
    XCTAssertEqual(badges.silver, 929)
    XCTAssertEqual(badges.bronze, 845)
    
  }
}
