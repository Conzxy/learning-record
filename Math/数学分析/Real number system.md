# 有理数的缺陷
## 存在不能用有理数表达的数
> [!statement] Statement
> $p ^ 2 = 2$
> 不存在一个有理数满足该等式

> [!proof]
> 采用反证法:
> Assume $\exists p = \frac{m}{n}(m, n \in Q)$
> $$
> m^2 = 2 n^2 \tag{1}
> $$
> 由此, $m$是偶数, 同时也得:
> $$
> m = 2k (k \in Q) \tag{2}
> $$
>将(2)导入(1)可得:
>$$
> n^2 = 2 k^2
> $$
> 由此$n$也是偶数, 因此$p$不满足分子分母不可约
> 即$p$不可能是有理数

## 有理数存在一个"洞"
> [!statement] Statement
> $$
\begin{align}
A = \{ x \in Q_+|x^2<2 \} \\
B = \{ x \in Q_+|x^2>2\}
\end{align}
> $$
> **对于A集合, 不存在最大(有理)数; 对于B集合, 不存在最小数**

> [!proof] Proof
> 转换为等价命题:
> > [!note] 等价命题 
> > To $\forall p \in A,\exists q \in A \ s.t. q > p$
> > To $\forall p \in B, \exists q \in B \ s.t. q < p$
> 
> Assume $s^2=2,s \notin Q, s>0$
> 考虑$p$与$s$的距离:
> $$
> \begin{align}
> & s-p=\frac{s^2-p^2}{s+p}>\frac{2-p^2}{p+2}>0 \\
> & s > p + \frac{2-p^2}{p+2}
> \end{align}
> $$
> 因此可以取:
> $$
> q = \frac{2-p^2}{p+2} +p < s
> $$
> From $p^2<2$, 
> $$
> q = p +r > p(r> 0)
> $$
> $$
> q^2-2 = q^2-s^2 < q^2 - q^2 = 0
> $$
> 对于B集合类似, 不再赘述

负有理数类似.
> [!think]
>这里用到了距离计算和分母有理化的技巧

### 其他证法
> [!idea]
> If $p^2<2$, 我们可以找到一个比$p$略大的有理数$q$满足$q^2<2$且$q \in A$
> If $p^2>2$, 我们可以找到一个比$p$略小的有理数$q$满足$q^2>2$且$q \in B$

> [!proof] 
> Assume $q = p + \delta(0<\delta<1)$,
> 由$0<\delta<1$可得: $0<\delta^2<\delta$
> 由$p^2<2$得: $p<2$
> $$
> \begin{align}
> (p+\delta)^{2}
> &= p^{2}+2p\delta+\delta^{2} \\
> &<p^2+2p\delta+\delta\\
> &<p^{2}+5\delta(p<2)\\
> &<2
> \end{align}
> $$
> 因此取:
> $$
> \delta=\frac{2-p^2}{5}
> $$
> 即可满足条件
> 同理, Assume $q=p-\delta(0<\delta^{2}<2,p>0)$
> $$
> \begin{align}
> (p-\delta)^2&=p^2-2p\delta+\delta^{2}\\
> &>p^2-2p\delta\\
> &>2
> \end{align}
> $$
> 因此取:
> $$
> \delta=\frac{p^2-2}{2p}
> $$
> 即可满足条件

> [!think]
> 主要是要找到缩放不等式满足不等号不变向