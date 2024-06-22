1. [Popup窗体焦点传递异常](http://jira.d5techs.com.cn/browse/FUSION-30824?filter=15717)
  当存在三个窗体A, B, C时, 按照`C->B->A`的顺序激活窗体, B是个指定了`Qt::Popup`的窗体, 此时A窗体最小化, 焦点会移到C窗体, 并且B窗体会被C窗体遮盖.
  感觉是Qt内部bug.