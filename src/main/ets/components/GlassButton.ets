/**
 * 毛玻璃按钮组件
 * 
 * 功能：
 * - 主按钮（渐变背景 + 光晕）
 * - 次要按钮（毛玻璃背景）
 * - 危险按钮（红色边框）
 * - 幽灵按钮（透明背景 + 边框）
 * 
 * 使用示例：
 * ```
 * // 主按钮
 * GlassButton({
 *   text: '保存',
 *   type: GlassButtonType.PRIMARY,
 *   onTap: () => this.save()
 * })
 * 
 * // 危险按钮
 * GlassButton({
 *   text: '退出登录',
 *   type: GlassButtonType.DANGER,
 *   onTap: () => this.logout()
 * })
 * ```
 */

/**
 * 按钮类型枚举
 */
export enum GlassButtonType {
  /** 主按钮（绿色渐变） */
  PRIMARY = 'primary',
  /** 次要按钮（毛玻璃） */
  SECONDARY = 'secondary',
  /** 危险按钮（红色边框） */
  DANGER = 'danger',
  /** 幽灵按钮（透明 + 白色边框） */
  GHOST = 'ghost'
}

@ComponentV2
export struct GlassButton {
  /** 按钮文字 */
  @Param text: string = '';
  
  /** 按钮类型 */
  @Param type: GlassButtonType = GlassButtonType.PRIMARY;
  
  /** 是否禁用 */
  @Param disabled: boolean = false;
  
  /** 是否加载中 */
  @Param loading: boolean = false;
  
  /** 按钮高度 */
  @Param buttonHeight: number = 48;
  
  /** 圆角 */
  @Param buttonRadius: number = 16;
  
  /** 是否全宽 */
  @Param fullWidth: boolean = true;
  
  /** 点击事件 */
  @Event onTap: () => void = () => {};
  
  @Local private isPressed: boolean = false;
  
  private getTextColor(): ResourceColor {
    if (this.disabled) {
      return 'rgba(255, 255, 255, 0.3)';
    }
    switch (this.type) {
      case GlassButtonType.PRIMARY:
        return Color.White;
      case GlassButtonType.SECONDARY:
        return Color.White;
      case GlassButtonType.DANGER:
        return '#FF4D4F';
      case GlassButtonType.GHOST:
        return Color.White;
      default:
        return Color.White;
    }
  }
  
  private getBorderColor(): ResourceColor {
    if (this.disabled) {
      return 'rgba(255, 255, 255, 0.1)';
    }
    switch (this.type) {
      case GlassButtonType.PRIMARY:
        return Color.Transparent;
      case GlassButtonType.SECONDARY:
        return 'rgba(255, 255, 255, 0.15)';
      case GlassButtonType.DANGER:
        return '#FF4D4F';
      case GlassButtonType.GHOST:
        return 'rgba(255, 255, 255, 0.3)';
      default:
        return Color.Transparent;
    }
  }
  
  private getShadow(): ShadowOptions {
    if (this.disabled || this.type !== GlassButtonType.PRIMARY) {
      return { radius: 0, color: Color.Transparent, offsetX: 0, offsetY: 0 };
    }
    return {
      radius: this.isPressed ? 16 : 12,
      color: this.isPressed ? 'rgba(76, 175, 80, 0.5)' : 'rgba(76, 175, 80, 0.3)',
      offsetX: 0,
      offsetY: this.isPressed ? 4 : 2
    };
  }
  
