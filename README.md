# StackOverflow Users

### Overview
For this test, I have used the following:

- Dependency Injection
- Swift
- SwiftUI
- XCTests

For the sake of speed, I opted to use SwiftUI as it is what I am have been using for the past ~4 years. I could have equally completed this task in UIKit as I do have experience here.

---
### Account following

As per the spec, account following is carried out locally as a mocked service. 
To achieve this, in [`AccountManagementServiceMock.swift`](PixelTest/Services/Account%20management/AccountManagementServiceMock.swift) I have incorperated a simple `UserDefaults` list of user ids. 
Following and unfollowing simply modifies that stored array of integers. 

The mock service is set by default at the DI level in [InjectedValues.swift](PixelTest/DI/InjectedValues.swift#L57)

---
### User display

When displaying user data in the table row, I opted to show the basics of profile image, creation date, and their badges.  

The gotchya here was that it turns out that StackOverflow returns this name html formatted. To display this correctly on the front end, it needs converting to an attributed string and have that displayed. As seen in [User.swift](PixelTest/Models/User.swift#L41), this is done conditionally for performance improvements.

--- 
### Unit tests

TODO