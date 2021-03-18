# iOS仿Android的可点击Toast

![](ToastUtils.gif)

#### 近期处理的一个需求，要求提示像android一样不影响页面操作，多个提示会使用队列来把所有的提示都显示完，提示里面可以进行点击来引导用户，写完之后抽出来供需要的朋友使用

#### 集成步骤

```CocoaPod
pod 'XSBaseDialog'
```

#### 配置
```swift
XSBaseToastManager.config(time: 3.0,
			defaultFont: UIFont.boldSystemFont(ofSize: 17.0),
			defaultTextColor: .red,
			defaultBackgroudColor: .blue,
			actionURLSchemeWhiteList: ["http","https"]) { (u:URL) in
            
            // 点击相应的URL进行处理
            let scheme = u.scheme ?? ""
            if scheme == "http" || scheme == "https" {
                DispatchQueue.main.async {
                    UIApplication.shared.open(u, options: [:]) { (complete) in
                        
                    }
                }
            }
        }
```

#### 显示

```java
// 使用默认的字体和颜色显示
XSBaseToastManager.showToast(message: message)
// 自定义富媒体
XSBaseToastManager.showToast(messageAttr: attrMessage)
```

## License

```text
Copyright 2021 Huang xuesong

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
