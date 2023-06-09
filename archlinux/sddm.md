# Sddm configuration
## breeze
breeze应该是默认安装的里面颜值最耐打的。
但是默认配置，设置背景图片是模糊的。
以我的PC举例：
```qml
// /usr/share/sddm/themes/breeze/components/WallpaperFader.qml
[..]
PropertyChanges {
	target: wallpaperFader
	factor: 0
}
[..]
```
这样就不会模糊了。