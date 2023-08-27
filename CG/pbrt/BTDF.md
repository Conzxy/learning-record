# 菲涅耳反射(Fresnel Reflectance)
菲涅耳项在CG中主要用来表示光被反射的量。
根据入射光与表面的角度，呈现不同的反射性质：
* 入射光与表面几乎平行，大部分光被反射
* 入射光与表面垂直，大部分光被折射

菲涅耳项实际上需要考虑入射光的不同偏振状态(水平和垂直), 但是在实际的渲染器中, 都并没有考虑该特性, 而是直接用没有偏振的光的菲涅耳项(即下图中的红色部分), 可见对视觉不会造成太大影响.
![[Pasted image 20230827104257.png|Dielectric, eta=1.5]]
有意思的是, 对于金属这样的导体而言, 菲涅耳项一直偏高:
![[Pasted image 20230827105954.png|Conductor]]
所以生活中会流行铜镜, 银镜是因为它们的折射现象少.

由此可以衍生出三类材质:

| 材质 | 特征 | 折射率 |
|-- | -- | -- |
| 绝缘体(Dielectrics) | 可以反射和折射光线 | 实数(通常是1-3) |
| 导体(Conductor) | 几乎不透明且反射大部分光, 少部分光被折射并被吸收(通常发生在0.1um的材质顶部), 通常不考虑其折射特性 | 是个复数, 拥有虚部: eta + ik |
| 半导体(Semiconductor) | 论外 | 论外 |
## 菲涅耳项的计算
通常, 菲涅耳项就是水平和垂直两个方向偏振项平方的平均. ![[Pasted image 20230827105843.png]] 由于计算过于复杂, 实际应用中更可能采用它的近似: ![[Pasted image 20230827110332.png|Schlick’s approximation]]

对于导体的菲涅耳项, 要更为复杂些.
导体的折射率通常表示为$\overline{\eta} = \eta + \rm{i}k$, 其中k代表**吸收系数(absorption cofficient)**, 导体会将一部分入射光吸收到金属内部并转化为热能.
![[Pasted image 20230827121016.png]]

通常是通过一个绝缘体进入到金属, 其边界的菲涅耳项如下:
![[Pasted image 20230827121115.png]]
其中, 
$$
a^2+b^2=\sqrt{(\eta^2-k^2-\sin^2\theta)^2+4\eta^2k^2}
$$
$$
n+\rm{i}k=\overline{\eta_t}/\overline{\eta_i}
$$
```cpp
Spectrum FrConductor(Float cosThetaI, const Spectrum &etai,
                     const Spectrum &etat, const Spectrum &k) {
    cosThetaI = Clamp(cosThetaI, -1, 1);
    Spectrum eta = etat / etai;
    Spectrum etak = k / etai;

    Float cosThetaI2 = cosThetaI * cosThetaI;
    Float sinThetaI2 = 1. - cosThetaI2;
    Spectrum eta2 = eta * eta;
    Spectrum etak2 = etak * etak;

    Spectrum t0 = eta2 - etak2 - sinThetaI2;
    Spectrum a2plusb2 = Sqrt(t0 * t0 + 4 * eta2 * etak2);
    Spectrum t1 = a2plusb2 + cosThetaI2;
    Spectrum a = Sqrt(0.5f * (a2plusb2 + t0));
    Spectrum t2 = (Float)2 * cosThetaI * a;
    Spectrum Rs = (t1 - t2) / (t1 + t2);

    Spectrum t3 = cosThetaI2 * a2plusb2 + sinThetaI2 * sinThetaI2;
    Spectrum t4 = t2 * sinThetaI2;
    Spectrum Rp = Rs * (t3 - t4) / (t3 + t4);

    return 0.5 * (Rp + Rs);
}
```

## Specular BRDF的渲染方程
$$
L_o(\omega_o) = {\int}f_r(\omega_o, \omega_i)L_i(\omega_i)|cos\theta_i|d\omega_i=F_r(\omega_o)L_i(\omega_o)=F_r(\omega_r)L_i(\omega_r)
$$
其中, $\omega_r=R(\omega_i, n)$, $\omega_o=\omega_r$, $F_r(\omega_o)=F_r(\omega_r)$

高光BRDF不需要计算所有方向的radiance, 因为出射光只对应唯一一个方法的入射光($\omega_i$).
