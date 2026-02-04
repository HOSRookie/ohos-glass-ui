# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-02-04

### Added

- **GlassCard** - 毛玻璃卡片组件
  - 支持标题、可点击状态
  - 4 级阴影可配置
  - 按压缩放动画反馈

- **GlassListItem** - 毛玻璃列表项组件
  - 左侧图标、右侧箭头
  - 支持危险操作样式（红色）
  - 副标题支持

- **GlassButton** - 毛玻璃按钮组件
  - 4 种按钮类型：PRIMARY / SECONDARY / DANGER / GHOST
  - 加载状态支持
  - 禁用状态支持
  - 绿色渐变主按钮带光晕效果

- **GlassInput** - 毛玻璃输入框组件
  - 单行/多行输入支持
  - 字数统计
  - 聚焦状态绿色边框反馈

- **GlassSelect** - 毛玻璃选择器组件
  - 下拉选择功能
  - 统一毛玻璃样式

- **GlassReadonlyField** - 毛玻璃只读字段组件
  - 适用于展示不可编辑信息

### Technical

- 基于 ArkUI V2 (@ComponentV2) 开发
- 支持 HarmonyOS NEXT API 12+
- 零外部依赖
- 完整 TypeScript 类型支持
