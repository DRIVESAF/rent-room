import { PADDING, PADDING_S } from '../../contants/size'

@Component
export default struct SearchBar {
  build() {
    Row({ space: 16 }) {
      // 左侧定位城市
      Text("北京").fontSize(14).fontColor($r('app.color.white'))
      // 输入框堆叠
      Stack() {
        TextInput()
          .height('100%')
          .width('100%')
          .backgroundColor($r('app.color.white'))
        // 堆叠内容
        Row() {
          Image($r('app.media.search'))
            .width(18)
            .height(18)
          Text('公司/地铁/小区，马上搜索')
            .fontSize(10)
            .fontColor($r('app.color.gray'))
            .layoutWeight(1).margin({ left: PADDING_S, right: PADDING_S })
          Column() {
          }.width(1).backgroundColor($r('app.color.line')).height(18).margin({ right: PADDING_S })

          Image($r('app.media.position'))
            .width(18)
            .height(18)
        }.width('100%').padding({ left: PADDING, right: PADDING })
      }.width(224)

      // 右侧图标
      Image($r('app.media.message')).width(24).height(24)
    }
    .width('100%')
    .height(38)
    .padding({ left: PADDING, right: PADDING }).margin({ top: 4 })
  }
}