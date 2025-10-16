# StackOverflow Users

### Overview
For this test, I have used the following:

- Dependency Injection
- Swift
- UIKit
- XCTests

---
### Account following

As per the spec, account following is carried out locally as a mocked service. 
To achieve this, in [AccountManagementServiceMock.swift](PixelTestUIKit/PixelTestUIKit/Services/Account%20management/AccountManagementServiceMock.swift) I have incorperated a simple `UserDefaults` list of user ids. 
Following and unfollowing simply modifies that stored array of integers. 

The mock service is set by default at the DI level in [InjectedValues.swift](PixelTestUIKit/PixelTestUIKit/DI/InjectedValues.swift#L58)

---
### User display

When displaying user data in the table row, I opted to show the basics of profile image, creation date, and their badges.  

The gotchya here was that it turns out that StackOverflow returns this name html formatted. To display this correctly on the front end, it needs converting to an attributed string and have that displayed. As seen in [User.swift](PixelTestUIKit/PixelTestUIKit/Models/User.swift#L41), this is done conditionally for performance improvements.

In UIKit I have created the cell view in a xib file to showcase I can/ its relative complexity. For the subview of the badges, I have created it via code.

--- 
### Unit tests

As to not repeatedly hit the StackOverflow endpoint, in [AppDelegate.swift](PixelTestUIKit/PixelTestUIKit/AppDelegate.swift#L15) I am detecting XCTests to swap the user fetching service with the mock service. 

In the simple tests, I have checked that the User model is still valid for the stashed JSON within the test. It uses the shared JSONDecoder that the real `NetworkingServiceImpl` uses via the protocol default value. This will not only prevent repeated code to create the json decoder, but also ensure the test is meaningful.

There is also a test to ensure the (mock) follow/ unfollow mechanic works.

---
### Note on boiler plate code

The exercise pdf does specify 'All code must be your own'. There is an instances where I have used boiler plate code from a blog - code which I have used in previous projects for a few years. This is code that I have used in the past and find to be the neatest. (InjectedValues).  

I have commented where I have sourced this from in the comments in that file. 

I did spend a good while contemplating the idea to write this myself from scratch to fully adhere to the spec, but ultimately decided take this approach as to not reinvent the wheel/ plagarise. I did start writing this myself, but whatever I wrote was taking direct inspiration from these sources, so rather than plagarise I thought ultimately it be best to stick with this tried-and-tested snippet and provide credit.  

- [InjectedValues.swift](PixelTestUIKit/PixelTestUIKit/DI/InjectedValues.swift) / [Injected.swift](PixelTestUIKit/PixelTestUIKit/DI/Injected.swift) provides a neat way to be able to inject services.

I hope this does not go against me too much.