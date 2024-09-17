import { getRoomRecommendListApi } from '../../api/home'
import { IRoomRecommendList } from '../../models/HomeData'

@Component
export default struct RoomRecommend {
  @State roomRecommendList: IRoomRecommendList = []
  // 获取房源推荐列表
  getRoomRecommendList = async () => {
    await getRoomRecommendListApi()
  }

  aboutToAppear(): void {
  }

  build() {
    Column() {
      Text("RoomRecommend");
    }
    .width('100%')
    .height('100%')
  }
}