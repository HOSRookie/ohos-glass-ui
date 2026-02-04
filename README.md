# ohos-glass-ui

<p align="center">
  <img src="https://img.shields.io/badge/HarmonyOS-NEXT-blue" alt="HarmonyOS NEXT">
  <img src="https://img.shields.io/badge/API-12+-green" alt="API 12+">
  <img src="https://img.shields.io/badge/ArkTS-V2-orange" alt="ArkTS V2">
  <img src="https://img.shields.io/badge/License-Apache%202.0-lightgrey" alt="License">
</p>

**HarmonyOS NEXT 毛玻璃风格 UI 组件库**

 Glassmorphism 风格组件库，提供开箱即用的毛玻璃卡片、按钮、输入框等组件。

## ✨ 特性

- 🎨 **毛玻璃效果** - 基于 `backgroundBlurStyle` 的真实模糊效果
- 🌙 **深色主题优化** - 专为深色背景设计
- ⚡ **零依赖** - 纯 ArkTS 实现，无外部依赖
- 📦 **ArkUI V2** - 基于 @ComponentV2 开发，状态管理更高效
- 🎯 **开箱即用** - 统一的视觉语言，无需额外配置

## 📦 安装

```bash
ohpm install ohos-glass-ui
```

或在 `oh-package.json5` 中添加：

```json5
{
  "dependencies": {
    "ohos-glass-ui": "^1.0.0"
  }
}
```

## 🚀 快速开始

```typescript
import { GlassCard, GlassButton, GlassButtonType, GlassInput } from 'ohos-glass-ui';

@Entry
@ComponentV2
struct DemoPage {
  @Local username: string = '';
  
  build() {
    Column({ space: 16 }) {
      // 毛玻璃卡片
      GlassCard({ title: '登录' }) {
        Column({ space: 12 }) {
          // 毛玻璃输入框
          GlassInput({
            label: '用户名',
            placeholder: '请输入用户名',
            value: this.username,
            maxLength: 20,
            onChange: (value: string) => { this.username = value; }
          })
          
          // 毛玻璃按钮
          GlassButton({
            text: '登录',
            type: GlassButtonType.PRIMARY,
            onTap: () => { console.info('登录'); }
          })
        }
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#0a0a2e') // 深色背景才能看到毛玻璃效果
  }
}
```

## 📚 组件列表

### GlassCard - 毛玻璃卡片

```typescript
GlassCard({
  title: '标题',           // 可选标题
  titleSize: 16,           // 标题字号
  clickable: true,         // 是否可点击
  cardPadding: 16,         // 内边距
  cardRadius: 16,          // 圆角
  blurStyle: BlurStyle.Thin,  // 模糊强度
  shadowLevel: 1,          // 阴影等级 1-4
  onTap: () => {}          // 点击回调
}) {
  // 内容 Builder
}
```

### GlassListItem - 毛玻璃列表项

```typescript
GlassListItem({
  title: '账号与安全',
  subtitle: '管理您的账号安全设置',
  icon: $r('sys.symbol.shield'),
  rightText: '',
  showArrow: true,
  danger: false,           // 红色危险样式
  onTap: () => {}
})
```

### GlassButton - 毛玻璃按钮

```typescript
// 按钮类型
enum GlassButtonType {
  PRIMARY,    // 主按钮（绿色渐变 + 光晕）
  SECONDARY,  // 次要按钮（毛玻璃背景）
  DANGER,     // 危险按钮（红色边框）
  GHOST       // 幽灵按钮（透明 + 白色边框）
}

GlassButton({
  text: '确认',
  type: GlassButtonType.PRIMARY,
  disabled: false,
  loading: false,
  buttonHeight: 48,
  buttonRadius: 16,
  fullWidth: true,
  onTap: () => {}
})
```

### GlassInput - 毛玻璃输入框

```typescript
GlassInput({
  label: '昵称',
  placeholder: '请输入昵称',
  value: this.name,
  maxLength: 20,           // 0 = 不限制
  multiLine: false,        // 多行输入
  multiLineHeight: 100,    // 多行高度
  readonly: false,
  inputType: InputType.Normal,
  onChange: (value: string) => {}
})
```

### GlassSelect - 毛玻璃选择器

```typescript
GlassSelect({
  label: '性别',
  value: this.gender,
  options: ['保密', '男', '女'],
  onChange: (value: string) => {}
})
```

### GlassReadonlyField - 毛玻璃只读字段

```typescript
GlassReadonlyField({
  label: '用户ID',
  value: 'UID123456',
  placeholder: '-'         // 值为空时显示
})
```

## 🎨 设计规范

### 推荐背景色

毛玻璃效果需要深色背景才能呈现最佳视觉效果：

```typescript
// 推荐
.backgroundColor('#0a0a2e')  // 深蓝
.backgroundColor('#1a1a3e')  // 午夜蓝
.backgroundColor('#0d0d1a')  // 近黑

// 或使用渐变背景
.linearGradient({
  angle: 180,
  colors: [['#0a0a2e', 0], ['#1a1a4e', 1]]
})
```

### 颜色变量

组件内部使用的颜色：

| 用途 | 颜色值 |
|------|--------|
| 主按钮渐变 | `#5DD784` → `#4CAF50` → `#43A047` |
| 聚焦边框 | `rgba(76, 175, 80, 0.6)` |
| 危险色 | `#FF4D4F` |
| 文字主色 | `#FFFFFF` |
| 文字次色 | `rgba(255, 255, 255, 0.5)` |
| 边框色 | `rgba(255, 255, 255, 0.15)` |

## 📋 要求

- HarmonyOS NEXT (API 12+)
- DevEco Studio 5.0+
- ArkTS V2

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 License

[Apache License 2.0](./LICENSE)

---

<p align="center">
  Made with ❤️ for HarmonyOS
</p>
