
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
![Simulator Search Menu Example](https://user-images.githubusercontent.com/79987744/136814561-ed13b814-2c18-419e-856d-a8b4888104f9.png) ![Simulator Search Result](https://user-images.githubusercontent.com/79987744/136814571-dd5560f6-3e43-447f-8a2d-d4cb6dc4db0f.png)

![Simulator Detail Recipe Searched](https://user-images.githubusercontent.com/79987744/136814622-048ea519-bb13-4a8f-ad43-859fcfe96e46.png)
) ![Simulator Detail Recipe Searched on Safari Link](https://user-images.githubusercontent.com/79987744/136814627-5fcfaf59-b416-4eed-a5a8-5a9a6b5a2f21.png)

### Favorite Tab:
![Simulator Favorite Menu](https://user-images.githubusercontent.com/79987744/136814650-864f591e-73fa-4990-81f2-835415262756.png) ![Simulator Detail Recipe Favorite](https://user-images.githubusercontent.com/79987744/136814657-ae1aab9c-6d32-4c6f-86f7-e28519b5b1f5.png)
