### How to build:
1. Clone main project repo
`git clone -b develop --recurse-submodules git@gitlab.vladimir.ibuildapp.com:ios/ibuildapp.git`
2. Add this widget as dependency in podfile `pod 'BookstoreModule', :git => 'git@gitlab.vladimir.ibuildapp.com:ios/bookstorewidget.git', :branch => 'master'` 
3. Install cocoapods dependencis `pod install`
4. Run in Xcode

### How to build development version:
1. Clone main project repo
`git clone -b feature/bookstore --recurse-submodules git@gitlab.vladimir.ibuildapp.com:ios/ibuildapp.git`
2. Install cocoapods dependencis `pod install`
3. Run in Xcode
