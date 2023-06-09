
# Log Module

# snapshot思路
snapshot允许生成多份，每一份保存当前的index到上一次snapshot包含index范围内的所有log entry导致的state change（set command）。
考虑snapshot思路不唯一，可以考虑抽象为interface。

## 废案
- 写入所有状态：消耗太大且难以传输和使用（每次都得拨动硬盘探针）
- 分析范围内的所有log entry，得到这次的state change：消耗过大且实现与具体业务逻辑强耦合，逻辑复杂
