#  TShirtStore

A T Shirt Store app where use can browse the contents of store, view details and finaly add to order.
    - Product list
    - Product deetails (add to order)
    - Orders (where all items are listed)
    
    
## Screen Shots

### ![alt text](https://github.com/devwork99/MVVM-TShirtStore/blob/dev/MVVM-fakestore/ScreenShots/list.png?raw=true)
### ![alt text](https://github.com/devwork99/MVVM-TShirtStore/blob/dev/MVVM-fakestore/ScreenShots/details.png?raw=true)
### ![alt text](https://github.com/devwork99/MVVM-TShirtStore/blob/dev/MVVM-fakestore/ScreenShots/orders.png?raw=true)


## Dependency

Using SPM for dependency management, I am using SDWebImage to display images


## MVVM architecture + Combine

    - ViewModel that has all the business logic, fetching data from internet, and converting into formate that is useable for the view
    - View is written with SwiftUI and is "Active", it means observe the changes from ViewModel with the Observable Protocol, has direct access to ViewModel
    - Model, the business classes or the model objects
    - Combine is used to fetch the data from API in the NetworkManager


## Unit Test

The ProductViewModelTests include tests
- Test shows the list is populating with products


## Networking

    - The networking layer is called "NetworkManager" POP is used in NetworkManager, so the dependency in injected from outside, that is alternative of Singleton.
    - With POP the MockNetworkingService is used that makes the unit tests easier.

