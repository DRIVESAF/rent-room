import { IColor } from '../../model/HomeData'

@Component
export default struct Index {
  @BuilderParam navBuilderParam: ($$: IColor) => void = this.customBuilder
  @BuilderParam contentBuilderParam: () => void = this.customBuilder
  scrollY: number = 0;
  @State bgColor: string = 'rgba(255, 255, 255, 0)'
  @State fontColor: string = 'rgb(255, 255, 255)'

  @Builder
  customBuilder() {
  }

  // 处理滚动
  handleScroll = (xOffset: number, yOffset: number) => {
    this.scrollY += yOffset;
    if (this.scrollY < 0) {
      this.scrollY = 0;
    }
    this.calcColor()
  }
  // 计算颜色
  calcColor = () => {
    // 滚动计算的 scrollY 的值到达顶部可能不是 0，给点误差
    if (this.scrollY > 10) {
      this.bgColor = 'rgba(255, 255, 255, 1)'
      this.fontColor = 'rgb(0, 0, 0)'
    } else {
      this.bgColor = 'rgba(255, 255, 255, 0)'
      this.fontColor = 'rgb(255, 255, 255)'
    }
  }

  build() {
    Stack() {
      Scroll() {
        Column() {
          this.contentBuilderParam()
        }
        .justifyContent(FlexAlign.Start)
      }
      .height('100%')
      .align(Alignment.TopStart)
      .scrollBar(BarState.Off)
      .onDidScroll(this.handleScroll)

      // 搜索栏
      // 按引用传递
      this.navBuilderParam({ bgColor: this.bgColor, fontColor: this.fontColor })
    }
    .width('100%')
    .alignContent(Alignment.TopStart)
  }
}