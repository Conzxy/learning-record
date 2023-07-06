> 参考Qt Assistant 5.15 "Drag and Drop"

# 定义
> Drag and drop provides a simple visual mechanism which users can use to transfer information between and within applications

总之，就是为了给不同应用之间（或者同一个应用的不同窗体）拖放一些数据，以提供方便。
比如从文件浏览器拖拉一些文件到Qt应用中，读取其数据并进行处理。

## 能够处理的数据
主要能够处理的数据是MIME类型，同时也支持自定义数据类型。

## 相关类
![[Pasted image 20230706001020.png]]

## Dragging
通过创建 `QDrag` 对象，并调用其 `exec()` 方法，就触发了一次拖操作。
可以在 `QWidget::mousePressEvent()` 方法中实现：
![[Pasted image 20230706001605.png]]
`exec()` 方法接受一个 `Qt::DropAction` 枚举值来表示最终放下执行的具体行为，默认是 `Qt::MoveAction`。
注意，该方法并不阻塞事件循环。

由于单纯的Press和Drag是有区别的，比如原地按下再释放，这不应被视为Drag。因此，将 **移动一定距离视为Drag** 是比较合理的做法。
在PressEvent中记录开始位置，然后在moveEvent中判断是否视为Drag并执行同上的逻辑即可。
![[Pasted image 20230706002057.png]]
![[Pasted image 20230706002116.png]]

## Dropping
首先，QWidget默认是不接受Drop事件的，因此需要通过 `setAcceptDrops(true)` 启用。
为了能够处理关于该窗体的拖拉事件，往往需要实现 `dragEnterEvent()`，`dropEvent()` 等事件函数。

### dragEnterEvent()
通过 `QDragEnterEvent::mimeData()` 获取到数据，检查是否为期望格式，并根据是否能够处理决定是否受理。
> `acceptProposedAction()` 实际是将drop action设置为proposed action
![[Pasted image 20230706002714.png]]

### dropEvent()
根据 `dragXXXEvent()` 受理的数据，执行相关逻辑，并阻止事件继续向上传递。