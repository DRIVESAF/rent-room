import { ITileItem, ITileList } from '../../model/HomeData'
import { image } from '@kit.ImageKit'

@Component
export default struct TileList {
  @Prop tileList: ITileList

  build() {
    Row({ space: 32 }) {
      ForEach(this.tileList, (tile: ITileItem) => {
        Column({ space: 8 }) {
          Image(tile.imageURL).width(148).height(58).objectFit(ImageFit.Fill)
          Row({ space: 5 }) {
            Text(tile.title).fontSize(12).fontColor($r('app.color.black'))
            Text(tile.sub_title).fontSize(10).fontColor($r('app.color.gray'))
          }
        }
      }, (tile: ITileItem) => tile.id + '')
    }
    .width('100%')
    .margin({ top: 12 })
  }
}