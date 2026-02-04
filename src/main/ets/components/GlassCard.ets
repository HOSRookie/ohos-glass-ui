/**
 * 毛玻璃卡片组件
 * 
 * 功能：
 * - 统一的毛玻璃背景样式
 * - 标准边框和阴影
 * - 可选标题
 * - 点击反馈动画
 * 
 * 使用示例：
 * ```
 * GlassCard({ title: '基本信息' }) {
 *   Column() {
 *     Text('内容')
 *   }
 * }
 * 
 * // 可点击卡片
 * GlassCard({ 
 *   title: '设置项',
 *   clickable: true,
 *   onTap: () => this.handleClick()
 * }) {
 *   // 内容
 * }
 * ```
 */

@ComponentV2
export struct GlassCard {
  /** 卡片标题（可选） */
  @Param title: string = '';
  
  /** 标题字体大小 */
  @Param titleSize: number = 16;
  
  /** 是否可点击 */
  @Param clickable: boolean = false;
  
  /** 内边距 */
  @Param cardPadding: Length | Padding = 16;
  
  /** 圆角 */
  @Param cardRadius: Length = 16;
  
  /** 模糊强度 */
  @Param blurStyle: BlurStyle = BlurStyle.Thin;
  
  /** 阴影层级 (1-4) */
  @Param shadowLevel: number = 1;
  
  /** 点击事件 */
  @Event onTap: () => void = () => {};
  
  /** 卡片内容 Builder */
  @BuilderParam content: () => void = this.defaultContent;
  
  @Local private isPressed: boolean = false;
  
  @Builder
  private defaultContent(): void {}
  
  private getShadow(): ShadowOptions {
    switch (this.shadowLevel) {
      case 1:
        return { radius: 8, color: 'rgba(0, 0, 0, 0.2)', offsetX: 0, offsetY: 2 };
      case 2:
        return { radius: 12, color: 'rgba(0, 0, 0, 0.25)', offsetX: 0, offsetY: 4 };
      case 3:
        return { radius: 16, color: 'rgba(0, 0, 0, 0.3)', offsetX: 0, offsetY: 6 };
      case 4:
        return { radius: 24, color: 'rgba(0, 0, 0, 0.35)', offsetX: 0, offsetY: 8 };
      default:
        return { radius: 8, color: 'rgba(0, 0, 0, 0.2)', offsetX: 0, offsetY: 2 };
    }
  }
  
  build() {
    Column({ space: 16 }) {
      if (this.title) {
        Text(this.title)
          .fontSize(this.titleSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .width('100%')
      }
      
      this.content()
    }
    .width('100%')
    .padding(this.cardPadding)
    .backgroundColor(Color.Transparent)
    .backgroundBlurStyle(this.blurStyle)
    .border({ width: 1, color: 'rgba(255, 255, 255, 0.15)' })
    .borderRadius(this.cardRadius)
    .shadow(this.getShadow())
    .scale({ 
      x: this.clickable && this.isPressed ? 0.98 : 1.0, 
      y: this.clickable && this.isPressed ? 0.98 : 1.0 
    })
    .opacity(this.clickable && this.isPressed ? 0.9 : 1.0)
    .animation({ duration: 150, curve: Curve.EaseOut })
    .onTouch((event: TouchEvent) => {
      if (!this.clickable) return;
      if (event.type === TouchType.Down) {
        this.isPressed = true;
      } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
        this.isPressed = false;
      }
    })
    .onClick(() => {
      if (this.clickable && this.onTap) {
        this.onTap();
      }
    })
  }
}

/**
 * 可点击的毛玻璃列表项
 * 
 * 适用于设置页面等场景
 * 
 * 使用示例：
 * ```
 * GlassListItem({
 *   title: '账号与安全',
 *   subtitle: '管理您的账号安全设置',
 *   showArrow: true,
 *   onTap: () => this.goToSecurity()
 * })
 * ```
 */
@ComponentV2
export struct GlassListItem {
  /** 主标题 */
  @Param title: string = '';
  
  /** 副标题（可选） */
  @Param subtitle: string = '';
  
  /** 左侧图标（系统符号名） */
  @Param icon: Resource | null = null;
  
  /** 右侧文字 */
  @Param rightText: string = '';
  
  /** 是否显示右侧箭头 */
  @Param showArrow: boolean = true;
  
  /** 是否危险操作（红色文字） */
  @Param danger: boolean = false;
  
  /** 点击事件 */
  @Event onTap: () => void = () => {};
  
  @Local private isPressed: boolean = false;
  
  build() {
    Row() {
      if (this.icon) {
        SymbolGlyph(this.icon)
          .fontSize(22)
          .fontColor([this.danger ? '#FF4D4F' : Color.White])
          .margin({ right: 12 })
      }
      
      Column({ space: 2 }) {
        Text(this.title)
          .fontSize(16)
          .fontColor(this.danger ? '#FF4D4F' : Color.White)
          .fontWeight(FontWeight.Medium)
        
        if (this.subtitle) {
          Text(this.subtitle)
            .fontSize(12)
            .fontColor('rgba(255, 255, 255, 0.5)')
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      
      if (this.rightText) {
        Text(this.rightText)
          .fontSize(14)
          .fontColor('rgba(255, 255, 255, 0.5)')
          .margin({ right: 8 })
      }
      
      if (this.showArrow) {
        SymbolGlyph($r('sys.symbol.chevron_right'))
          .fontSize(18)
          .fontColor(['rgba(255, 255, 255, 0.4)'])
      }
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor(this.isPressed ? 'rgba(255, 255, 255, 0.08)' : Color.Transparent)
    .backgroundBlurStyle(BlurStyle.Thin)
    .borderRadius(12)
    .scale({ x: this.isPressed ? 0.99 : 1.0, y: this.isPressed ? 0.99 : 1.0 })
    .animation({ duration: 100, curve: Curve.EaseOut })
    .onTouch((event: TouchEvent) => {
      if (event.type === TouchType.Down) {
        this.isPressed = true;
      } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
        this.isPressed = false;
      }
    })
    .onClick(() => {
      if (this.onTap) {
        this.onTap();
      }
    })
  }
}


