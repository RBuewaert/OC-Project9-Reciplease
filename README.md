
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
![Simulator Search Menu Example](https://user-images.githubusercontent.com/79987744/136790284-68876e6e-b8d1-47eb-8f65-66baed3c9e09.png) ![Simulator Search Result](https://user-images.githubusercontent.com/79987744/136790023-5961417a-a9b1-4471-89d2-adb60dd3b5cc.png)

![Simulator Detail Recipe Searched](https://user-images.githubusercontent.com/79987744/136790470-45e2bd2b-dc94-494f-8c06-b538cfbc9407.png) ![Simulator Detail Recipe Searched on Safari Link](https://user-images.githubusercontent.com/79987744/136790481-007a571d-d452-4582-9ec3-a6bc6a62b8b4.png)

### Favorite Tab:
![Simulator Favorite Menu](https://user-images.githubusercontent.com/79987744/136790031-2e029911-a4ba-4a33-959b-f0216e8fb0de.png) ![Simulator Detail Recipe Favorite](https://user-images.githubusercontent.com/79987744/136790040-f247c498-358f-49e7-a2ef-bdc88ea13e7f.png)