  @Builder
  private buildPrimaryButton(): void {
    Row() {
      if (this.loading) {
        LoadingProgress()
          .width(20)
          .height(20)
          .color(Color.White)
          .margin({ right: 8 })
      }
      Text(this.loading ? '处理中...' : this.text)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.getTextColor())
    }
    .width(this.fullWidth ? '100%' : 'auto')
    .height(this.buttonHeight)
    .padding(this.fullWidth ? 0 : { left: 24, right: 24 })
    .justifyContent(FlexAlign.Center)
    .borderRadius(this.buttonRadius)
    .linearGradient({
      angle: 90,
      colors: this.disabled 
        ? [['rgba(128, 128, 128, 0.3)', 0], ['rgba(128, 128, 128, 0.3)', 1]]
        : [['#5DD784', 0], ['#4CAF50', 0.5], ['#43A047', 1]]
    })
    .shadow(this.getShadow())
    .scale({ 
      x: this.isPressed && !this.disabled ? 0.98 : 1.0, 
      y: this.isPressed && !this.disabled ? 0.98 : 1.0 
    })
    .opacity(this.isPressed && !this.disabled ? 0.9 : 1.0)
    .animation({ duration: 100, curve: Curve.EaseOut })
  }
  
  @Builder
  private buildSecondaryButton(): void {
    Row() {
      if (this.loading) {
        LoadingProgress()
          .width(20)
          .height(20)
          .color(Color.White)
          .margin({ right: 8 })
      }
      Text(this.loading ? '处理中...' : this.text)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.getTextColor())
    }
    .width(this.fullWidth ? '100%' : 'auto')
    .height(this.buttonHeight)
    .padding(this.fullWidth ? 0 : { left: 24, right: 24 })
    .justifyContent(FlexAlign.Center)
    .borderRadius(this.buttonRadius)
    .backgroundColor(Color.Transparent)
    .backgroundBlurStyle(BlurStyle.Thin)
    .border({ width: 1, color: this.getBorderColor() })
    .scale({ 
      x: this.isPressed && !this.disabled ? 0.98 : 1.0, 
      y: this.isPressed && !this.disabled ? 0.98 : 1.0 
    })
    .opacity(this.isPressed && !this.disabled ? 0.9 : 1.0)
    .animation({ duration: 100, curve: Curve.EaseOut })
  }
  
  @Builder
  private buildDangerButton(): void {
    Row() {
      if (this.loading) {
        LoadingProgress()
          .width(20)
          .height(20)
          .color('#FF4D4F')
          .margin({ right: 8 })
      }
      Text(this.loading ? '处理中...' : this.text)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.getTextColor())
    }
    .width(this.fullWidth ? '100%' : 'auto')
    .height(this.buttonHeight)
    .padding(this.fullWidth ? 0 : { left: 24, right: 24 })
    .justifyContent(FlexAlign.Center)
    .borderRadius(this.buttonRadius)
    .backgroundColor(Color.Transparent)
    .border({ width: 1, color: this.getBorderColor() })
    .scale({ 
      x: this.isPressed && !this.disabled ? 0.98 : 1.0, 
      y: this.isPressed && !this.disabled ? 0.98 : 1.0 
    })
    .opacity(this.isPressed && !this.disabled ? 0.9 : 1.0)
    .animation({ duration: 100, curve: Curve.EaseOut })
  }
  
  @Builder
  private buildGhostButton(): void {
    Row() {
      if (this.loading) {
        LoadingProgress()
          .width(20)
          .height(20)
          .color(Color.White)
          .margin({ right: 8 })
      }
      Text(this.loading ? '处理中...' : this.text)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.getTextColor())
    }
    .width(this.fullWidth ? '100%' : 'auto')
    .height(this.buttonHeight)
    .padding(this.fullWidth ? 0 : { left: 24, right: 24 })
    .justifyContent(FlexAlign.Center)
    .borderRadius(this.buttonRadius)
    .backgroundColor(this.isPressed ? 'rgba(255, 255, 255, 0.05)' : Color.Transparent)
    .border({ width: 1, color: this.getBorderColor() })
    .scale({ 
      x: this.isPressed && !this.disabled ? 0.98 : 1.0, 
      y: this.isPressed && !this.disabled ? 0.98 : 1.0 
    })
    .opacity(this.isPressed && !this.disabled ? 0.9 : 1.0)
    .animation({ duration: 100, curve: Curve.EaseOut })
  }
  
  build() {
    Column() {
      if (this.type === GlassButtonType.PRIMARY) {
        this.buildPrimaryButton()
      } else if (this.type === GlassButtonType.SECONDARY) {
        this.buildSecondaryButton()
      } else if (this.type === GlassButtonType.DANGER) {
        this.buildDangerButton()
      } else {
        this.buildGhostButton()
      }
    }
    .enabled(!this.disabled && !this.loading)
    .onTouch((event: TouchEvent) => {
      if (this.disabled || this.loading) return;
      if (event.type === TouchType.Down) {
        this.isPressed = true;
      } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
        this.isPressed = false;
      }
    })
    .onClick(() => {
      if (!this.disabled && !this.loading && this.onTap) {
        this.onTap();
      }
    })
  }
}

