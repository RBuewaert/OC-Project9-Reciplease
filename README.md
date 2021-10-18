
# Reciplease

It's an iOS Application to find recipes with ingredients choised by the user.
The application use Alamofire for requests with the API and Core Data to save favorites recipes.

## API Used

API Recipe Search by Edamam


# Requirements
It's necessary to add your own key on APIkey.swift file : <br/>
```swift
//
//  APIkey.swift
//  Reciplease
//

import Foundation

final class APIKey {
    static let key = "KeyRef"
    static let id = "idRef"
}
```

# Screenshots
### Search Tab:
![Simulator Search Menu Example](https://user-images.githubusercontent.com/79987744/137483176-dbccb153-9d0c-4a95-9097-b4375e8b3e04.png) ![Simulator Search Result](https://user-images.githubusercontent.com/79987744/137483199-64d12717-5936-47e7-899b-f381dc9a2e84.png)

![Simulator Detail Recipe Searched](https://user-images.githubusercontent.com/79987744/137483247-0bacdf90-7409-486a-ba78-aafaa0ce1244.png) ![Simulator Detail Recipe Searched on Safari Link](https://user-images.githubusercontent.com/79987744/137483255-6d11857a-8665-412b-9b86-7665ca73726a.png)

### Favorite Tab:
![Simulator Favorite Menu](https://user-images.githubusercontent.com/79987744/137483306-a96ab6e7-100e-460b-a487-b1f14ac0470b.png) ![Simulator Detail Recipe Favorite](https://user-images.githubusercontent.com/79987744/137483313-5c088e17-e26e-4840-add8-3d0c01eb07b8.png)
