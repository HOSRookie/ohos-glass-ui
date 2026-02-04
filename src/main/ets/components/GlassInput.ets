/**
 * 毛玻璃输入框组件
 * 
 * 功能：
 * - 统一的毛玻璃输入框样式
 * - 支持单行/多行
 * - 字数统计
 * - 聚焦状态视觉反馈
 * 
 * 使用示例：
 * ```
 * GlassInput({
 *   label: '昵称',
 *   placeholder: '请输入昵称',
 *   value: this.displayName,
 *   maxLength: 20,
 *   onChange: (value) => { this.displayName = value }
 * })
 * 
 * // 多行输入
 * GlassInput({
 *   label: '个人简介',
 *   placeholder: '介绍一下自己吧',
 *   value: this.bio,
 *   maxLength: 200,
 *   multiLine: true,
 *   onChange: (value) => { this.bio = value }
 * })
 * ```
 */

@ComponentV2
export struct GlassInput {
  /** 标签文字 */
  @Param label: string = '';
  
  /** 占位文字 */
  @Param placeholder: string = '';
  
  /** 输入值 */
  @Param value: string = '';
  
  /** 最大长度（0 = 不限制） */
  @Param maxLength: number = 0;
  
  /** 是否多行输入 */
  @Param multiLine: boolean = false;
  
  /** 多行输入高度 */
  @Param multiLineHeight: number = 100;
  
  /** 是否只读 */
  @Param readonly: boolean = false;
  
  /** 输入类型 */
  @Param inputType: InputType = InputType.Normal;
  
  /** 值变化事件 */
  @Event onChange: (value: string) => void = () => {};
  
  @Local private isFocused: boolean = false;
  
  private getBorderColor(): ResourceColor {
    if (this.isFocused) {
      return 'rgba(76, 175, 80, 0.6)';
    }
    return 'rgba(255, 255, 255, 0.1)';
  }
  
  build() {
    Column({ space: 8 }) {
      Row() {
        Text(this.label)
          .fontSize(14)
          .fontColor('rgba(255, 255, 255, 0.9)')
          .fontWeight(FontWeight.Medium)
        
        Blank()
        
        if (this.maxLength > 0) {
          Text(`${this.value.length}/${this.maxLength}`)
            .fontSize(12)
            .fontColor(
              this.value.length >= this.maxLength 
                ? '#FF6B6B' 
                : 'rgba(255, 255, 255, 0.5)'
            )
        }
      }
      .width('100%')
      
      if (this.multiLine) {
        TextArea({ text: this.value, placeholder: this.placeholder })
          .width('100%')
          .height(this.multiLineHeight)
          .fontSize(14)
          .fontColor(Color.White)
          .placeholderColor('rgba(255, 255, 255, 0.4)')
          .backgroundColor(Color.Transparent)
          .backgroundBlurStyle(BlurStyle.Thin)
          .borderRadius(12)
          .border({ 
            width: this.isFocused ? 1.5 : 1, 
            color: this.getBorderColor() 
          })
          .padding(12)
          .maxLength(this.maxLength > 0 ? this.maxLength : undefined)
          .enabled(!this.readonly)
          .onFocus(() => { this.isFocused = true; })
          .onBlur(() => { this.isFocused = false; })
          .onChange((newValue: string) => {
            this.onChange(newValue);
          })
          .animation({ duration: 200, curve: Curve.EaseOut })
      } else {
        TextInput({ text: this.value, placeholder: this.placeholder })
          .width('100%')
          .height(48)
          .fontSize(14)
          .fontColor(Color.White)
          .placeholderColor('rgba(255, 255, 255, 0.4)')
          .backgroundColor(Color.Transparent)
          .backgroundBlurStyle(BlurStyle.Thin)
          .borderRadius(12)
          .border({ 
            width: this.isFocused ? 1.5 : 1, 
            color: this.getBorderColor() 
          })
          .padding({ left: 12, right: 12 })
          .maxLength(this.maxLength > 0 ? this.maxLength : undefined)
          .type(this.inputType)
          .enabled(!this.readonly)
          .onFocus(() => { this.isFocused = true; })
          .onBlur(() => { this.isFocused = false; })
          .onChange((newValue: string) => {
            this.onChange(newValue);
          })
          .animation({ duration: 200, curve: Curve.EaseOut })
      }
    }
    .width('100%')
  }
}

/**
 * 毛玻璃选择器组件
 * 
 * 使用示例：
 * ```
 * GlassSelect({
 *   label: '性别',
 *   value: this.gender,
 *   options: ['保密', '男', '女'],
 *   onChange: (value) => { this.gender = value }
 * })
 * ```
 */
@ComponentV2
export struct GlassSelect {
  /** 标签文字 */
  @Param label: string = '';
  
  /** 当前值 */
  @Param value: string = '';
  
  /** 选项列表 */
  @Param options: string[] = [];
  
  /** 值变化事件 */
  @Event onChange: (value: string) => void = () => {};
  
  build() {
    Column({ space: 8 }) {
      Text(this.label)
        .fontSize(14)
        .fontColor('rgba(255, 255, 255, 0.9)')
        .fontWeight(FontWeight.Medium)
        .width('100%')
      
      Select(this.options.map((item: string) => ({ value: item } as SelectOption)))
        .selected(this.options.indexOf(this.value) >= 0 ? this.options.indexOf(this.value) : 0)
        .value(this.value || this.options[0])
        .font({ size: 14 })
        .fontColor(Color.White)
        .selectedOptionFont({ size: 14 })
        .optionFont({ size: 14 })
        .width('100%')
        .height(48)
        .backgroundColor(Color.Transparent)
        .backgroundBlurStyle(BlurStyle.Thin)
        .borderRadius(12)
        .border({ width: 1, color: 'rgba(255, 255, 255, 0.1)' })
        .onSelect((index: number) => {
          this.onChange(this.options[index]);
        })
    }
    .width('100%')
  }
}

/**
 * 毛玻璃只读字段组件
 * 
 * 使用示例：
 * ```
 * GlassReadonlyField({
 *   label: '用户ID',
 *   value: this.uid
 * })
 * ```
 */
@ComponentV2
export struct GlassReadonlyField {
  /** 标签文字 */
  @Param label: string = '';
  
  /** 显示值 */
  @Param value: string = '';
  
  /** 占位文字（值为空时显示） */
  @Param placeholder: string = '-';
  
  build() {
    Row() {
      Text(this.label)
        .fontSize(14)
        .fontColor('rgba(255, 255, 255, 0.7)')
      
      Blank()
      
      Text(this.value || this.placeholder)
        .fontSize(14)
        .fontColor('rgba(255, 255, 255, 0.5)')
    }
    .width('100%')
    .height(48)
    .padding({ left: 0, right: 0 })
  }
}

