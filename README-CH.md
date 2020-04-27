# QuickDB

### FileManager + CoreData

❗️仅用一行代码即可保存并检索任何内容❗️

快速使用数据库，避免麻烦的数据库。 只需使用简单的功能保存每个对象。

<img src="https://github.com/behrad-kzm/BEKDesing/blob/master/Images/BEKHeader.png">

QuickDB将CoreData与SUPER易于使用的案例结合使用，您可以存储任何可编码的对象并在仅一行代码中对其进行查询。
强烈建议该组件用于小型应用程序，以使用自定义类类型存储用户数据和设置。

[![CI Status](https://img.shields.io/travis/behrad-kzm/QuickDB.svg?style=flat)](https://travis-ci.org/behrad-kzm/QuickDB)
[![Version](https://img.shields.io/cocoapods/v/QuickDB.svg?style=flat)](https://cocoapods.org/pods/QuickDB)
[![License](https://img.shields.io/cocoapods/l/QuickDB.svg?style=flat)](https://cocoapods.org/pods/QuickDB)
[![Platform](https://img.shields.io/cocoapods/p/QuickDB.svg?style=flat)](https://cocoapods.org/pods/QuickDB)

## 怎么样？

__步骤 1:__

确认您的编码具有协议“ QuickIndexable”的UUID

```swift
struct MyModel: QuickIndexable {
  let uid = UUID()
  ...
}
```

__步骤 2:__

将对象保存到QuickDB

```swift
  QuickDB.shared.insert(model: myModel)
```

__步骤 3:__

从QuickDB检索所有对象

```swift
QuickDB.shared.getAll(LatestObjects: { (items: [MyModel]) in
      //use your inserted items here
	print(items)
}) { (error) in
	print(error)
}
```

QuickDB使用通用函数查询与您的Model类型匹配的所有记录。

## 注意

💢检查示例，看看如何对模型进行“ bachInsert”，“ delete”，“ update”和“ tag”标记。

💢有些用例已经过优化，可用于存储较大的文件，例如“图片”，“音频”等。

__存储图像：__

```swift
	UIImage(imageLiteralResourceName: "Image").pngData()?.asQuickFile(fileName: "MyImage").store()
```

###您可以将任何数据模型转换为quickFile并将其存储在FileManager中：

__步骤 1：__

保存您的数据对象：

```swift
	Data().asQuickFile(fileName: "MyData").store()
```

__步骤 2：__

加载保存的数据：

```swift
QuickDB.shared.data(fileName: "MyImage", fileType: .png) { (items) in
	//items is an array of [Data] matches with your file name
}
```

💢QuickFM将任何文件保存在设备内的QuickDBStorage文件夹中，您可以在`QuickDB.shared.getAll（LatestObjects：{（items：[QuickDataRecord]）in}`的功能内获取所有保存的文件。

💢QuickFM允许您使用相同的文件名保存数据对象，并在`data（fileName：fileType：completion）`中检索所有这些对象。

## 示例

要运行示例项目，请克隆存储库，然后首先从Example目录运行`pod install`。

## 要求

iOS +11.0
swift 5.0
xcode +11

## 安装

可通过[CocoaPods]（https://cocoapods.org）获得QuickDB。 安装
只需将以下行添加到您的Podfile中：

```swift
pod 'QuickDB'
```

## 作者

behrad-kzm, behradkzm@gmail.com

## 特别感谢

[Salar Soleimani](https://github.com/Salarsoleimani)

## 执照

QuickDB在MIT许可下可用。 有关更多信息，请参见LICENSE文件。
