# iOS仿Android的可点击Toast

![](ToastUtils.gif)

#### 近期处理的一个需求，要求提示像android一样不影响页面操作，多个提示会使用队列来把所有的提示都显示完，提示里面可以进行点击来引导用户，写完之后抽出来供需要的朋友使用

#### 集成步骤

```CocoaPod
pod 'XSBaseDialog'
```

#### Toast配置
```swift
// time : 需要显示的时间
// defaultFont : 不使用富媒体时的默认字体
// defaultTextColor : 不使用富媒体时的文字颜色
// defaultBackgroudColor : Toast的背景颜色
// actionURLSchemeWhiteList : 需要响应点击的URL协议
// actionCallback : 点击了Toast中的富媒体文本link的响应事件回调
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

#### Toast显示

```swift
// 使用默认的字体和颜色显示
XSBaseToastManager.showToast(message: message)
// 自定义富媒体
XSBaseToastManager.showToast(messageAttr: attrMessage)
```

#### Loadding使用
```swift
let hud = XSBaseLoaddingView.showHudToView(view: view, text: NSMutableAttributedString.init(string: "正在加载，请稍等一下"))
weak var weakSelf = self
DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
	// hud.close()
	XSBaseLoaddingView.closeAllHudInView(view: weakSelf!.view)
}
```

#### 具体使用可参考项目中的Example

## License

```text
Copyright (c) 2021 FatBull

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
